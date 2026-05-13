import 'package:puckey/core/database/app_database.dart';

final List<Player> mockPlayers = [
  // SHL Players
  Player(id: 101, firstName: 'David', lastName: 'Tomasek', team: 'Färjestad BK', position: 'F', age: 29, gamesPlayed: 52, goals: 32, assists: 40, points: 72, plusMinus: 18, penaltyMinutes: 10, league: 'SHL', isFavorite: false),
  Player(id: 102, firstName: 'Oscar', lastName: 'Lindberg', team: 'Skellefteå AIK', position: 'F', age: 34, gamesPlayed: 50, goals: 25, assists: 42, points: 67, plusMinus: 16, penaltyMinutes: 8, league: 'SHL', isFavorite: false),
  Player(id: 103, firstName: 'Ty', lastName: 'Rattie', team: 'Linköping HC', position: 'F', age: 33, gamesPlayed: 52, goals: 28, assists: 35, points: 63, plusMinus: 10, penaltyMinutes: 12, league: 'SHL', isFavorite: false),
  Player(id: 104, firstName: 'Jonathan', lastName: 'Dahlén', team: 'Timrå IK', position: 'F', age: 28, gamesPlayed: 49, goals: 29, assists: 32, points: 61, plusMinus: 5, penaltyMinutes: 6, league: 'SHL', isFavorite: false),
  Player(id: 105, firstName: 'Linus', lastName: 'Omark', team: 'Luleå Hockey', position: 'F', age: 38, gamesPlayed: 51, goals: 15, assists: 45, points: 60, plusMinus: 8, penaltyMinutes: 20, league: 'SHL', isFavorite: false),
  Player(id: 106, firstName: 'Marcus', lastName: 'Sylvegård', team: 'Växjö Lakers', position: 'F', age: 26, gamesPlayed: 52, goals: 30, assists: 25, points: 55, plusMinus: 20, penaltyMinutes: 14, league: 'SHL', isFavorite: false),
  Player(id: 107, firstName: 'Jonathan', lastName: 'Pudas', team: 'Skellefteå AIK', position: 'D', age: 32, gamesPlayed: 51, goals: 12, assists: 38, points: 50, plusMinus: 22, penaltyMinutes: 10, league: 'SHL', isFavorite: false),
  Player(id: 108, firstName: 'Joel', lastName: 'Persson', team: 'Växjö Lakers', position: 'D', age: 32, gamesPlayed: 51, goals: 8, assists: 34, points: 42, plusMinus: 18, penaltyMinutes: 4, league: 'SHL', isFavorite: false),
  Player(id: 109, firstName: 'Emil', lastName: 'Larmi', team: 'Växjö Lakers', position: 'G', age: 29, gamesPlayed: 48, goals: 0, assists: 0, points: 0, plusMinus: 0, penaltyMinutes: 0, league: 'SHL', isFavorite: false),
  
  // ECHL Players
  Player(id: 201, firstName: 'Brandon', lastName: 'Hawkins', team: 'TOL', position: 'F', age: 25, gamesPlayed: 69, goals: 35, assists: 43, points: 78, plusMinus: 6, penaltyMinutes: 15, league: 'ECHL', isFavorite: false),
  Player(id: 202, firstName: 'Brayden', lastName: 'Watts', team: 'ALN', position: 'F', age: 25, gamesPlayed: 71, goals: 24, assists: 51, points: 75, plusMinus: 12, penaltyMinutes: 8, league: 'ECHL', isFavorite: false),
  Player(id: 203, firstName: 'Marcus', lastName: 'Crawford', team: 'KC', position: 'D', age: 25, gamesPlayed: 70, goals: 14, assists: 72, points: 86, plusMinus: 49, penaltyMinutes: 20, league: 'ECHL', isFavorite: false),
  Player(id: 204, firstName: 'Nikita', lastName: 'Sedov', team: 'BLM', position: 'D', age: 25, gamesPlayed: 68, goals: 13, assists: 46, points: 59, plusMinus: 29, penaltyMinutes: 10, league: 'ECHL', isFavorite: false),
  Player(id: 205, firstName: 'Cam', lastName: 'Johnson', team: 'FLA', position: 'G', age: 25, gamesPlayed: 49, goals: 0, assists: 0, points: 0, plusMinus: 0, penaltyMinutes: 0, league: 'ECHL', isFavorite: false),
];
