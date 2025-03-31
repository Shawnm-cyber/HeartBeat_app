import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/workout_log_screen.dart';
import 'screens/calorie_tracker_screen.dart';
import 'screens/progress_tracking_screen.dart';
import 'screens/preset_routines_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const HeartBeatApp());
}

class HeartBeatApp extends StatelessWidget {
  const HeartBeatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeartBeat',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeDashboardScreen(),
        '/workoutLog': (context) => const WorkoutLogScreen(),
        '/calorieTracker': (context) => const CalorieTrackerScreen(),
        '/progressTracking': (context) => const ProgressTrackingScreen(),
        '/presetRoutines': (context) => const PresetRoutinesScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
