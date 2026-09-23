
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Icons Images and Charts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visual Data'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Header Icon
            const Icon(
              Icons.bar_chart,
              size: 60,
              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            const Text(
              'Student Performance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Local Image
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'assets/images/sample.jpg',
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // Network Image
            const Text(
              'Network Image',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Image.network(
              'https://picsum.photos/600/200',
              height: 150,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            // Icons arranged in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.school, size: 40, color: Colors.blue),
                Icon(Icons.book, size: 40, color: Colors.green),
                Icon(Icons.star, size: 40, color: Colors.orange),
              ],
            ),

            const SizedBox(height: 25),

            // Bar Chart
            const Text(
              'Performance Chart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(toY: 75, width: 25),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(toY: 85, width: 25),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(toY: 65, width: 25),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(toY: 90, width: 25),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
