import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/services/storage_service.dart';

class LineupState {
  final Map<int, Map<String, Player>> slots;

  LineupState({this.slots = const {}});

  LineupState copyWith({Map<int, Map<String, Player>>? slots}) {
    return LineupState(slots: slots ?? this.slots);
  }

  Player? getPlayer(int lineIndex, String slot) {
    return slots[lineIndex]?[slot];
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

  LineupNotifier(this._storage) : super(const AsyncValue.loading()) {
    _loadLineup();
  }

  Future<void> _loadLineup() async {
    try {
      final savedSlots = await _storage.getLineup();
      final allPlayers = await _storage.getAllPlayers();
      
      final playerMap = {for (var p in allPlayers) p.id: p};
      
      final Map<int, Map<String, Player>> slots = {};
      
      for (final slot in savedSlots) {
        final player = playerMap[slot.playerId];
        if (player != null) {
          slots.putIfAbsent(slot.lineIndex, () => {});
          slots[slot.lineIndex]![slot.slot] = player;
        }
      }
      
      state = AsyncValue.data(LineupState(slots: slots));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> setPlayer(int lineIndex, String slot, Player? player) async {
    final currentState = state.value;
    if (currentState == null) return;

    final newSlots = Map<int, Map<String, Player>>.from(currentState.slots);
    newSlots.putIfAbsent(lineIndex, () => {});

    if (player == null) {
      newSlots[lineIndex]!.remove(slot);
      await _storage.removeLineupSlot(lineIndex, slot);
    } else {
      newSlots[lineIndex]![slot] = player;
      await _storage.saveLineupSlot(lineIndex, slot, player.id);
    }

    state = AsyncValue.data(currentState.copyWith(slots: newSlots));
  }
}

final lineupProvider = StateNotifierProvider<LineupNotifier, AsyncValue<LineupState>>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return LineupNotifier(storage);
});
