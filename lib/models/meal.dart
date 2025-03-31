import 'package:hive/hive.dart';

part 'meal.g.dart';

@HiveType(typeId: 0)
class Meal extends HiveObject {
  @HiveField(0)
  String mealType; // Breakfast, Lunch, Dinner, Snack

  @HiveField(1)
  String foodName;

  @HiveField(2)
  int calories;

  @HiveField(3)
  DateTime time;

  Meal({
    required this.mealType,
    required this.foodName,
    required this.calories,
    required this.time,
  });
}
