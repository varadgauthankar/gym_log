import 'package:moor_flutter/moor_flutter.dart';
part 'moor_db.g.dart';

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get sets => integer()();
  TextColumn get data => text()();
  TextColumn get note => text()();
  DateTimeColumn get date => dateTime()();
}

@UseMoor(tables: [Exercises])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));
  @override
  int get schemaVersion => 1;

  Future<List<Exercise>> getAllExercises() => select(exercises).get();
  Stream<List<Exercise>> watchAllExercises() => select(exercises).watch();
  Future insertExercise(Exercise exercise) => into(exercises).insert(exercise);
  Future updateExercise(Exercise exercise) =>
      update(exercises).replace(exercise);
  Future deleteExercise(Exercise exercise) =>
      delete(exercises).delete(exercise);
}
