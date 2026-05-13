import 'package:drift/drift.dart';
import 'package:puckey/core/database/connection/connection.dart';

part 'app_database.g.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().withLength(min: 1, max: 50)();
  TextColumn get lastName => text().withLength(min: 1, max: 50)();
  TextColumn get team => text()();
  TextColumn get position => text()(); // F, D, G
  IntColumn get age => integer()();
  
  // Stats
  IntColumn get gamesPlayed => integer().withDefault(const Constant(0))();
  IntColumn get goals => integer().withDefault(const Constant(0))();
  IntColumn get assists => integer().withDefault(const Constant(0))();
  IntColumn get points => integer().withDefault(const Constant(0))();
  IntColumn get plusMinus => integer().withDefault(const Constant(0))();
  IntColumn get penaltyMinutes => integer().withDefault(const Constant(0))();
  
  // Metadata
  TextColumn get league => text()();
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}

class Teams extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class LineupSlots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get teamId => integer().references(Teams, #id).withDefault(const Constant(1))();
  IntColumn get lineIndex => integer()(); // 0-3 for lines 1-4, 4 for goalies
  TextColumn get slot => text()(); // LW, C, RW, LD, RD, G1, G2
  IntColumn get playerId => integer().references(Players, #id)();
  TextColumn get roleTag => text().nullable()();
}

@DriftDatabase(tables: [Players, LineupSlots, Teams])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 3;
  
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Create a default team
        await into(teams).insert(TeamsCompanion.insert(name: 'Default Team'));
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(lineupSlots);
        }
        if (from < 3) {
          await m.createTable(teams);
          await m.addColumn(lineupSlots, lineupSlots.teamId);
          await m.addColumn(lineupSlots, lineupSlots.roleTag);
          // Create a default team if not exists
          await into(teams).insert(TeamsCompanion.insert(name: 'Default Team'));
        }
      },
    );
  }

  Future<List<Player>> getAllPlayers() => select(players).get();
  
  Stream<List<Player>> watchAllPlayers() => select(players).watch();

  Future<int> addPlayer(PlayersCompanion entry) => into(players).insert(entry);
  
  Future<void> updatePlayer(Player player) => update(players).replace(player);

  Future<List<Player>> searchPlayers(String query) {
    return (select(players)
          ..where((t) => t.firstName.contains(query) | t.lastName.contains(query)))
        .get();
  }

  // Team methods
  Future<List<Team>> getTeams() => select(teams).get();
  Future<int> createTeam(String name) => into(teams).insert(TeamsCompanion.insert(name: name));
  Future<void> deleteTeam(int id) async {
    await (delete(lineupSlots)..where((t) => t.teamId.equals(id))).go();
    await (delete(teams)..where((t) => t.id.equals(id))).go();
  }

  // Lineup methods
  Future<List<LineupSlot>> getLineup(int teamId) => 
    (select(lineupSlots)..where((t) => t.teamId.equals(teamId))).get();
  
  Future<void> saveLineupSlot(int teamId, int lineIdx, String posSlot, int pId, {String? tag}) async {
    await (delete(lineupSlots)
          ..where((t) => t.teamId.equals(teamId) & t.lineIndex.equals(lineIdx) & t.slot.equals(posSlot)))
        .go();
    await into(lineupSlots).insert(LineupSlotsCompanion.insert(
      teamId: Value(teamId),
      lineIndex: lineIdx,
      slot: posSlot,
      playerId: pId,
      roleTag: Value(tag),
    ));
  }

  Future<void> removeLineupSlot(int teamId, int lineIdx, String posSlot) async {
    await (delete(lineupSlots)
          ..where((t) => t.teamId.equals(teamId) & t.lineIndex.equals(lineIdx) & t.slot.equals(posSlot)))
        .go();
  }

  Future<void> updateSlotTag(int teamId, int lineIdx, String posSlot, String? tag) async {
    await (update(lineupSlots)
      ..where((t) => t.teamId.equals(teamId) & t.lineIndex.equals(lineIdx) & t.slot.equals(posSlot)))
      .write(LineupSlotsCompanion(roleTag: Value(tag)));
  }
}

extension PlayerExtension on Player {
  String get fullName => '$firstName $lastName';
}
