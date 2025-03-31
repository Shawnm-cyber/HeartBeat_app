import 'package:hive/hive.dart';

part 'workout.g.dart';

@HiveType(typeId: 3)
class Workout extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double weight;

  @HiveField(2)
  int reps;

  @HiveField(3)
  String? notes;

  @HiveField(4)
  DateTime date;

  Workout({
    required this.name,
    required this.weight,
    required this.reps,
    this.notes,
    required this.date,
  });
}
