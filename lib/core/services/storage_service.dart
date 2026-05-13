import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/data/mock_data.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(ref.watch(databaseProvider));
});

class StorageService {
  final AppDatabase _db;
  final List<Player> _localState = List.from(mockPlayers);

  StorageService(this._db);

  Future<List<Player>> getAllPlayers() async {
    try {
      final players = await _db.getAllPlayers();
      if (players.isEmpty) return _localState;
      return players;
    } catch (e) {
      return _localState;
    }
  }

  Future<List<Player>> searchPlayers(String query) async {
    try {
      return await _db.searchPlayers(query);
    } catch (e) {
      final q = query.toLowerCase();
      return _localState.where((p) => 
        p.firstName.toLowerCase().contains(q) || 
        p.lastName.toLowerCase().contains(q)
      ).toList();
    }
  }

  Future<void> toggleFavorite(Player player) async {
    try {
      await _db.updatePlayer(player.copyWith(isFavorite: !player.isFavorite));
    } catch (e) {
      final index = _localState.indexWhere((p) => p.id == player.id);
      if (index != -1) {
        _localState[index] = player.copyWith(isFavorite: !player.isFavorite);
      }
    }
  }

  Future<List<LineupSlot>> getLineup() async {
    try {
      return await _db.getLineup();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveLineupSlot(int lineIdx, String posSlot, int pId) async {
    try {
      await _db.saveLineupSlot(lineIdx, posSlot, pId);
    } catch (e) {}
  }

  Future<void> removeLineupSlot(int lineIdx, String posSlot) async {
    try {
      await _db.removeLineupSlot(lineIdx, posSlot);
    } catch (e) {}
  }

  Future<void> seedMockData() async {
    try {
      await _db.getAllPlayers();
    } catch (e) {}
  }
}
