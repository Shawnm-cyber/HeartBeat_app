import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

   @override
  _SettingsScreenState createState() =>
      _SettingScreenState();
}

  class _SettingsScreenState extends State<SettingsScreen> {
  int selectedIndex = 0; // Track selected index for bottom navigation

  @override
  Widget build(BuildContext context) {
    const backgroundColor = const Color.fromARGB(0, 228, 236, 231);

    return Scaffold(
      backgroundColor: backgroundColor,
      return Scaffold(
        appBar: AppBar(
          title: const Text ('Settings'),
        ),
        body: ListView(
          children: [
          // User Profile Section
          _buildSettingsItem(
            icon:Icons.person,
            title:'User',
            onTap() {
              Navigator.pushNamed(context, ' /userSettings');
           },
        ),
        const Divider(),

        // Health Details Section
        _buildSettingsItem(
          icon: Icons.favorite_border,
          title: 'Health Details',
          onTap() {
            // Will navigate to health details settings
            Navigator.pushNamed(context, ' /healthDetails');
          },
        ),
        const Divider(),

        // Goal Section
        _buildSettingsItem(
          icon: Icons.flag_outlined,
          title: 'Goals',
          onTap: () {
            // Will navigate to goal settings
            Navigator.pushNamed(context,' /goals');
          },
        ),
        const Divider(),
        
        // Measurement Unit Section
        _buildSettingsItem(
          icon: Icons.straighten,
          title: 'Measurement Unit',
          onTap: () {
            // Will navigate to measurement unit settings
            Navigator.pushNamed(context,'/measurementUnit');
          },
        ),
        const Divider(),

        //Notifications Section
        _buildSettingsItem(
          icon: Icons.notifications_none,
          title: 'Notifications',
          onTap: ()  {
          // Will navigate to notification settings
          Navigator.pushNamed(context, '/notifications');
          },
        ),
        const Divider(),

        // Accessibility Section
          _buildSettingsItem(
            icon: Icons.accessibility,
            title: 'Accessibility',
            onTap: () {
              // Navigate to accessibility settings
              Navigator.pushNamed(context, '/accessibility');
            },
          ),
          const Divider(),

          // Help Section
          _buildSettingsItem(
            icon: Icons.help_outline,
            title: 'Help',
            onTap: () {
              // Navigate to help screen
              Navigator.pushNamed(context, '/help');
            },
          ),
        ],
      ),
        
        ),
      ),
    ],
),
// Bottom Navigation Bar with labels only
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            label: 'Work Log', icon: SizedBox.shrink(), // Label for Work Log
          ),
          BottomNavigationBarItem(
            label: 'CalTrack', icon: SizedBox.shrink(), // Label for CalTrack
          ),
          const BottomNavigationBarItem(
            label: 'ProTrack', icon: SizedBox.shrink(), // Label for Progress Tracker
          ),
          const BottomNavigationBarItem(
            label: 'Settings', icon: Icon(Icons.settings), // Label for Settings
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
}