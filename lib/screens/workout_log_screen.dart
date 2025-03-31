import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/workout.dart';

class WorkoutLogScreen extends StatefulWidget {
  const WorkoutLogScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutLogScreen> createState() => _WorkoutLogScreenState();
}

class _WorkoutLogScreenState extends State<WorkoutLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();
  final _notesController = TextEditingController();

  late Box<Workout> workoutBox;

  @override
  void initState() {
    super.initState();
    workoutBox = Hive.box<Workout>('workoutsBox');
  }

  void _saveWorkout() {
    if (_formKey.currentState!.validate()) {
      final newWorkout = Workout(
        name: _nameController.text.trim(),
        weight: double.tryParse(_weightController.text) ?? 0,
        reps: int.tryParse(_repsController.text) ?? 0,
        notes: _notesController.text.trim(),
        date: DateTime.now(),
      );
      workoutBox.add(newWorkout);
      setState(() {
        // Clear the form fields after saving
        _nameController.clear();
        _weightController.clear();
        _repsController.clear();
        _notesController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout saved!')),
      );
    }
  }

  void _cancelWorkout() {
    // Clear the form fields if user cancels entry
    _nameController.clear();
    _weightController.clear();
    _repsController.clear();
    _notesController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Workout entry canceled.')),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _repsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the workouts and reverse the list to show the newest first.
    final workouts = workoutBox.values.toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Log'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _cancelWorkout,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveWorkout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Form Card for new workout entry
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Exercise Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter an exercise name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Weight (kg/lb)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _repsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Reps',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _notesController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Notes (optional)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'Workout History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // History log list
            Expanded(
              child: workouts.isEmpty
                  ? const Center(child: Text('No workouts logged yet.'))
                  : ListView.builder(
                      itemCount: workouts.length,
                      itemBuilder: (context, index) {
                        final workout = workouts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(workout.name),
                            subtitle: Text(
                              'Weight: ${workout.weight}, Reps: ${workout.reps}\n'
                              '${workout.notes ?? ''}\n'
                              '${workout.date.toLocal().toString().split(".")[0]}',
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // assuming Workout Log is the first tab
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on Workout Log
              break;
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }
}
