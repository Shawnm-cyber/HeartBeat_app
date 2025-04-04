import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressTrackingScreen extends StatefulWidget {
  ProgressTrackingScreen({super.key});

  @override
  _ProgressTrackingScreenState createState() =>
      _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  int selectedIndex = 0; // Track selected index for bottom navigation

  // Method to create a legend item
  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8), // Space between circle and label
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  final List<FlSpot> weightliftingData = [
    FlSpot(0, 100),
    FlSpot(1, 105),
    FlSpot(2, 110),
    FlSpot(3, 115),
    FlSpot(4, 120),
    FlSpot(5, 125),
  ];
  final List<FlSpot> runningDistanceData = [
    FlSpot(0, 2.0),
    FlSpot(1, 2.4),
    FlSpot(2, 2.8),
    FlSpot(3, 3.2),
    FlSpot(4, 3.6),
    FlSpot(5, 3.8),
  ];
  final List<FlSpot> caloriesBurnedData = [
    FlSpot(0, 250),
    FlSpot(1, 350),
    FlSpot(2, 150),
    FlSpot(3, 200),
    FlSpot(4, 300),
    FlSpot(5, 400),
  ];

  Widget _buildGoalColumn(String progress, String goalText) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Show the progress percentage
        Text(
          progress,
          style: const TextStyle(
            fontSize: 24, // Make it stand out
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8), // Add some breathing room
        // Show goal description
        Text(
          goalText,
          textAlign: TextAlign.center, // Center-align for neatness and
          style: const TextStyle(fontSize: 16), // Smaller but clear
        ),
      ],
    );
  }

  void _showAddGoalDialog(BuildContext context) {
    final goalController = TextEditingController();
    final progressController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: goalController,
              decoration: const InputDecoration(labelText: 'Goal Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: progressController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Progress (%)'),
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
              final goalName = goalController.text.trim();
              final progress = double.tryParse(progressController.text.trim());

              if (goalName.isNotEmpty && progress != null && progress >= 0 && progress <= 100) {
                // Add the goal here
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid goal and progress!')),
                );
              }
            },
            child: const Text('Add Goal'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(0, 228, 236, 231);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: const Text('HeartBeat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addGoal');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progression',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildLegendItem(Colors.amber, 'Weightlifting'),
                const SizedBox(width: 16),
                _buildLegendItem(Colors.lime, 'Running Distance'),
                const SizedBox(width: 16),
                _buildLegendItem(Colors.pink, 'Calories Burned'),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
            const Text(
              'My Goals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGoalColumn('30%', 'Bench\nPress'),
                _buildGoalColumn('70%', 'Squat\n225lbs'),
                _buildGoalColumn('80%', 'Dead Lift\n235lbs'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'You are stronger version of yourself!',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showAddGoalDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('Build a Goal'),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar with labels only
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            label: 'Work Log', icon: SizedBox.shrink(), // Label for Work Log
          ),
          BottomNavigationBarItem(
            label: 'CalTrack', icon: SizedBox.shrink(), // Label for CalTrack
          ),
          const BottomNavigationBarItem(
            label: 'ProTrack', icon: SizedBox.shrink(), // Label for Progress Tracker
          ),
          const BottomNavigationBarItem(
            label: 'Settings', icon: Icon(Icons.settings), // Label for Settings
          ),
        ],
      ),
    );
  }
}
