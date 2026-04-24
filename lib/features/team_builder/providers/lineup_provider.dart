import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';

class LineupState {
  final Player? leftWing;
  final Player? center;
  final Player? rightWing;
  final Player? leftDefense;
  final Player? rightDefense;
  final Player? goalie;

  LineupState({
    this.leftWing,
    this.center,
    this.rightWing,
    this.leftDefense,
    this.rightDefense,
    this.goalie,
  });

  LineupState copyWith({
    Player? Function()? leftWing,
    Player? Function()? center,
    Player? Function()? rightWing,
    Player? Function()? leftDefense,
    Player? Function()? rightDefense,
    Player? Function()? goalie,
  }) {
    return LineupState(
      leftWing: leftWing != null ? leftWing() : this.leftWing,
      center: center != null ? center() : this.center,
      rightWing: rightWing != null ? rightWing() : this.rightWing,
      leftDefense: leftDefense != null ? leftDefense() : this.leftDefense,
      rightDefense: rightDefense != null ? rightDefense() : this.rightDefense,
      goalie: goalie != null ? goalie() : this.goalie,
    );
  }
}

class LineupNotifier extends StateNotifier<LineupState> {
  LineupNotifier() : super(LineupState());

  void setPlayer(String slot, Player? player) {
    switch (slot) {
      case 'LW':
        state = state.copyWith(leftWing: () => player);
        break;
      case 'C':
        state = state.copyWith(center: () => player);
        break;
      case 'RW':
        state = state.copyWith(rightWing: () => player);
        break;
      case 'LD':
        state = state.copyWith(leftDefense: () => player);
        break;
      case 'RD':
        state = state.copyWith(rightDefense: () => player);
        break;
      case 'G':
        state = state.copyWith(goalie: () => player);
        break;
    }
  }

  bool isPlayerInLineup(int id) {
    return state.leftWing?.id == id ||
        state.center?.id == id ||
        state.rightWing?.id == id ||
        state.leftDefense?.id == id ||
        state.rightDefense?.id == id ||
        state.goalie?.id == id;
  }
}

final lineupProvider = StateNotifierProvider<LineupNotifier, LineupState>((ref) {
  return LineupNotifier();
});
