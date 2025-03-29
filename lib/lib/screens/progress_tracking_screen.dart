import 'package:flutter/material.dart';

class ProgressTrackingScreen extends StatelessWidget {
  const ProgressTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this color with whatever you want as the background.
    // This is just a sample pale green.
    const backgroundColor = Color(0xFFDCE6D7);

    return Scaffold(
      // We'll build a custom top section and bottom nav, so we set the AppBar to null:
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 1) Custom Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                // Spread out the left icon, center text, and right button
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Home Icon
                  IconButton(
                    onPressed: () {
                      // Example: Go back home or open a drawer
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.home),
                  ),

                  // Title
                  const Text(
                    'HeartBeat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

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
