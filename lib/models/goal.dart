import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 4)
class Goal extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double progress; // Represents progress as a percentage (0-100)

  Goal({
    required this.name,
    required this.progress,
  });
}
