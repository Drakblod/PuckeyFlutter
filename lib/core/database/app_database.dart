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

class LineupSlots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lineIndex => integer()(); // 0-3 for lines 1-4, 4 for goalies
  TextColumn get slot => text()(); // LW, C, RW, LD, RD, G1, G2
  IntColumn get playerId => integer().references(Players, #id)();
}

@DriftDatabase(tables: [Players, LineupSlots])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 2; // Bump schema version
  
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(lineupSlots);
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

  // Lineup methods
  Future<List<LineupSlot>> getLineup() => select(lineupSlots).get();
  
  Future<void> saveLineupSlot(int lineIdx, String posSlot, int pId) async {
    await (delete(lineupSlots)
          ..where((t) => t.lineIndex.equals(lineIdx) & t.slot.equals(posSlot)))
        .go();
    await into(lineupSlots).insert(LineupSlotsCompanion.insert(
      lineIndex: lineIdx,
      slot: posSlot,
      playerId: pId,
    ));
  }

  Future<void> removeLineupSlot(int lineIdx, String posSlot) async {
    await (delete(lineupSlots)
          ..where((t) => t.lineIndex.equals(lineIdx) & t.slot.equals(posSlot)))
        .go();
  }
}

extension PlayerExtension on Player {
  String get fullName => '$firstName $lastName';
}
