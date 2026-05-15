import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/services/storage_service.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService(ref.watch(storageServiceProvider));
});

class FirebaseService {
  final StorageService _storage;
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  FirebaseService(this._storage);

  String _generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // No O, 0, I, 1 to avoid confusion
    final rnd = Random();
    return String.fromCharCodes(Iterable.generate(
      5, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))
    ));
  }

  Future<String> uploadTeam(int localTeamId) async {
    print('Starting cloud upload for team $localTeamId...');
    final teamList = await _storage.getTeams();
    final localTeam = teamList.firstWhere((t) => t.id == localTeamId);
    
    final lineup = await _storage.getLineup(localTeamId);
    print('Lineup loaded, generating code...');
    
    // Check if team already has a code
    String code = localTeam.cloudCode ?? _generateCode();
    print('Using cloud code: $code');
    
    final teamData = {
      'name': localTeam.name,
      'lastUpdated': ServerValue.timestamp,
      'slots': {
        for (final s in lineup)
          '${s.lineIndex}_${s.slot}': {
            'lineIndex': s.lineIndex,
            'slot': s.slot,
            'playerId': s.playerId,
            'roleTag': s.roleTag,
          }
      },
    };

    try {
      print('Sending data to Firebase path: teams/$code');
      await _db.ref('teams/$code').set(teamData);
      print('Firebase upload successful!');
      
      if (localTeam.cloudCode == null) {
        await _storage.updateTeamCloudCode(localTeamId, code);
      }
      return code;
    } catch (e) {
      print('FIREBASE ERROR: $e');
      rethrow;
    }
  }

  Future<int?> downloadTeam(String code) async {
    print('Downloading team with code: $code');
    try {
      final snapshot = await _db.ref('teams/$code').get();
      if (!snapshot.exists) {
        print('Team not found in cloud.');
        return null;
      }
      print('Team data found, parsing...');
      final data = snapshot.value as Map<dynamic, dynamic>;
      final name = data['name'] as String;
      final slots = data['slots'] as Map<dynamic, dynamic>;

      // Create local team
      final newTeamId = await _storage.createTeam(name, cloudCode: code);

      // Save slots locally
      for (final entry in slots.entries) {
        final map = entry.value as Map<dynamic, dynamic>;
        await _storage.saveLineupSlot(
          newTeamId,
          map['lineIndex'] as int,
          map['slot'] as String,
          map['playerId'] as int,
          tag: map['roleTag'] as String?,
        );
      }

      return newTeamId;
    } catch (e) {
      print('DOWNLOAD ERROR: $e');
      return null;
    }
  }

  Future<void> syncSlot(String code, int lineIdx, String slot, int pId, {String? tag}) async {
    final slotData = {
      'lineIndex': lineIdx,
      'slot': slot,
      'playerId': pId,
      'roleTag': tag,
    };

    // We need to find the slot index in the list or just use a map for slots in Firebase
    // Using a map is better for granular updates: teams/CODE/slots/LINE_SLOT
    final path = 'teams/$code/slots/${lineIdx}_$slot';
    await _db.ref(path).set(slotData);
    await _db.ref('teams/$code/lastUpdated').set(ServerValue.timestamp);
  }

  Future<void> removeSlot(String code, int lineIdx, String slot) async {
    final path = 'teams/$code/slots/${lineIdx}_$slot';
    await _db.ref(path).remove();
    await _db.ref('teams/$code/lastUpdated').set(ServerValue.timestamp);
  }
}
