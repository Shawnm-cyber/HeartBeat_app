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
  late Box settingsBox;
  int _calorieGoal = 2000;

  @override
  void initState() {
    super.initState();
    mealsBox = Hive.box<Meal>('mealsBox');
    settingsBox = Hive.box('settingsBox');
    _calorieGoal = settingsBox.get('calorieGoal', defaultValue: 2000);
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

      setState(() {});
    }
  }

  void _updateGoal(int goal) {
    settingsBox.put('calorieGoal', goal);
    setState(() {
      _calorieGoal = goal;
    });
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
    final todayMeals = meals
        .where((m) =>
            m.time.day == DateTime.now().day &&
            m.time.month == DateTime.now().month &&
            m.time.year == DateTime.now().year)
        .toList();

    final int totalEaten = todayMeals.fold(0, (sum, m) => sum + m.calories);
    final int burned = 300;
    final int remaining = _calorieGoal - totalEaten;

    return Scaffold(
      appBar: AppBar(title: const Text('Calorie Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.green[100],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Calorie Goal: $_calorieGoal kcal'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _summaryCard('Eaten', totalEaten),
                        _summaryCard('Remaining', remaining),
                        _summaryCard('Burned', burned),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        final controller = TextEditingController();
                        final goal = await showDialog<int>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Set Calorie Goal'),
                            content: TextField(
                              controller: controller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Enter goal (e.g., 2000)'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final val = int.tryParse(controller.text);
                                  Navigator.pop(context, val);
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        );
                        if (goal != null && goal > 0) {
                          _updateGoal(goal);
                        }
                      },
                      child: const Text('Set Goal'),
                    ),
                  ],
                ),
              ),
            ),
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
            Expanded(
              child: ListView.builder(
                itemCount: todayMeals.length,
                itemBuilder: (context, index) {
                  final meal = todayMeals[index];
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

  Widget _summaryCard(String label, int value) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
