import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/routine.dart';

class PresetRoutinesScreen extends StatefulWidget {
  const PresetRoutinesScreen({Key? key}) : super(key: key);

  @override
  State<PresetRoutinesScreen> createState() => _PresetRoutinesScreenState();
}

class _PresetRoutinesScreenState extends State<PresetRoutinesScreen> {
  late Box<Routine> routinesBox;

  @override
  void initState() {
    super.initState();
    routinesBox = Hive.box<Routine>('routinesBox');
  }

  // Routine CRUD operations

  // Add a new routine
  void _addRoutine(String name, String difficulty) {
    final newRoutine = Routine(name: name, difficulty: difficulty, sets: []);
    routinesBox.add(newRoutine);
    setState(() {});
  }

  // Edit an existing routine
  void _editRoutine(Routine routine, String newName, String newDifficulty) {
    routine.name = newName;
    routine.difficulty = newDifficulty;
    routine.save();
    setState(() {});
  }

  // Delete a routine
  void _deleteRoutine(Routine routine) {
    routine.delete();
    setState(() {});
  }

  // Routine Set Operations

  // Add a new set to an existing routine
  void _addSetToRoutine(Routine routine, RoutineSet newSet) {
    routine.sets.add(newSet);
    routine.save();
    setState(() {});
  }

  // Toggle the completion status of a set
  void _toggleSetCompletion(Routine routine, int setIndex) {
    routine.sets[setIndex].isCompleted = !routine.sets[setIndex].isCompleted;
    routine.save();
    setState(() {});
  }

  // Delete a set from a routine
  void _deleteSetFromRoutine(Routine routine, int setIndex) {
    routine.sets.removeAt(setIndex);
    routine.save();
    setState(() {});
  }

  // --- Dialogs for Adding/Editing ---

  // Dialog to add a new routine
  Future<void> _showAddRoutineDialog() async {
    final nameController = TextEditingController();
    final difficultyController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Routine'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Routine Name'),
            ),
            TextField(
              controller: difficultyController,
              decoration: const InputDecoration(
                  labelText: 'Difficulty (e.g., Beginner)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              final difficulty = difficultyController.text.trim();
              if (name.isNotEmpty && difficulty.isNotEmpty) {
                _addRoutine(name, difficulty);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // Dialog to edit an existing routine
  Future<void> _showEditRoutineDialog(Routine routine) async {
    final nameController = TextEditingController(text: routine.name);
    final difficultyController =
        TextEditingController(text: routine.difficulty);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Routine'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Routine Name'),
            ),
            TextField(
              controller: difficultyController,
              decoration: const InputDecoration(labelText: 'Difficulty'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newName = nameController.text.trim();
              final newDifficulty = difficultyController.text.trim();
              if (newName.isNotEmpty && newDifficulty.isNotEmpty) {
                _editRoutine(routine, newName, newDifficulty);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Dialog to add a new set to a routine
  Future<void> _showAddSetDialog(Routine routine) async {
    final iconController = TextEditingController();
    final weightController = TextEditingController();
    final repsController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Set'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: iconController,
              decoration: const InputDecoration(
                  labelText: 'Icon Name (e.g., directions_walk)'),
            ),
            TextField(
              controller: weightController,
              decoration:
                  const InputDecoration(labelText: 'Weight (e.g., 20 kg)'),
            ),
            TextField(
              controller: repsController,
              decoration:
                  const InputDecoration(labelText: 'Reps (e.g., 10 reps)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final iconName = iconController.text.trim();
              final weight = weightController.text.trim();
              final reps = repsController.text.trim();
              if (iconName.isNotEmpty && weight.isNotEmpty && reps.isNotEmpty) {
                final newSet = RoutineSet(
                  iconName: iconName,
                  weight: weight,
                  reps: reps,
                  isCompleted: false,
                );
                _addSetToRoutine(routine, newSet);
                Navigator.pop(context);
              }
            },
            child: const Text('Add Set'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routines = routinesBox.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preset Routines'),
      ),
      body: ListView.builder(
        itemCount: routines.length,
        itemBuilder: (context, index) {
          final routine = routines[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${routine.name} (${routine.difficulty})'),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showEditRoutineDialog(routine);
                      } else if (value == 'delete') {
                        _deleteRoutine(routine);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit Routine'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete Routine'),
                      ),
                    ],
                  ),
                ],
              ),
              children: [
                // Display each set for the routine.
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: routine.sets.length,
                  itemBuilder: (context, setIndex) {
                    final setItem = routine.sets[setIndex];
                    return ListTile(
                      leading: Icon(Icons.fitness_center),
                      title: Text('${setItem.weight} - ${setItem.reps}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              setItem.isCompleted
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: setItem.isCompleted ? Colors.green : null,
                            ),
                            onPressed: () =>
                                _toggleSetCompletion(routine, setIndex),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _deleteSetFromRoutine(routine, setIndex),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Button to add a new set.
                TextButton(
                  onPressed: () => _showAddSetDialog(routine),
                  child: const Text('Add Set'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRoutineDialog,
        child: const Icon(Icons.add),
      ),
      // --- Bottom Navigation Bar ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Adjust the active index as needed
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/workoutLog');
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
