import 'dart:convert';
import 'package:flutter/services.dart';
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
  final List<Player> _localState = [];
  final List<Team> _localTeams = [
    Team(id: 1, name: 'Default Team', createdAt: DateTime.now())
  ];
  final List<LineupSlot> _localLineup = [];
  bool _isInitialized = false;

  StorageService(this._db);

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      final String skatersJson = await rootBundle.loadString('assets/players_shl_ha_echl_2526.json');
      final List<dynamic> skatersData = jsonDecode(skatersJson);
      
      final String goaliesJson = await rootBundle.loadString('assets/goalies.json');
      final List<dynamic> goaliesData = jsonDecode(goaliesJson);

      final List<Player> players = [];
      int currentId = 1;

      // Add Skaters
      for (final map in skatersData) {
        players.add(Player(
          id: currentId++,
          firstName: map['firstName'] ?? '',
          lastName: map['lastName'] ?? '',
          team: map['team'] ?? '',
          position: map['position'] ?? '',
          age: 0,
          gamesPlayed: map['games'] ?? 0,
          goals: map['goals'] ?? 0,
          assists: map['assists'] ?? 0,
          points: map['points'] ?? 0,
          plusMinus: 0,
          penaltyMinutes: 0,
          league: map['league'] ?? '',
          isFavorite: false,
        ));
      }

      // Add Goalies
      for (final map in goaliesData) {
        players.add(Player(
          id: currentId++,
          firstName: map['firstName'] ?? '',
          lastName: map['lastName'] ?? '',
          team: map['team'] ?? '',
          position: 'G', // Ensure position is G
          age: 0,
          gamesPlayed: map['games'] ?? 0,
          goals: 0,
          assists: map['assists'] ?? 0,
          points: map['assists'] ?? 0,
          plusMinus: 0,
          penaltyMinutes: 0,
          league: map['league'] ?? '',
          isFavorite: false,
        ));
      }

      _localState.clear();
      _localState.addAll(players);

      // Try to seed the real DB
      try {
        final existing = await _db.getAllPlayers();
        if (existing.isEmpty) {
          for (final p in players) {
            await _db.addPlayer(PlayersCompanion.insert(
              firstName: p.firstName,
              lastName: p.lastName,
              team: p.team,
              position: p.position,
              age: p.age,
              gamesPlayed: Value(p.gamesPlayed),
              goals: Value(p.goals),
              assists: Value(p.assists),
              points: Value(p.points),
              plusMinus: Value(p.plusMinus),
              league: p.league,
            ));
          }
        }
      } catch (e) {}
      
      _isInitialized = true;
    } catch (e) {
      print('Error loading data: $e');
      _localState.addAll(mockPlayers);
      _isInitialized = true;
    }
  }

  Future<List<Player>> getAllPlayers() async {
    await initialize();
    try {
      final players = await _db.getAllPlayers();
      if (players.isEmpty) return _localState;
      return players;
    } catch (e) {
      return _localState;
    }
  }

  Future<List<Player>> searchPlayers(String query) async {
    await initialize();
    try {
      return await _db.searchPlayers(query);
    } catch (e) {
      final q = query.toLowerCase();
      return _localState.where((p) => 
        p.firstName.toLowerCase().contains(q) || 
        p.lastName.toLowerCase().contains(q) ||
        p.team.toLowerCase().contains(q)
      ).toList();
    }
  }

  Future<void> toggleFavorite(Player player) async {
    await initialize();
    try {
      await _db.updatePlayer(player.copyWith(isFavorite: !player.isFavorite));
    } catch (e) {
      final index = _localState.indexWhere((p) => p.id == player.id);
      if (index != -1) {
        _localState[index] = player.copyWith(isFavorite: !player.isFavorite);
      }
    }
  }

  // Team methods
  Future<List<Team>> getTeams() async {
    await initialize();
    try {
      final teams = await _db.getTeams();
      if (teams.isEmpty) return _localTeams;
      return teams;
    } catch (e) {
      return _localTeams;
    }
  }

  Future<int> createTeam(String name) async {
    await initialize();
    try {
      return await _db.createTeam(name);
    } catch (e) {
      final newId = _localTeams.length + 1;
      _localTeams.add(Team(id: newId, name: name, createdAt: DateTime.now()));
      return newId;
    }
  }

  Future<void> deleteTeam(int id) async {
    await initialize();
    try {
      await _db.deleteTeam(id);
    } catch (e) {
      _localTeams.removeWhere((t) => t.id == id);
      _localLineup.removeWhere((l) => l.teamId == id);
    }
  }

  // Lineup methods
  Future<List<LineupSlot>> getLineup(int teamId) async {
    await initialize();
    try {
      return await _db.getLineup(teamId);
    } catch (e) {
      return _localLineup.where((l) => l.teamId == teamId).toList();
    }
  }

  Future<void> saveLineupSlot(int teamId, int lineIdx, String posSlot, int pId, {String? tag}) async {
    await initialize();
    try {
      await _db.saveLineupSlot(teamId, lineIdx, posSlot, pId, tag: tag);
    } catch (e) {
      _localLineup.removeWhere((t) => t.teamId == teamId && t.lineIndex == lineIdx && t.slot == posSlot);
      _localLineup.add(LineupSlot(
        id: _localLineup.length + 1,
        teamId: teamId,
        lineIndex: lineIdx,
        slot: posSlot,
        playerId: pId,
        roleTag: tag,
      ));
    }
  }

  Future<void> removeLineupSlot(int teamId, int lineIdx, String posSlot) async {
    await initialize();
    try {
      await _db.removeLineupSlot(teamId, lineIdx, posSlot);
    } catch (e) {
      _localLineup.removeWhere((t) => t.teamId == teamId && t.lineIndex == lineIdx && t.slot == posSlot);
    }
  }

  Future<void> updateSlotTag(int teamId, int lineIdx, String posSlot, String? tag) async {
    await initialize();
    try {
      await _db.updateSlotTag(teamId, lineIdx, posSlot, tag);
    } catch (e) {
      final index = _localLineup.indexWhere((t) => t.teamId == teamId && t.lineIndex == lineIdx && t.slot == posSlot);
      if (index != -1) {
        final existing = _localLineup[index];
        _localLineup[index] = LineupSlot(
          id: existing.id,
          teamId: existing.teamId,
          lineIndex: existing.lineIndex,
          slot: existing.slot,
          playerId: existing.playerId,
          roleTag: tag,
        );
      }
    }
  }
}
