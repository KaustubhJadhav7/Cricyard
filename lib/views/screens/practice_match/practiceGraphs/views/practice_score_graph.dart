import 'dart:async';
import 'package:cricyard/views/screens/practice_match/practiceGraphs/viewmodel/practice_graph_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CricketScoreGraph extends StatelessWidget {
  final Future<List<FlSpot>> team1Data;
  final Future<List<FlSpot>> team2Data;

  const CricketScoreGraph({
    required this.team1Data,
    required this.team2Data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([team1Data, team2Data]),
      builder:
          (BuildContext context, AsyncSnapshot<List<List<FlSpot>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: GoogleFonts.getFont('Poppins', color: Colors.black),
          ));
        } else {
          final List<FlSpot> team1Spots = snapshot.data![0];
          final List<FlSpot> team2Spots = snapshot.data![1];

          // Handle empty data
          if (team1Spots.isEmpty && team2Spots.isEmpty) {
            return Center(
              child: Text(
                'No Data Available',
                style: GoogleFonts.getFont('Poppins', color: Colors.black),
              ),
            );
          }

          return LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: team1Spots,
                  color: Colors.blue,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
                LineChartBarData(
                  spots: team2Spots,
                  color: Colors.red,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
              ),
              gridData: const FlGridData(show: false),
            ),
          );
        }
      },
    );
  }
}

class PracticeScoreGraph extends StatefulWidget {
  final int matchId;
  const PracticeScoreGraph({Key? key, required this.matchId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PracticeScoreGraphState();
}

class PracticeScoreGraphState extends State<PracticeScoreGraph> {
  final PracticeGraphService _graphService = PracticeGraphService();

  Future<List<FlSpot>> fetchTeam1Data() =>
      _graphService.fetchDataFromApi(widget.matchId); // Example match ID
  Future<List<FlSpot>> fetchTeam2Data() =>
      _graphService.fetchDataFromApi(widget.matchId); // Example match ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: Colors.grey[200],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFF219ebc),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          "Score Graph",
          style:
              GoogleFonts.getFont('Poppins', fontSize: 20, color: Colors.black),
        ),
      ),
      body: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 6),
          child: CricketScoreGraph(
            team1Data: fetchTeam1Data(),
            team2Data: fetchTeam2Data(),
          ),
        ),
      ),
    );
  }
}
