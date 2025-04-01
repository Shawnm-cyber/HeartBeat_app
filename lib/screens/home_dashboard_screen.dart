import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  _HomeDashboardScreenState createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int selectedIndex = 0; // Track selected index for bottom navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 228, 236, 231),
      appBar: AppBar(
        title: const Text('Home Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Open navigation drawer or menu
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Work Log Section with Bar Chart Visualization
            const Text(
              'Work Log',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BarChart(
                  BarChartData(
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [
                        BarChartRodData(toY: 5, color: Colors.blue, width: 16)
                      ]),
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(toY: 3, color: Colors.blue, width: 16)
                      ]),
                      BarChartGroupData(x: 2, barRods: [
                        BarChartRodData(toY: 7, color: Colors.blue, width: 16)
                      ]),
                    ],
                    titlesData: FlTitlesData(show: false),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Health Details Section with Line Chart Visualization
            const Text(
              'Health Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 70),
                          FlSpot(1, 72),
                          FlSpot(2, 74),
                          FlSpot(3, 71),
                          FlSpot(4, 73),
                        ],
                        isCurved: true,
                        colors: [Colors.red],
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Goals Section with a Circular Progress Indicator Visualization
            const Text(
              'Goals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Goals Succeeded This Month',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: CircularProgressIndicator(
                          value: 0.75, // 75% progress
                          strokeWidth: 8,
                          color: Colors.green,
                        ),
                      ),
                      const Text(
                        '75%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Upcoming Features Section
            const Text(
              'Upcoming Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Center(
                child: Text(
                  'Stay tuned for further updates!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
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
