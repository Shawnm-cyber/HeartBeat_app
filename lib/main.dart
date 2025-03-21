import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_dashboard_screen.dart';

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
      },
    );
  }
}
