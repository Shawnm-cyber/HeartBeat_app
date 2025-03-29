import 'package:flutter/material.dart';

class CalorieTrackerScreen extends StatelessWidget {
  const CalorieTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFDCE6D7);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.home),
                  const Text(
                    'HeartBeat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle Add Workout
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.add, size: 20),
                        Text(
                          'Add\nWorkout',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // "Today" Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Today',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Calorie Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _CalorieStat(label: 'Eaten', value: '1268'),
                _CalorieStat(label: 'Remaining', value: '830', highlight: true),
                _CalorieStat(label: 'Burned', value: '302'),
              ],
            ),

            const SizedBox(height: 24),

            // Macronutrients
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _MacroStat(label: 'Carbs', current: 234, goal: 275),
                  _MacroStat(label: 'Protein', current: 32, goal: 155),
                  _MacroStat(label: 'Fats', current: 27, goal: 54),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Meals
            const _MealEntry(meal: 'Breakfast', current: 45, goal: 150),
            const _MealEntry(meal: 'Lunch', current: 830, goal: 850),
            const _MealEntry(meal: 'Dinner', current: 350, goal: 380),
            const _MealEntry(meal: 'Snack', current: 0, goal: 150),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Cal Track is index 1
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/workoutLog');
              break;
            case 1:
              break; // Already on Cal Track
            case 2:
              Navigator.pushNamed(context, '/progressTracking');
              break;
            case 3:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Work Log',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Cal Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'ProTrack',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}

class _CalorieStat extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _CalorieStat({
    required this.label,
    required this.value,
    this.highlight = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: highlight ? Colors.deepPurple : Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}

class _MacroStat extends StatelessWidget {
  final String label;
  final int current;
  final int goal;

  const _MacroStat({
    required this.label,
    required this.current,
    required this.goal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$current / $goal g',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}

class _MealEntry extends StatelessWidget {
  final String meal;
  final int current;
  final int goal;

  const _MealEntry({
    required this.meal,
    required this.current,
    required this.goal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.add, color: Colors.blue),
      title: Text(meal, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$current / $goal Cal'),
      onTap: () {
        // Add food dialog or navigation
      },
    );
  }
}
