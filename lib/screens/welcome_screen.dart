import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
