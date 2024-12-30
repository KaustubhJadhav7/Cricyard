import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ScoreGraphScreen extends StatefulWidget {
  const ScoreGraphScreen({Key? key}) : super(key: key);

  @override
  State<ScoreGraphScreen> createState() => _ScoreGraphScreenState();
}

class _ScoreGraphScreenState extends State<ScoreGraphScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket Score Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false), // Remove background grid lines
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1, // Display every 1 unit
                    getTitlesWidget: (value, meta) {
                      // Display over number on x-axis
                      return Text('${value.toInt()}');
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // Display run value on y-axis
                      return Text('${value.toInt()}');
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 0), // Over 1
                    FlSpot(1, 3), // Over 2
                    FlSpot(2, 15), // Over 3
                    FlSpot(3, 22), // Over 4
                    FlSpot(4, 28), // Over 5
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
