import 'package:flutter/material.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Dashboard Screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/workoutLog');
              },
              child: const Text('Go to Workout Log'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calorieTracker');
              },
              child: const Text('Go to Calorie Tracker'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/progressTracking');
              },
              child: const Text('Go to Progress Tracking'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/presetRoutines');
              },
              child: const Text('Go to Preset Routines'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
