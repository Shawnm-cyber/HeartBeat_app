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
      // If name exists, navigate to home screen after a short delay
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }

  
  void _goToHomeDashboard() {
    final userName = _nameController.text.trim();
    // TODO: Store userName somewhere or pass it forward if needed.
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Typically, a splash screen has no AppBar.
      body: Column(
        children: [
          // Top 70%: Image placeholder
          Expanded(
            flex: 7, // ~70% of the screen height
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              child: const Center(
                // Replace this with an Image.asset or Image.network, etc.
                child: Text(
                  'Image Placeholder',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          // Bottom 30%: Text field + button
          Expanded(
            flex: 3, // ~30% of the screen height
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Label
                  const Text('Enter Your Name', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),

                  // Text field and button in a row
                  Row(
                    children: [
                      // Text field
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'e.g. John Doe',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Button
                      ElevatedButton(
                        onPressed: _goToHomeDashboard,
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
