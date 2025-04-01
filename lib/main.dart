import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/workout_log_screen.dart';
import 'screens/calorie_tracker_screen.dart';
import 'screens/progress_tracking_screen.dart';
import 'screens/preset_routines_screen.dart';
import 'screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/meal.dart';
import 'models/routine.dart';
import 'models/workout.dart';
import 'models/goal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(RoutineAdapter());
  Hive.registerAdapter(RoutineSetAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(GoalAdapter());
  await Hive.openBox<Workout>('workoutsBox');
  await Hive.openBox<Meal>('mealsBox');
  await Hive.openBox('settingsBox');
  await Hive.openBox<Routine>('routinesBox');
  await Hive.openBox<Goal>('goalsBox');

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
        '/welcome': (context) => const SplashScreen(),
        '/home': (context) => const HomeDashboardScreen(),
        '/workoutLog': (context) => const WorkoutLogScreen(),
        '/calorieTracker': (context) => const CalorieTrackerScreen(),
        '/progressTracking': (context) => ProgressTrackingScreen(),
        '/presetRoutines': (context) => const PresetRoutinesScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
