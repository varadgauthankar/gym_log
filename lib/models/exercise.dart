import 'package:hive/hive.dart';

part "exercise.g.dart";

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  int id;

  @HiveField(1)
  int exNumber;

  @HiveField(2)
  String name;

  @HiveField(3)
  String note;

  @HiveField(4)
  int sets;

  @HiveField(5)
  List<Data> data;

  Exercise({this.name, this.note, this.sets, this.data});
}

@HiveType(typeId: 2)
class Data {
  Data({this.reps, this.weight});

  double weight;
  int reps;
}
