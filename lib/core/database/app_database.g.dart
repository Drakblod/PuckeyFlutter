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
abstract class _$AppDatabase extends GeneratedDatabase{
_$AppDatabase(QueryExecutor e): super(e);
$AppDatabaseManager get managers => $AppDatabaseManager(this);
late final $PlayersTable players = $PlayersTable(this);
@override
Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
@override
List<DatabaseSchemaEntity> get allSchemaEntities => [players];
}
typedef $$PlayersTableCreateCompanionBuilder = PlayersCompanion Function({Value<int> id,required String firstName,required String lastName,required String team,required String position,required int age,Value<int> gamesPlayed,Value<int> goals,Value<int> assists,Value<int> points,Value<int> plusMinus,Value<int> penaltyMinutes,required String league,Value<String?> imageUrl,Value<bool> isFavorite,});
typedef $$PlayersTableUpdateCompanionBuilder = PlayersCompanion Function({Value<int> id,Value<String> firstName,Value<String> lastName,Value<String> team,Value<String> position,Value<int> age,Value<int> gamesPlayed,Value<int> goals,Value<int> assists,Value<int> points,Value<int> plusMinus,Value<int> penaltyMinutes,Value<String> league,Value<String?> imageUrl,Value<bool> isFavorite,});
class $$PlayersTableFilterComposer extends Composer<
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
      
        }
      class $$PlayersTableTableManager extends RootTableManager    <_$AppDatabase,
    $PlayersTable,
    Player,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (Player,BaseReferences<_$AppDatabase,$PlayersTable,Player>),
    Player,
    PrefetchHooks Function()
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
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
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
    (Player,BaseReferences<_$AppDatabase,$PlayersTable,Player>),
    Player,
    PrefetchHooks Function()
    >;class $AppDatabaseManager {
final _$AppDatabase _db;
$AppDatabaseManager(this._db);
$$PlayersTableTableManager get players => $$PlayersTableTableManager(_db, _db.players);
}
