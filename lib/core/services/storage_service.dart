import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';

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

  StorageService(this._db);

  Future<List<Player>> getAllPlayers() => _db.getAllPlayers();

  Future<List<Player>> searchPlayers(String query) => _db.searchPlayers(query);

  Future<void> toggleFavorite(Player player) async {
    await _db.updatePlayer(player.copyWith(isFavorite: !player.isFavorite));
  }

  Future<void> seedMockData() async {
    final players = await _db.getAllPlayers();
    if (players.isNotEmpty) return;

    final shlData = [
      ['Oscar', 'Lindberg', 'Skellefteå AIK', 'F', 37, 52, 30, 37, 67, 15],
      ['Rickard', 'Hugg', 'Skellefteå AIK', 'F', 26, 52, 20, 36, 56, 12],
      ['Jonathan', 'Dahlén', 'Timrå IK', 'F', 28, 50, 30, 25, 55, 8],
      ['Patrik', 'Karlkvist', 'Örebro Hockey', 'F', 33, 52, 15, 35, 50, 5],
      ['Lucas', 'Elvenes', 'Växjö Lakers', 'F', 26, 51, 12, 38, 50, 10],
      ['Robin', 'Kovacs', 'Linköping HC', 'F', 30, 50, 23, 24, 47, 8],
      ['Jonathan', 'Pudas', 'Skellefteå AIK', 'D', 31, 48, 16, 31, 47, 22],
      ['Jonathan', 'Ang', 'HV71', 'F', 27, 52, 21, 25, 46, 2],
      ['Emil', 'Pettersson', 'Timrå IK', 'F', 32, 51, 15, 31, 46, 10],
      ['Viktor', 'Lodin', 'Färjestad BK', 'F', 26, 49, 12, 34, 46, 14],
      ['Janne', 'Kuokkanen', 'Malmö Redhawks', 'F', 27, 48, 13, 32, 45, 6],
      ['David', 'Quenneville', 'Örebro Hockey', 'D', 27, 52, 16, 28, 44, 4],
      ['Joel', 'Persson', 'Växjö Lakers', 'D', 32, 48, 8, 36, 44, 18],
      ['Mikkel', 'Aagaard', 'Skellefteå AIK', 'F', 30, 50, 20, 23, 43, 10],
      ['Jakob', 'Silfverberg', 'Brynäs IF', 'F', 35, 52, 20, 23, 43, 12],
      ['Carl', 'Persson', 'Malmö Redhawks', 'F', 30, 49, 23, 18, 41, 8],
      ['Johannes', 'Kinnvall', 'Brynäs IF', 'D', 28, 51, 12, 29, 41, 6],
      ['Jere', 'Innala', 'Frölunda HC', 'F', 28, 48, 22, 18, 40, 15],
      ['Felix', 'Nilsson', 'Rögle BK', 'F', 21, 52, 14, 26, 40, 5],
      ['Joey', 'LaLeggia', 'Djurgårdens IF', 'D', 33, 50, 13, 27, 40, 4],
      ['Robin', 'Salo', 'Malmö Redhawks', 'D', 27, 52, 7, 33, 40, 2],
      ['Joe', 'Snively', 'Djurgårdens IF', 'F', 27, 52, 15, 24, 39, 10],
      ['Lauri', 'Pajuniemi', 'Malmö Redhawks', 'F', 26, 51, 16, 22, 38, 4],
      ['Fredrik', 'Olofsson', 'Rögle BK', 'F', 29, 52, 12, 26, 38, 12],
      ['Dennis', 'Rasmussen', 'Växjö Lakers', 'F', 35, 52, 20, 17, 37, 14],
      ['Arttu', 'Ruotsalainen', 'Frölunda HC', 'F', 28, 50, 15, 21, 36, 8],
      ['Patrik', 'Puistola', 'Örebro Hockey', 'F', 25, 50, 14, 22, 36, 6],
      ['Brogan', 'Rafferty', 'Växjö Lakers', 'D', 31, 48, 12, 24, 36, 15],
      ['Brian', 'O\'Neill', 'Luleå Hockey', 'F', 37, 50, 11, 25, 36, 12],
      ['Axel', 'Rindell', 'HV71', 'D', 25, 52, 10, 26, 36, -5],
      ['Luke', 'Philp', 'Färjestad BK', 'F', 30, 52, 13, 22, 35, 10],
      ['Calle', 'Själin', 'Rögle BK', 'D', 26, 48, 7, 28, 35, 12],
      ['Henrik', 'Tömmernes', 'Frölunda HC', 'D', 33, 52, 6, 29, 35, 20],
      ['Axel', 'Sundberg', 'Malmö Redhawks', 'F', 27, 49, 14, 20, 34, 5],
      ['Kalle', 'Kossila', 'Örebro Hockey', 'F', 33, 43, 11, 23, 34, 15],
      ['Anton', 'Rödin', 'Brynäs IF', 'F', 35, 48, 11, 23, 34, 8],
      ['Max', 'Lindholm', 'Frölunda HC', 'F', 28, 52, 17, 16, 33, 12],
      ['Ivar', 'Stenberg', 'Frölunda HC', 'F', 18, 43, 11, 22, 33, 10],
      ['Markus', 'Nurmi', 'Luleå Hockey', 'F', 27, 51, 15, 17, 32, 6],
      ['Theodor', 'Niederbach', 'Frölunda HC', 'F', 24, 52, 13, 19, 32, 4],
      ['Eskild', 'Bakke Olsen', 'Linköping HC', 'F', 24, 51, 11, 21, 32, 2],
      ['Frédéric', 'Allard', 'Luleå Hockey', 'D', 28, 50, 7, 25, 32, 8],
      ['Riley', 'Woods', 'HV71', 'F', 27, 48, 16, 15, 31, -2],
      ['Charles', 'Hudon', 'Djurgårdens IF', 'F', 32, 40, 15, 16, 31, 5],
      ['Lukas', 'Rousek', 'HV71', 'F', 26, 52, 3, 28, 31, -10],
      ['Reid', 'Gardiner', 'Växjö Lakers', 'F', 30, 49, 15, 15, 30, 12],
      ['Kieffer', 'Bellows', 'Brynäs IF', 'F', 27, 52, 15, 15, 30, 8],
      ['Johan', 'Larsson', 'Brynäs IF', 'F', 33, 51, 12, 18, 30, 14],
      ['Jonathan', 'Johnson', 'Skellefteå AIK', 'F', 33, 52, 9, 21, 30, 10],
      ['Nicklas', 'Bäckström', 'Brynäs IF', 'F', 38, 45, 3, 27, 30, 5],
    ];

    for (final data in shlData) {
      await _db.addPlayer(
        PlayersCompanion.insert(
          firstName: data[0] as String,
          lastName: data[1] as String,
          team: data[2] as String,
          position: data[3] as String,
          age: data[4] as int,
          gamesPlayed: Value(data[5] as int),
          goals: Value(data[6] as int),
          assists: Value(data[7] as int),
          points: Value(data[8] as int),
          plusMinus: Value(data[9] as int),
          league: 'SHL',
        ),
      );
    }
  }

    }
  }
}
