import 'package:moor_flutter/moor_flutter.dart';

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get sets => integer()();
  TextColumn get data => text()();
  TextColumn get note => text()();
  DateTimeColumn get date => dateTime()();
}
