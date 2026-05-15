import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/services/storage_service.dart';
import 'package:puckey/core/services/firebase_service.dart';

class LineupState {
  final Map<int, Map<String, Player>> slots;
  final Map<int, Map<String, String?>> tags;

  LineupState({this.slots = const {}, this.tags = const {}});

  LineupState copyWith({
    Map<int, Map<String, Player>>? slots,
    Map<int, Map<String, String?>>? tags,
  }) {
    return LineupState(
      slots: slots ?? this.slots,
      tags: tags ?? this.tags,
    );
  }

  Player? getPlayer(int lineIndex, String slot) {
    return slots[lineIndex]?[slot];
  }

  String? getTag(int lineIndex, String slot) {
    return tags[lineIndex]?[slot];
  }

  bool isPlayerInLineup(int id) {
    for (var line in slots.values) {
      for (var player in line.values) {
        if (player.id == id) return true;
      }
    }
    return false;
  }
}

class LineupNotifier extends StateNotifier<AsyncValue<LineupState>> {
  final StorageService _storage;
  final Ref _ref;
  final int _teamId;

  LineupNotifier(this._storage, this._ref, this._teamId) : super(const AsyncValue.loading()) {
    _loadLineup();
  }

  Future<void> _loadLineup() async {
    try {
      final savedSlots = await _storage.getLineup(_teamId);
      final allPlayers = await _storage.getAllPlayers();
      
      final playerMap = {for (var p in allPlayers) p.id: p};
      
      final Map<int, Map<String, Player>> slots = {};
      final Map<int, Map<String, String?>> tags = {};
      
      for (final slot in savedSlots) {
        final player = playerMap[slot.playerId];
        if (player != null) {
          slots.putIfAbsent(slot.lineIndex, () => {});
          slots[slot.lineIndex]![slot.slot] = player;
          
          tags.putIfAbsent(slot.lineIndex, () => {});
          tags[slot.lineIndex]![slot.slot] = slot.roleTag;
        }
      }
      
      state = AsyncValue.data(LineupState(slots: slots, tags: tags));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> setPlayer(int lineIndex, String slot, Player? player) async {
    final currentState = state.value;
    if (currentState == null) return;

    final newSlots = Map<int, Map<String, Player>>.from(
      currentState.slots.map((k, v) => MapEntry(k, Map<String, Player>.from(v)))
    );
    newSlots.putIfAbsent(lineIndex, () => {});

    if (player == null) {
      newSlots[lineIndex]!.remove(slot);
      await _storage.removeLineupSlot(_teamId, lineIndex, slot);
      _syncRemove(lineIndex, slot);
    } else {
      newSlots[lineIndex]![slot] = player;
      await _storage.saveLineupSlot(_teamId, lineIndex, slot, player.id);
      _syncSlot(lineIndex, slot, player.id, tag: currentState.tags[lineIndex]?[slot]);
    }

    state = AsyncValue.data(currentState.copyWith(slots: newSlots));
  }

  Future<void> updateTag(int lineIndex, String slot, String? tag) async {
    final currentState = state.value;
    if (currentState == null) return;

    final newTags = Map<int, Map<String, String?>>.from(
      currentState.tags.map((k, v) => MapEntry(k, Map<String, String?>.from(v)))
    );
    newTags.putIfAbsent(lineIndex, () => {});
    newTags[lineIndex]![slot] = tag;

    await _storage.updateSlotTag(_teamId, lineIndex, slot, tag);
    final player = currentState.slots[lineIndex]?[slot];
    if (player != null) {
      _syncSlot(lineIndex, slot, player.id, tag: tag);
    }

    state = AsyncValue.data(currentState.copyWith(tags: newTags));
  }

  Future<void> _syncSlot(int lineIdx, String slot, int pId, {String? tag}) async {
    final teams = await _storage.getTeams();
    final team = teams.firstWhere((t) => t.id == _teamId);
    if (team.cloudCode != null) {
      _ref.read(firebaseServiceProvider).syncSlot(team.cloudCode!, lineIdx, slot, pId, tag: tag);
    }
  }

  Future<void> _syncRemove(int lineIdx, String slot) async {
    final teams = await _storage.getTeams();
    final team = teams.firstWhere((t) => t.id == _teamId);
    if (team.cloudCode != null) {
      _ref.read(firebaseServiceProvider).removeSlot(team.cloudCode!, lineIdx, slot);
    }
  }
}

final selectedTeamIdProvider = StateProvider<int>((ref) => 1);

final teamsProvider = FutureProvider<List<Team>>((ref) {
  return ref.watch(storageServiceProvider).getTeams();
});

final lineupProvider = StateNotifierProvider<LineupNotifier, AsyncValue<LineupState>>((ref) {
  final storage = ref.watch(storageServiceProvider);
  final teamId = ref.watch(selectedTeamIdProvider);
  return LineupNotifier(storage, ref, teamId);
});
