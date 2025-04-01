import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Dashboard')),
      leading: IconButton(
         icon: const Icon(Icons.menu),
         onPressed: () {
          // This will open navigation drawer or meny
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
    body:SingelChildScrollView(
      padding: const EdgeInsets.all(16.0),
      chold: Column(
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
              color:Colors.grey[200],
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
                  titlesData: 
                  FlTitlesData(showTitles:false),
                 )
              )
              ),
          )

        ],
      )
