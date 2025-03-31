import 'package:hive/hive.dart';

part 'routine.g.dart';

@HiveType(typeId: 2)
class RoutineSet extends HiveObject {
  @HiveField(0)
  String iconName; // e.g., "directions_walk"

  @HiveField(1)
  String weight; // e.g., "20 kg"

  @HiveField(2)
  String reps; // e.g., "10 reps"

  @HiveField(3)
  bool isCompleted;

  RoutineSet({
    required this.iconName,
    required this.weight,
    required this.reps,
    this.isCompleted = false,
  });
}

@HiveType(typeId: 1)
class Routine extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String difficulty; // e.g., "Beginner", "Intermediate", "Advanced"

  @HiveField(2)
  List<RoutineSet> sets;

  Routine({
    required this.name,
    required this.difficulty,
    required this.sets,
  });
}
