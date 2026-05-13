// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, Player>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$PlayersTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
@override
late final GeneratedColumn<String> firstName = GeneratedColumn<String>('first_name', aliasedName, false, additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1,maxTextLength: 50), type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
@override
late final GeneratedColumn<String> lastName = GeneratedColumn<String>('last_name', aliasedName, false, additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1,maxTextLength: 50), type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _teamMeta = const VerificationMeta('team');
@override
late final GeneratedColumn<String> team = GeneratedColumn<String>('team', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _positionMeta = const VerificationMeta('position');
@override
late final GeneratedColumn<String> position = GeneratedColumn<String>('position', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _ageMeta = const VerificationMeta('age');
@override
late final GeneratedColumn<int> age = GeneratedColumn<int>('age', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _gamesPlayedMeta = const VerificationMeta('gamesPlayed');
@override
late final GeneratedColumn<int> gamesPlayed = GeneratedColumn<int>('games_played', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
static const VerificationMeta _goalsMeta = const VerificationMeta('goals');
@override
late final GeneratedColumn<int> goals = GeneratedColumn<int>('goals', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
static const VerificationMeta _assistsMeta = const VerificationMeta('assists');
@override
late final GeneratedColumn<int> assists = GeneratedColumn<int>('assists', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
static const VerificationMeta _pointsMeta = const VerificationMeta('points');
@override
late final GeneratedColumn<int> points = GeneratedColumn<int>('points', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
static const VerificationMeta _plusMinusMeta = const VerificationMeta('plusMinus');
@override
late final GeneratedColumn<int> plusMinus = GeneratedColumn<int>('plus_minus', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
static const VerificationMeta _penaltyMinutesMeta = const VerificationMeta('penaltyMinutes');
@override
late final GeneratedColumn<int> penaltyMinutes = GeneratedColumn<int>('penalty_minutes', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
static const VerificationMeta _leagueMeta = const VerificationMeta('league');
@override
late final GeneratedColumn<String> league = GeneratedColumn<String>('league', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
@override
late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>('image_url', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
@override
late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>('is_favorite', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'), defaultValue: const Constant(false));
@override
List<GeneratedColumn> get $columns => [id, firstName, lastName, team, position, age, gamesPlayed, goals, assists, points, plusMinus, penaltyMinutes, league, imageUrl, isFavorite];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'players';
@override
VerificationContext validateIntegrity(Insertable<Player> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('first_name')) {
context.handle(_firstNameMeta, firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));} else if (isInserting) {
context.missing(_firstNameMeta);
}
if (data.containsKey('last_name')) {
context.handle(_lastNameMeta, lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));} else if (isInserting) {
context.missing(_lastNameMeta);
}
if (data.containsKey('team')) {
context.handle(_teamMeta, team.isAcceptableOrUnknown(data['team']!, _teamMeta));} else if (isInserting) {
context.missing(_teamMeta);
}
if (data.containsKey('position')) {
context.handle(_positionMeta, position.isAcceptableOrUnknown(data['position']!, _positionMeta));} else if (isInserting) {
context.missing(_positionMeta);
}
if (data.containsKey('age')) {
context.handle(_ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));} else if (isInserting) {
context.missing(_ageMeta);
}
if (data.containsKey('games_played')) {
context.handle(_gamesPlayedMeta, gamesPlayed.isAcceptableOrUnknown(data['games_played']!, _gamesPlayedMeta));}if (data.containsKey('goals')) {
context.handle(_goalsMeta, goals.isAcceptableOrUnknown(data['goals']!, _goalsMeta));}if (data.containsKey('assists')) {
context.handle(_assistsMeta, assists.isAcceptableOrUnknown(data['assists']!, _assistsMeta));}if (data.containsKey('points')) {
context.handle(_pointsMeta, points.isAcceptableOrUnknown(data['points']!, _pointsMeta));}if (data.containsKey('plus_minus')) {
context.handle(_plusMinusMeta, plusMinus.isAcceptableOrUnknown(data['plus_minus']!, _plusMinusMeta));}if (data.containsKey('penalty_minutes')) {
context.handle(_penaltyMinutesMeta, penaltyMinutes.isAcceptableOrUnknown(data['penalty_minutes']!, _penaltyMinutesMeta));}if (data.containsKey('league')) {
context.handle(_leagueMeta, league.isAcceptableOrUnknown(data['league']!, _leagueMeta));} else if (isInserting) {
context.missing(_leagueMeta);
}
if (data.containsKey('image_url')) {
context.handle(_imageUrlMeta, imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));}if (data.containsKey('is_favorite')) {
context.handle(_isFavoriteMeta, isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override Player map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return Player(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, firstName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}first_name'])!, lastName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}last_name'])!, team: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}team'])!, position: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}position'])!, age: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}age'])!, gamesPlayed: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}games_played'])!, goals: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}goals'])!, assists: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}assists'])!, points: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}points'])!, plusMinus: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}plus_minus'])!, penaltyMinutes: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}penalty_minutes'])!, league: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}league'])!, imageUrl: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}image_url']), isFavorite: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!, );
}
@override
$PlayersTable createAlias(String alias) {
return $PlayersTable(attachedDatabase, alias);}}class Player extends DataClass implements Insertable<Player> 
{
final int id;
final String firstName;
final String lastName;
final String team;
final String position;
final int age;
final int gamesPlayed;
final int goals;
final int assists;
final int points;
final int plusMinus;
final int penaltyMinutes;
final String league;
final String? imageUrl;
final bool isFavorite;
const Player({required this.id, required this.firstName, required this.lastName, required this.team, required this.position, required this.age, required this.gamesPlayed, required this.goals, required this.assists, required this.points, required this.plusMinus, required this.penaltyMinutes, required this.league, this.imageUrl, required this.isFavorite});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['first_name'] = Variable<String>(firstName);
map['last_name'] = Variable<String>(lastName);
map['team'] = Variable<String>(team);
map['position'] = Variable<String>(position);
map['age'] = Variable<int>(age);
map['games_played'] = Variable<int>(gamesPlayed);
map['goals'] = Variable<int>(goals);
map['assists'] = Variable<int>(assists);
map['points'] = Variable<int>(points);
map['plus_minus'] = Variable<int>(plusMinus);
map['penalty_minutes'] = Variable<int>(penaltyMinutes);
map['league'] = Variable<String>(league);
if (!nullToAbsent || imageUrl != null){map['image_url'] = Variable<String>(imageUrl);
}map['is_favorite'] = Variable<bool>(isFavorite);
return map; 
}
PlayersCompanion toCompanion(bool nullToAbsent) {
return PlayersCompanion(id: Value(id),firstName: Value(firstName),lastName: Value(lastName),team: Value(team),position: Value(position),age: Value(age),gamesPlayed: Value(gamesPlayed),goals: Value(goals),assists: Value(assists),points: Value(points),plusMinus: Value(plusMinus),penaltyMinutes: Value(penaltyMinutes),league: Value(league),imageUrl: imageUrl == null && nullToAbsent ? const Value.absent() : Value(imageUrl),isFavorite: Value(isFavorite),);
}
factory Player.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return Player(id: serializer.fromJson<int>(json['id']),firstName: serializer.fromJson<String>(json['firstName']),lastName: serializer.fromJson<String>(json['lastName']),team: serializer.fromJson<String>(json['team']),position: serializer.fromJson<String>(json['position']),age: serializer.fromJson<int>(json['age']),gamesPlayed: serializer.fromJson<int>(json['gamesPlayed']),goals: serializer.fromJson<int>(json['goals']),assists: serializer.fromJson<int>(json['assists']),points: serializer.fromJson<int>(json['points']),plusMinus: serializer.fromJson<int>(json['plusMinus']),penaltyMinutes: serializer.fromJson<int>(json['penaltyMinutes']),league: serializer.fromJson<String>(json['league']),imageUrl: serializer.fromJson<String?>(json['imageUrl']),isFavorite: serializer.fromJson<bool>(json['isFavorite']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'firstName': serializer.toJson<String>(firstName),'lastName': serializer.toJson<String>(lastName),'team': serializer.toJson<String>(team),'position': serializer.toJson<String>(position),'age': serializer.toJson<int>(age),'gamesPlayed': serializer.toJson<int>(gamesPlayed),'goals': serializer.toJson<int>(goals),'assists': serializer.toJson<int>(assists),'points': serializer.toJson<int>(points),'plusMinus': serializer.toJson<int>(plusMinus),'penaltyMinutes': serializer.toJson<int>(penaltyMinutes),'league': serializer.toJson<String>(league),'imageUrl': serializer.toJson<String?>(imageUrl),'isFavorite': serializer.toJson<bool>(isFavorite),};}Player copyWith({int? id,String? firstName,String? lastName,String? team,String? position,int? age,int? gamesPlayed,int? goals,int? assists,int? points,int? plusMinus,int? penaltyMinutes,String? league,Value<String?> imageUrl = const Value.absent(),bool? isFavorite}) => Player(id: id ?? this.id,firstName: firstName ?? this.firstName,lastName: lastName ?? this.lastName,team: team ?? this.team,position: position ?? this.position,age: age ?? this.age,gamesPlayed: gamesPlayed ?? this.gamesPlayed,goals: goals ?? this.goals,assists: assists ?? this.assists,points: points ?? this.points,plusMinus: plusMinus ?? this.plusMinus,penaltyMinutes: penaltyMinutes ?? this.penaltyMinutes,league: league ?? this.league,imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,isFavorite: isFavorite ?? this.isFavorite,);Player copyWithCompanion(PlayersCompanion data) {
return Player(
id: data.id.present ? data.id.value : this.id,firstName: data.firstName.present ? data.firstName.value : this.firstName,lastName: data.lastName.present ? data.lastName.value : this.lastName,team: data.team.present ? data.team.value : this.team,position: data.position.present ? data.position.value : this.position,age: data.age.present ? data.age.value : this.age,gamesPlayed: data.gamesPlayed.present ? data.gamesPlayed.value : this.gamesPlayed,goals: data.goals.present ? data.goals.value : this.goals,assists: data.assists.present ? data.assists.value : this.assists,points: data.points.present ? data.points.value : this.points,plusMinus: data.plusMinus.present ? data.plusMinus.value : this.plusMinus,penaltyMinutes: data.penaltyMinutes.present ? data.penaltyMinutes.value : this.penaltyMinutes,league: data.league.present ? data.league.value : this.league,imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,isFavorite: data.isFavorite.present ? data.isFavorite.value : this.isFavorite,);
}
@override
String toString() {return (StringBuffer('Player(')..write('id: $id, ')..write('firstName: $firstName, ')..write('lastName: $lastName, ')..write('team: $team, ')..write('position: $position, ')..write('age: $age, ')..write('gamesPlayed: $gamesPlayed, ')..write('goals: $goals, ')..write('assists: $assists, ')..write('points: $points, ')..write('plusMinus: $plusMinus, ')..write('penaltyMinutes: $penaltyMinutes, ')..write('league: $league, ')..write('imageUrl: $imageUrl, ')..write('isFavorite: $isFavorite')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, firstName, lastName, team, position, age, gamesPlayed, goals, assists, points, plusMinus, penaltyMinutes, league, imageUrl, isFavorite);@override
bool operator ==(Object other) => identical(this, other) || (other is Player && other.id == this.id && other.firstName == this.firstName && other.lastName == this.lastName && other.team == this.team && other.position == this.position && other.age == this.age && other.gamesPlayed == this.gamesPlayed && other.goals == this.goals && other.assists == this.assists && other.points == this.points && other.plusMinus == this.plusMinus && other.penaltyMinutes == this.penaltyMinutes && other.league == this.league && other.imageUrl == this.imageUrl && other.isFavorite == this.isFavorite);
}class PlayersCompanion extends UpdateCompanion<Player> {
final Value<int> id;
final Value<String> firstName;
final Value<String> lastName;
final Value<String> team;
final Value<String> position;
final Value<int> age;
final Value<int> gamesPlayed;
final Value<int> goals;
final Value<int> assists;
final Value<int> points;
final Value<int> plusMinus;
final Value<int> penaltyMinutes;
final Value<String> league;
final Value<String?> imageUrl;
final Value<bool> isFavorite;
const PlayersCompanion({this.id = const Value.absent(),this.firstName = const Value.absent(),this.lastName = const Value.absent(),this.team = const Value.absent(),this.position = const Value.absent(),this.age = const Value.absent(),this.gamesPlayed = const Value.absent(),this.goals = const Value.absent(),this.assists = const Value.absent(),this.points = const Value.absent(),this.plusMinus = const Value.absent(),this.penaltyMinutes = const Value.absent(),this.league = const Value.absent(),this.imageUrl = const Value.absent(),this.isFavorite = const Value.absent(),});
PlayersCompanion.insert({this.id = const Value.absent(),required String firstName,required String lastName,required String team,required String position,required int age,this.gamesPlayed = const Value.absent(),this.goals = const Value.absent(),this.assists = const Value.absent(),this.points = const Value.absent(),this.plusMinus = const Value.absent(),this.penaltyMinutes = const Value.absent(),required String league,this.imageUrl = const Value.absent(),this.isFavorite = const Value.absent(),}): firstName = Value(firstName), lastName = Value(lastName), team = Value(team), position = Value(position), age = Value(age), league = Value(league);
static Insertable<Player> custom({Expression<int>? id, 
Expression<String>? firstName, 
Expression<String>? lastName, 
Expression<String>? team, 
Expression<String>? position, 
Expression<int>? age, 
Expression<int>? gamesPlayed, 
Expression<int>? goals, 
Expression<int>? assists, 
Expression<int>? points, 
Expression<int>? plusMinus, 
Expression<int>? penaltyMinutes, 
Expression<String>? league, 
Expression<String>? imageUrl, 
Expression<bool>? isFavorite, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (firstName != null)'first_name': firstName,if (lastName != null)'last_name': lastName,if (team != null)'team': team,if (position != null)'position': position,if (age != null)'age': age,if (gamesPlayed != null)'games_played': gamesPlayed,if (goals != null)'goals': goals,if (assists != null)'assists': assists,if (points != null)'points': points,if (plusMinus != null)'plus_minus': plusMinus,if (penaltyMinutes != null)'penalty_minutes': penaltyMinutes,if (league != null)'league': league,if (imageUrl != null)'image_url': imageUrl,if (isFavorite != null)'is_favorite': isFavorite,});
}PlayersCompanion copyWith({Value<int>? id, Value<String>? firstName, Value<String>? lastName, Value<String>? team, Value<String>? position, Value<int>? age, Value<int>? gamesPlayed, Value<int>? goals, Value<int>? assists, Value<int>? points, Value<int>? plusMinus, Value<int>? penaltyMinutes, Value<String>? league, Value<String?>? imageUrl, Value<bool>? isFavorite}) {
return PlayersCompanion(id: id ?? this.id,firstName: firstName ?? this.firstName,lastName: lastName ?? this.lastName,team: team ?? this.team,position: position ?? this.position,age: age ?? this.age,gamesPlayed: gamesPlayed ?? this.gamesPlayed,goals: goals ?? this.goals,assists: assists ?? this.assists,points: points ?? this.points,plusMinus: plusMinus ?? this.plusMinus,penaltyMinutes: penaltyMinutes ?? this.penaltyMinutes,league: league ?? this.league,imageUrl: imageUrl ?? this.imageUrl,isFavorite: isFavorite ?? this.isFavorite,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (firstName.present) {
map['first_name'] = Variable<String>(firstName.value);}
if (lastName.present) {
map['last_name'] = Variable<String>(lastName.value);}
if (team.present) {
map['team'] = Variable<String>(team.value);}
if (position.present) {
map['position'] = Variable<String>(position.value);}
if (age.present) {
map['age'] = Variable<int>(age.value);}
if (gamesPlayed.present) {
map['games_played'] = Variable<int>(gamesPlayed.value);}
if (goals.present) {
map['goals'] = Variable<int>(goals.value);}
if (assists.present) {
map['assists'] = Variable<int>(assists.value);}
if (points.present) {
map['points'] = Variable<int>(points.value);}
if (plusMinus.present) {
map['plus_minus'] = Variable<int>(plusMinus.value);}
if (penaltyMinutes.present) {
map['penalty_minutes'] = Variable<int>(penaltyMinutes.value);}
if (league.present) {
map['league'] = Variable<String>(league.value);}
if (imageUrl.present) {
map['image_url'] = Variable<String>(imageUrl.value);}
if (isFavorite.present) {
map['is_favorite'] = Variable<bool>(isFavorite.value);}
return map; 
}
@override
String toString() {return (StringBuffer('PlayersCompanion(')..write('id: $id, ')..write('firstName: $firstName, ')..write('lastName: $lastName, ')..write('team: $team, ')..write('position: $position, ')..write('age: $age, ')..write('gamesPlayed: $gamesPlayed, ')..write('goals: $goals, ')..write('assists: $assists, ')..write('points: $points, ')..write('plusMinus: $plusMinus, ')..write('penaltyMinutes: $penaltyMinutes, ')..write('league: $league, ')..write('imageUrl: $imageUrl, ')..write('isFavorite: $isFavorite')..write(')')).toString();}
}
class $LineupSlotsTable extends LineupSlots with TableInfo<$LineupSlotsTable, LineupSlot>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$LineupSlotsTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _lineIndexMeta = const VerificationMeta('lineIndex');
@override
late final GeneratedColumn<int> lineIndex = GeneratedColumn<int>('line_index', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _slotMeta = const VerificationMeta('slot');
@override
late final GeneratedColumn<String> slot = GeneratedColumn<String>('slot', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _playerIdMeta = const VerificationMeta('playerId');
@override
late final GeneratedColumn<int> playerId = GeneratedColumn<int>('player_id', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES players (id)'));
@override
List<GeneratedColumn> get $columns => [id, lineIndex, slot, playerId];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'lineup_slots';
@override
VerificationContext validateIntegrity(Insertable<LineupSlot> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('line_index')) {
context.handle(_lineIndexMeta, lineIndex.isAcceptableOrUnknown(data['line_index']!, _lineIndexMeta));} else if (isInserting) {
context.missing(_lineIndexMeta);
}
if (data.containsKey('slot')) {
context.handle(_slotMeta, slot.isAcceptableOrUnknown(data['slot']!, _slotMeta));} else if (isInserting) {
context.missing(_slotMeta);
}
if (data.containsKey('player_id')) {
context.handle(_playerIdMeta, playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));} else if (isInserting) {
context.missing(_playerIdMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override LineupSlot map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return LineupSlot(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, lineIndex: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}line_index'])!, slot: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}slot'])!, playerId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}player_id'])!, );
}
@override
$LineupSlotsTable createAlias(String alias) {
return $LineupSlotsTable(attachedDatabase, alias);}}class LineupSlot extends DataClass implements Insertable<LineupSlot> 
{
final int id;
final int lineIndex;
final String slot;
final int playerId;
const LineupSlot({required this.id, required this.lineIndex, required this.slot, required this.playerId});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['line_index'] = Variable<int>(lineIndex);
map['slot'] = Variable<String>(slot);
map['player_id'] = Variable<int>(playerId);
return map; 
}
LineupSlotsCompanion toCompanion(bool nullToAbsent) {
return LineupSlotsCompanion(id: Value(id),lineIndex: Value(lineIndex),slot: Value(slot),playerId: Value(playerId),);
}
factory LineupSlot.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return LineupSlot(id: serializer.fromJson<int>(json['id']),lineIndex: serializer.fromJson<int>(json['lineIndex']),slot: serializer.fromJson<String>(json['slot']),playerId: serializer.fromJson<int>(json['playerId']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'lineIndex': serializer.toJson<int>(lineIndex),'slot': serializer.toJson<String>(slot),'playerId': serializer.toJson<int>(playerId),};}LineupSlot copyWith({int? id,int? lineIndex,String? slot,int? playerId}) => LineupSlot(id: id ?? this.id,lineIndex: lineIndex ?? this.lineIndex,slot: slot ?? this.slot,playerId: playerId ?? this.playerId,);LineupSlot copyWithCompanion(LineupSlotsCompanion data) {
return LineupSlot(
id: data.id.present ? data.id.value : this.id,lineIndex: data.lineIndex.present ? data.lineIndex.value : this.lineIndex,slot: data.slot.present ? data.slot.value : this.slot,playerId: data.playerId.present ? data.playerId.value : this.playerId,);
}
@override
String toString() {return (StringBuffer('LineupSlot(')..write('id: $id, ')..write('lineIndex: $lineIndex, ')..write('slot: $slot, ')..write('playerId: $playerId')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, lineIndex, slot, playerId);@override
bool operator ==(Object other) => identical(this, other) || (other is LineupSlot && other.id == this.id && other.lineIndex == this.lineIndex && other.slot == this.slot && other.playerId == this.playerId);
}class LineupSlotsCompanion extends UpdateCompanion<LineupSlot> {
final Value<int> id;
final Value<int> lineIndex;
final Value<String> slot;
final Value<int> playerId;
const LineupSlotsCompanion({this.id = const Value.absent(),this.lineIndex = const Value.absent(),this.slot = const Value.absent(),this.playerId = const Value.absent(),});
LineupSlotsCompanion.insert({this.id = const Value.absent(),required int lineIndex,required String slot,required int playerId,}): lineIndex = Value(lineIndex), slot = Value(slot), playerId = Value(playerId);
static Insertable<LineupSlot> custom({Expression<int>? id, 
Expression<int>? lineIndex, 
Expression<String>? slot, 
Expression<int>? playerId, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (lineIndex != null)'line_index': lineIndex,if (slot != null)'slot': slot,if (playerId != null)'player_id': playerId,});
}LineupSlotsCompanion copyWith({Value<int>? id, Value<int>? lineIndex, Value<String>? slot, Value<int>? playerId}) {
return LineupSlotsCompanion(id: id ?? this.id,lineIndex: lineIndex ?? this.lineIndex,slot: slot ?? this.slot,playerId: playerId ?? this.playerId,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (lineIndex.present) {
map['line_index'] = Variable<int>(lineIndex.value);}
if (slot.present) {
map['slot'] = Variable<String>(slot.value);}
if (playerId.present) {
map['player_id'] = Variable<int>(playerId.value);}
return map; 
}
@override
String toString() {return (StringBuffer('LineupSlotsCompanion(')..write('id: $id, ')..write('lineIndex: $lineIndex, ')..write('slot: $slot, ')..write('playerId: $playerId')..write(')')).toString();}
}
abstract class _$AppDatabase extends GeneratedDatabase{
_$AppDatabase(QueryExecutor e): super(e);
$AppDatabaseManager get managers => $AppDatabaseManager(this);
late final $PlayersTable players = $PlayersTable(this);
late final $LineupSlotsTable lineupSlots = $LineupSlotsTable(this);
@override
Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
@override
List<DatabaseSchemaEntity> get allSchemaEntities => [players, lineupSlots];
}
typedef $$PlayersTableCreateCompanionBuilder = PlayersCompanion Function({Value<int> id,required String firstName,required String lastName,required String team,required String position,required int age,Value<int> gamesPlayed,Value<int> goals,Value<int> assists,Value<int> points,Value<int> plusMinus,Value<int> penaltyMinutes,required String league,Value<String?> imageUrl,Value<bool> isFavorite,});
typedef $$PlayersTableUpdateCompanionBuilder = PlayersCompanion Function({Value<int> id,Value<String> firstName,Value<String> lastName,Value<String> team,Value<String> position,Value<int> age,Value<int> gamesPlayed,Value<int> goals,Value<int> assists,Value<int> points,Value<int> plusMinus,Value<int> penaltyMinutes,Value<String> league,Value<String?> imageUrl,Value<bool> isFavorite,});
      final class $$PlayersTableReferences extends BaseReferences<
        _$AppDatabase,
        $PlayersTable,
        Player> {
        $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                  
                  static MultiTypedResultKey<
          $LineupSlotsTable,
          List<LineupSlot>
        > _lineupSlotsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
          db.lineupSlots, 
          aliasName: $_aliasNameGenerator(
            db.players.id,
            db.lineupSlots.playerId)
        );

          $$LineupSlotsTableProcessedTableManager get lineupSlotsRefs {
        final manager = $$LineupSlotsTableTableManager(
            $_db, $_db.lineupSlots
            ).filter(
              (f) => f.playerId.id(
              $_item.id
            )
          );

          final cache = $_typedResult.readTableOrNull(_lineupSlotsRefsTable($_db));
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));


        }
        

      }class $$PlayersTableFilterComposer extends Composer<
        _$AppDatabase,
        $PlayersTable> {
        $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get team => $composableBuilder(
      column: $table.team,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get position => $composableBuilder(
      column: $table.position,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get age => $composableBuilder(
      column: $table.age,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get gamesPlayed => $composableBuilder(
      column: $table.gamesPlayed,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get goals => $composableBuilder(
      column: $table.goals,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get assists => $composableBuilder(
      column: $table.assists,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get points => $composableBuilder(
      column: $table.points,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get plusMinus => $composableBuilder(
      column: $table.plusMinus,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get penaltyMinutes => $composableBuilder(
      column: $table.penaltyMinutes,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get league => $composableBuilder(
      column: $table.league,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite,
      builder: (column) => 
      ColumnFilters(column));
      
        Expression<bool> lineupSlotsRefs(
          Expression<bool> Function( $$LineupSlotsTableFilterComposer f) f
        ) {
                final $$LineupSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineupSlots,
      getReferencedColumn: (t) => t.playerId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$LineupSlotsTableFilterComposer(
              $db: $db,
              $table: $db.lineupSlots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$PlayersTableOrderingComposer extends Composer<
        _$AppDatabase,
        $PlayersTable> {
        $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get team => $composableBuilder(
      column: $table.team,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get position => $composableBuilder(
      column: $table.position,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get gamesPlayed => $composableBuilder(
      column: $table.gamesPlayed,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get goals => $composableBuilder(
      column: $table.goals,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get assists => $composableBuilder(
      column: $table.assists,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get points => $composableBuilder(
      column: $table.points,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get plusMinus => $composableBuilder(
      column: $table.plusMinus,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get penaltyMinutes => $composableBuilder(
      column: $table.penaltyMinutes,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get league => $composableBuilder(
      column: $table.league,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$PlayersTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $PlayersTable> {
        $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get firstName => $composableBuilder(
      column: $table.firstName,
      builder: (column) => column);
      
GeneratedColumn<String> get lastName => $composableBuilder(
      column: $table.lastName,
      builder: (column) => column);
      
GeneratedColumn<String> get team => $composableBuilder(
      column: $table.team,
      builder: (column) => column);
      
GeneratedColumn<String> get position => $composableBuilder(
      column: $table.position,
      builder: (column) => column);
      
GeneratedColumn<int> get age => $composableBuilder(
      column: $table.age,
      builder: (column) => column);
      
GeneratedColumn<int> get gamesPlayed => $composableBuilder(
      column: $table.gamesPlayed,
      builder: (column) => column);
      
GeneratedColumn<int> get goals => $composableBuilder(
      column: $table.goals,
      builder: (column) => column);
      
GeneratedColumn<int> get assists => $composableBuilder(
      column: $table.assists,
      builder: (column) => column);
      
GeneratedColumn<int> get points => $composableBuilder(
      column: $table.points,
      builder: (column) => column);
      
GeneratedColumn<int> get plusMinus => $composableBuilder(
      column: $table.plusMinus,
      builder: (column) => column);
      
GeneratedColumn<int> get penaltyMinutes => $composableBuilder(
      column: $table.penaltyMinutes,
      builder: (column) => column);
      
GeneratedColumn<String> get league => $composableBuilder(
      column: $table.league,
      builder: (column) => column);
      
GeneratedColumn<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl,
      builder: (column) => column);
      
GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite,
      builder: (column) => column);
      
        Expression<T> lineupSlotsRefs<T extends Object>(
          Expression<T> Function( $$LineupSlotsTableAnnotationComposer a) f
        ) {
                final $$LineupSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineupSlots,
      getReferencedColumn: (t) => t.playerId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$LineupSlotsTableAnnotationComposer(
              $db: $db,
              $table: $db.lineupSlots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$PlayersTableTableManager extends RootTableManager    <_$AppDatabase,
    $PlayersTable,
    Player,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (Player,$$PlayersTableReferences),
    Player,
    PrefetchHooks Function({bool lineupSlotsRefs})
    > {
    $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$PlayersTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$PlayersTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$PlayersTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<String> firstName = const Value.absent(),Value<String> lastName = const Value.absent(),Value<String> team = const Value.absent(),Value<String> position = const Value.absent(),Value<int> age = const Value.absent(),Value<int> gamesPlayed = const Value.absent(),Value<int> goals = const Value.absent(),Value<int> assists = const Value.absent(),Value<int> points = const Value.absent(),Value<int> plusMinus = const Value.absent(),Value<int> penaltyMinutes = const Value.absent(),Value<String> league = const Value.absent(),Value<String?> imageUrl = const Value.absent(),Value<bool> isFavorite = const Value.absent(),})=> PlayersCompanion(id: id,firstName: firstName,lastName: lastName,team: team,position: position,age: age,gamesPlayed: gamesPlayed,goals: goals,assists: assists,points: points,plusMinus: plusMinus,penaltyMinutes: penaltyMinutes,league: league,imageUrl: imageUrl,isFavorite: isFavorite,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required String firstName,required String lastName,required String team,required String position,required int age,Value<int> gamesPlayed = const Value.absent(),Value<int> goals = const Value.absent(),Value<int> assists = const Value.absent(),Value<int> points = const Value.absent(),Value<int> plusMinus = const Value.absent(),Value<int> penaltyMinutes = const Value.absent(),required String league,Value<String?> imageUrl = const Value.absent(),Value<bool> isFavorite = const Value.absent(),})=> PlayersCompanion.insert(id: id,firstName: firstName,lastName: lastName,team: team,position: position,age: age,gamesPlayed: gamesPlayed,goals: goals,assists: assists,points: points,plusMinus: plusMinus,penaltyMinutes: penaltyMinutes,league: league,imageUrl: imageUrl,isFavorite: isFavorite,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$PlayersTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({lineupSlotsRefs = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             if (lineupSlotsRefs) db.lineupSlots
            ],
            addJoins: null,
            getPrefetchedDataCallback: (items) async {
            return [
                      if (lineupSlotsRefs) await $_getPrefetchedData(
                  currentTable: table,
                  referencedTable:
                      $$PlayersTableReferences._lineupSlotsRefsTable(db),
                  managerFromTypedResult: (p0) =>
                      $$PlayersTableReferences(db, table, p0).lineupSlotsRefs,
                  referencedItemsForCurrentItem: (item, referencedItems) =>
                      referencedItems.where((e) => e.playerId == item.id),
                  typedResults: items)
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$PlayersTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $PlayersTable,
    Player,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (Player,$$PlayersTableReferences),
    Player,
    PrefetchHooks Function({bool lineupSlotsRefs})
    >;typedef $$LineupSlotsTableCreateCompanionBuilder = LineupSlotsCompanion Function({Value<int> id,required int lineIndex,required String slot,required int playerId,});
typedef $$LineupSlotsTableUpdateCompanionBuilder = LineupSlotsCompanion Function({Value<int> id,Value<int> lineIndex,Value<String> slot,Value<int> playerId,});
      final class $$LineupSlotsTableReferences extends BaseReferences<
        _$AppDatabase,
        $LineupSlotsTable,
        LineupSlot> {
        $$LineupSlotsTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                          static $PlayersTable _playerIdTable(_$AppDatabase db) => 
            db.players.createAlias($_aliasNameGenerator(
            db.lineupSlots.playerId,
            db.players.id));
          

        $$PlayersTableProcessedTableManager? get playerId {
          if ($_item.playerId == null) return null;
          final manager = $$PlayersTableTableManager($_db, $_db.players).filter((f) => f.id($_item.playerId!));
          final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
          if (item == null) return manager;
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
        }


      }class $$LineupSlotsTableFilterComposer extends Composer<
        _$AppDatabase,
        $LineupSlotsTable> {
        $$LineupSlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get lineIndex => $composableBuilder(
      column: $table.lineIndex,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get slot => $composableBuilder(
      column: $table.slot,
      builder: (column) => 
      ColumnFilters(column));
      
        $$PlayersTableFilterComposer get playerId {
                final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$PlayersTableFilterComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$LineupSlotsTableOrderingComposer extends Composer<
        _$AppDatabase,
        $LineupSlotsTable> {
        $$LineupSlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get lineIndex => $composableBuilder(
      column: $table.lineIndex,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get slot => $composableBuilder(
      column: $table.slot,
      builder: (column) => 
      ColumnOrderings(column));
      
        $$PlayersTableOrderingComposer get playerId {
                final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$PlayersTableOrderingComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$LineupSlotsTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $LineupSlotsTable> {
        $$LineupSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<int> get lineIndex => $composableBuilder(
      column: $table.lineIndex,
      builder: (column) => column);
      
GeneratedColumn<String> get slot => $composableBuilder(
      column: $table.slot,
      builder: (column) => column);
      
        $$PlayersTableAnnotationComposer get playerId {
                final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$PlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.players,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$LineupSlotsTableTableManager extends RootTableManager    <_$AppDatabase,
    $LineupSlotsTable,
    LineupSlot,
    $$LineupSlotsTableFilterComposer,
    $$LineupSlotsTableOrderingComposer,
    $$LineupSlotsTableAnnotationComposer,
    $$LineupSlotsTableCreateCompanionBuilder,
    $$LineupSlotsTableUpdateCompanionBuilder,
    (LineupSlot,$$LineupSlotsTableReferences),
    LineupSlot,
    PrefetchHooks Function({bool playerId})
    > {
    $$LineupSlotsTableTableManager(_$AppDatabase db, $LineupSlotsTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$LineupSlotsTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$LineupSlotsTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$LineupSlotsTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<int> lineIndex = const Value.absent(),Value<String> slot = const Value.absent(),Value<int> playerId = const Value.absent(),})=> LineupSlotsCompanion(id: id,lineIndex: lineIndex,slot: slot,playerId: playerId,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required int lineIndex,required String slot,required int playerId,})=> LineupSlotsCompanion.insert(id: id,lineIndex: lineIndex,slot: slot,playerId: playerId,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$LineupSlotsTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({playerId = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             
            ],
            addJoins: <T extends TableManagerState<dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic>>(state) {

                                  if (playerId){
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable:
                        $$LineupSlotsTableReferences._playerIdTable(db),
                    referencedColumn:
                        $$LineupSlotsTableReferences._playerIdTable(db).id,
                  ) as T;
               }

                return state;
              }
,
            getPrefetchedDataCallback: (items) async {
            return [
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$LineupSlotsTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $LineupSlotsTable,
    LineupSlot,
    $$LineupSlotsTableFilterComposer,
    $$LineupSlotsTableOrderingComposer,
    $$LineupSlotsTableAnnotationComposer,
    $$LineupSlotsTableCreateCompanionBuilder,
    $$LineupSlotsTableUpdateCompanionBuilder,
    (LineupSlot,$$LineupSlotsTableReferences),
    LineupSlot,
    PrefetchHooks Function({bool playerId})
    >;class $AppDatabaseManager {
final _$AppDatabase _db;
$AppDatabaseManager(this._db);
$$PlayersTableTableManager get players => $$PlayersTableTableManager(_db, _db.players);
$$LineupSlotsTableTableManager get lineupSlots => $$LineupSlotsTableTableManager(_db, _db.lineupSlots);
}
