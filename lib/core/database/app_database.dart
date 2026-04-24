import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

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

@DriftDatabase(tables: [Players])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Player>> getAllPlayers() => select(players).get();
  
  Stream<List<Player>> watchAllPlayers() => select(players).watch();

  Future<int> addPlayer(PlayersCompanion entry) => into(players).insert(entry);
  
  Future<void> updatePlayer(Player player) => update(players).replace(player);

  Future<List<Player>> searchPlayers(String query) {
    return (select(players)
          ..where((t) => t.firstName.contains(query) | t.lastName.contains(query)))
        .get();
  }
}

extension PlayerExtension on Player {
  String get fullName => '$firstName $lastName';
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'puckey.db'));

    if (Platform.isAndroid) {
      // The workaround is often no longer needed on modern Android, but can be added if issues arise.
    }

    final cachebase = await getTemporaryDirectory();
    sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
