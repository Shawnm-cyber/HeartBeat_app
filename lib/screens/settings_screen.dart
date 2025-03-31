import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
    ],
),