import 'package:flutter/material.dart';

class PresetRoutinesScreen extends StatelessWidget {
  const PresetRoutinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFDCE6D7);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.home),
                    Text(
                      'HeartBeat',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        Icon(Icons.add, size: 20),
                        Text(
                          'Add\nWorkout',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Running animation or image
              SizedBox(
                height: 80,
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/860/860733.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),
              // onInit():
              // fetch routines from database
              //   display by difficulty (Beginner / Intermediate / Advanced)

              // Chart and remaining calories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Chart placeholder
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Chart Placeholder',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Remaining tracker
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: CircularProgressIndicator(
                                  value: 0.7,
                                  strokeWidth: 6,
                                  backgroundColor: Colors.brown[100],
                                  color: Colors.brown,
                                ),
                              ),
                              const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '830',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('Remaining'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              // onSelectRoutine(routineId):

              // if user progress < required:
              // show warning
              // else:
              // navigate to Routine Detail Screen
              // onMarkSetComplete(setId):
              //   update routine progress in local database

              // Preset Routine section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.add, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Warm-up',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Preset sets
                    _WorkoutRow(
                      icon: Icons.directions_walk,
                      weight: '20 kg',
                      reps: '10 reps',
                    ),
                    _WorkoutRow(
                      icon: Icons.directions_walk,
                      weight: '60 kg',
                      reps: '8 reps',
                    ),
                    _WorkoutRow(
                      icon: Icons.looks_one,
                      weight: '80 kg',
                      reps: '5 reps',
                    ),
                    _WorkoutRow(
                      icon: Icons.looks_two,
                      weight: '100 kg',
                      reps: '5 reps',
                    ),
                    _WorkoutRow(
                      icon: Icons.looks_3,
                      weight: '100 kg',
                      reps: '5 reps',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}

class _WorkoutRow extends StatelessWidget {
  final IconData icon;
  final String weight;
  final String reps;

  const _WorkoutRow({
    required this.icon,
    required this.weight,
    required this.reps,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon),
        title: Text(weight),
        subtitle: Text(reps),
        trailing: const Icon(Icons.more_vert),
        onTap: () {},
      ),
    );
  }
}
