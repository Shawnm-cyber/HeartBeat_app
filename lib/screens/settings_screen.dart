import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int selectedIndex = 0; // Track selected index for bottom navigation

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(255, 228, 236, 231);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSettingsItem(
            icon: Icons.person,
            title: 'User',
            onTap: () {
              Navigator.pushNamed(context, '/userSettings');
            },
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.favorite_border,
            title: 'Health Details',
            onTap: () {
              Navigator.pushNamed(context, '/healthDetails');
            },
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.flag_outlined,
            title: 'Goals',
            onTap: () {
              Navigator.pushNamed(context, '/goals');
            },
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.straighten,
            title: 'Measurement Unit',
            onTap: () {
              Navigator.pushNamed(context, '/measurementUnit');
            },
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.accessibility,
            title: 'Accessibility',
            onTap: () {
              Navigator.pushNamed(context, '/accessibility');
            },
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.help_outline,
            title: 'Help',
            onTap: () {
              Navigator.pushNamed(context, '/help');
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Work Log',
            icon: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            label: 'CalTrack',
            icon: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            label: 'ProTrack',
            icon: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

// Helper method to build a single settings item
Widget _buildSettingsItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: onTap,
  );
}
