import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressTrackingScreen extends StatelessWidget {
  const ProgressTrackingScreen({Key? key}) : super(key: key);

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


  @override
  Widget build(BuildContext context) {
    // Replace this color with whatever you want as the background.
    // This is just a sample pale green.
    const backgroundColor = Color(0xFFDCE6D7);

    return Scaffold(
      // We'll build a custom top section and bottom nav, so we set the AppBar to null:
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
        ),
        title: const Text('Progression'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {
            Navigator.pushNamed(context, '/addGoal');
          }),
              ],
            ),
            // 1) Custom Top Bar
            Padding(
              padding: const EdgeInsets.all(16.0), // Just some space available around the content
              child: Column(
                // Spread out the left icon, center text, and right button
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Section
                  const Text(
                    'Progression',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  //Legend Section
                  Row(children: [
                    _buildLegendItem(Colors.amber, 'Weightlifting'),
                    const SizedBox(width: 16),
                    _buildLegendItem(Colors.lime, 'Running Distance'),
                    const SizedBox(width: 16),
                    _buildLegendItem(Colors.pink, 'Calories Burned'),
                  ],),
                  const SizedBox(height: 20),

                  // Line Chart Section
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true), // Shows grid lines

                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                          ),
                        ),
                        borderData: FlBorderData(show: true),

                        
                      )
                    )
                  )
                  // Add Workout Button (text)
                  GestureDetector(
                    onTap: () {
                      // Handle "Add Workout" action
                    },
                    child: const Text(
                      'Add Workout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2) Progression Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Progression',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 3) Chart / Graph Placeholder
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 200,
              decoration: BoxDecoration(
                color:
                    Colors.black87, // Dark background for the chart placeholder
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Text(
                  'Line Chart Placeholder',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            // 4) My Goals Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Goals',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Row of three goals
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildGoalColumn('30%', 'Bench\nPress'),
                        _buildGoalColumn('70%', 'Squat\n225lbs.'),
                        _buildGoalColumn('80%', 'Dead lift\n235lbs.'),
                      ],
                    ),

                    // You can add more widgets or space below if needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 5) Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            2, // For example, if "ProTrack" is the 3rd item (0-based index)
        onTap: (index) {
          // Handle navigation
          // e.g., if (index == 0) -> Navigator.pushNamed(context, '/workLog');
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
        ],
      ),
    );
  }

  // Helper widget for a single goal
  Widget _buildGoalColumn(String progress, String goalText) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          progress,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          goalText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
