import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkForSavedName();
  }
  
  // Check if user's name is already saved
  Future<void> _checkForSavedName() async {
    final prefys = await SharedPreferences.getInstance();
    final savedName = prefys.getString('user_name');
    if (savedName != null && savedName.isNotEmpty) {
      // If name exists, navigate to home dashboard after a short delay
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }

  // Save the user's name and thereafter navigate to the home dashboard
  Future<void> _saveNameAndContinue() async {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      final prefys = await SharedPreferences.getInstance();
      await prefys.setString('user_name', name);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error if the name field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text ('Please enter your name')),
      );
    }
  }
  
// Built UI for SplashScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 228, 236, 231), // Set the background color
      // Typically, a splash screen has no AppBar.
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                "Let's get stronger together!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'HeartBeat helps you track your workouts, set fitness goals, and stay enthused to achieve a stronger you.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveNameAndContinue, 
                child: const Text('Get Started')),
            ],
          ),
        ),
      ),
    );
  }
}

            