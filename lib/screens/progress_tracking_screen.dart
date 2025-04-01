import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import '../models/goal.dart';

class ProgressTrackingScreen extends StatefulWidget {
  const ProgressTrackingScreen({Key? key}) : super(key: key);

  @override
  State<ProgressTrackingScreen> createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  //  assume "Progress Tracking" is the 2nd index in bottom navigation
  int selectedIndex = 2;
  late Box<Goal> goalsBox;

  // Example line chart data
  final List<FlSpot> weightliftingData = [
    FlSpot(0, 100),
    FlSpot(1, 105),
    FlSpot(2, 110),
    FlSpot(3, 115),
    FlSpot(4, 120),
    FlSpot(5, 125),
  ];
  final List<FlSpot> runningDistanceData = [
    FlSpot(0, 2),
    FlSpot(1, 2.4),
    FlSpot(2, 2.8),
    FlSpot(3, 3.2),
    FlSpot(4, 3.6),
    FlSpot(5, 4.0),
  ];
  final List<FlSpot> caloriesBurnedData = [
    FlSpot(0, 250),
    FlSpot(1, 300),
    FlSpot(2, 150),
    FlSpot(3, 350),
    FlSpot(4, 375),
    FlSpot(5, 400),
  ];

  @override
  void initState() {
    super.initState();
    // Retrieve the typed Hive box we opened in main.dart
    goalsBox = Hive.box<Goal>('goalsBox');
  }

  /// For the legend row
  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }

  /// Adding a new goal through a dialog
  void _showAddGoalDialog() {
    final nameController = TextEditingController();
    final progressController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add a Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Goal Name'),
            ),
            TextField(
              controller: progressController,
              decoration: const InputDecoration(labelText: 'Progress (0-100)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final goalName = nameController.text.trim();
              final prog = double.tryParse(progressController.text.trim());
              if (goalName.isNotEmpty &&
                  prog != null &&
                  prog >= 0 &&
                  prog <= 100) {
                final newGoal = Goal(name: goalName, progress: prog);
                goalsBox.add(newGoal);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Goal Added!')),
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Enter a valid goal name and progress')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalList() {
    // Gather all goals from the box
    final allGoals = goalsBox.values.toList();
    if (allGoals.isEmpty) {
      return const Text('No goals added yet.');
    }
    return Column(
      children: allGoals.map((g) {
        return ListTile(
          title: Text('${g.name}'),
          subtitle: Text('Progress: ${g.progress}%'),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE4ECE7);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Progress Tracker'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        actions: [
          IconButton(
            onPressed: _showAddGoalDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Overall Progress',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem(Colors.blue, 'Weight'),
                  _buildLegendItem(Colors.green, 'Distance'),
                  _buildLegendItem(Colors.red, 'Calories'),
                ],
              ),
              const SizedBox(height: 12),

              // Chart
              SizedBox(
                height: 300,
                width: double.infinity,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: true, reservedSize: 40),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: true, reservedSize: 32),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: weightliftingData,
                        color: Colors.blue,
                        isCurved: true,
                        barWidth: 3,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: runningDistanceData,
                        color: Colors.green,
                        isCurved: true,
                        barWidth: 3,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: caloriesBurnedData,
                        color: Colors.red,
                        isCurved: true,
                        barWidth: 3,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'My Goals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildGoalList(),
            ],
          ),
        ),
      ),

      // Bottom Nav
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (i) {
          setState(() {
            selectedIndex = i;
          });
          if (i == 0) {
            Navigator.pushReplacementNamed(context, '/workoutLog');
          } else if (i == 1) {
            Navigator.pushReplacementNamed(context, '/calorieTracker');
          } else if (i == 2) {
            // Already here
          } else if (i == 3) {
            Navigator.pushReplacementNamed(context, '/settings');
          }
        },
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
