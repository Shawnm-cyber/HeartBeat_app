import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/meal.dart';

class CalorieTrackerScreen extends StatefulWidget {
  const CalorieTrackerScreen({Key? key}) : super(key: key);

  @override
  State<CalorieTrackerScreen> createState() => _CalorieTrackerScreenState();
}

class _CalorieTrackerScreenState extends State<CalorieTrackerScreen> {
  final _foodController = TextEditingController();
  final _calorieController = TextEditingController();
  final _mealTypeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late Box<Meal> mealsBox;

  @override
  void initState() {
    super.initState();
    mealsBox = Hive.box<Meal>('mealsBox');
  }

  void _addMeal() {
    if (_formKey.currentState!.validate()) {
      final newMeal = Meal(
        mealType: _mealTypeController.text.trim(),
        foodName: _foodController.text.trim(),
        calories: int.parse(_calorieController.text),
        time: DateTime.now(),
      );

      mealsBox.add(newMeal);

      _foodController.clear();
      _calorieController.clear();
      _mealTypeController.clear();

      setState(() {}); // refresh UI
    }
  }

  @override
  void dispose() {
    _foodController.dispose();
    _calorieController.dispose();
    _mealTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meals = mealsBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Calorie Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _mealTypeController,
                    decoration: const InputDecoration(labelText: 'Meal Type'),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _foodController,
                    decoration: const InputDecoration(labelText: 'Food Name'),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _calorieController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Calories'),
                    validator: (value) =>
                        value!.isEmpty || int.tryParse(value) == null
                            ? 'Enter a valid number'
                            : null,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _addMeal,
                    child: const Text('Add Meal'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),

            // List of meals
            Expanded(
              child: ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return ListTile(
                    title: Text('${meal.foodName} - ${meal.calories} cal'),
                    subtitle: Text(
                        '${meal.mealType} - ${meal.time.hour}:${meal.time.minute}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
