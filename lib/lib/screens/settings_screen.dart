import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFDCE6D7);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 24), // Placeholder to balance layout
                ],
              ),
            ),

            const SizedBox(height: 20),

            // User section
            const Icon(Icons.person, size: 48),
            const SizedBox(height: 8),
            const Text(
              'User',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Log Out',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // Settings options
            const _SettingsTile(icon: Icons.favorite, label: 'Health Details'),
            const _SettingsTile(icon: Icons.track_changes, label: 'Goals'),
            const _SettingsTile(
              icon: Icons.straighten,
              label: 'Measurement Unit',
            ),
            const _SettingsTile(
              icon: Icons.notifications,
              label: 'Notifications',
            ),
            const _SettingsTile(
              icon: Icons.accessibility,
              label: 'Accessibility',
            ),
            const _SettingsTile(icon: Icons.help_outline, label: 'Help'),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Settings is index 3
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

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SettingsTile({required this.icon, required this.label, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.withOpacity(0.2),
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // TODO: Handle settings tap
      },
    );
  }
}
