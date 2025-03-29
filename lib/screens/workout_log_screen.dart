import 'package:flutter/material.dart';

class WorkoutLogScreen extends StatefulWidget {
  const WorkoutLogScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutLogScreen> createState() => _WorkoutLogScreenState();
}

class _WorkoutLogScreenState extends State<WorkoutLogScreen> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFDCE6D7);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with cancel, timer, confirm
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red, size: 32),
                    onPressed: () {
                      Navigator.pop(context); // Or clear form
                    },
                  ),
                  const Text(
                    '0:11:24:15',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 32,
                    ),
                    onPressed: () {
                      // Save workout
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Title
            const Text(
              'HeartBeat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Work log',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            // Input Fields
            _buildInputField('Workout Type', _typeController),
            _buildInputField('Weight', _weightController),
            _buildInputField('Reps', _repsController),

            // onSaveWorkout(type, weight, reps, timestamp):
            //  validate input
            //   workout = create WorkoutModel(type, weight, reps, timestamp)
            //  save workout to local database
            //
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Work Log tab selected
        onTap: (index) {
          switch (index) {
            case 0:
              break; // Already here
            case 1:
              Navigator.pushNamed(context, '/calorieTracker');
              break;
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

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.purple.shade100.withOpacity(0.2),
          suffixIcon: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => controller.clear(),
          ),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}
