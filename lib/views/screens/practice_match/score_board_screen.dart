import 'dart:typed_data';

import 'package:cricyard/views/screens/practice_match/view/widget/expandable_container.dart';
import 'package:cricyard/views/screens/practice_match/view/widget/overs_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'PracticeMatchService.dart';

class ScoreBoardScreen extends StatefulWidget {
  final int matchId;
  final String team1;
  final String team2;

  const ScoreBoardScreen({
    super.key,
    required this.matchId,
    required this.team1,
    required this.team2,
  });

  @override
  State<ScoreBoardScreen> createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final PracticeMatchService scoreservice = PracticeMatchService();

  List<Map<String, dynamic>> scoreBoardData = [];
  List<dynamic> oversData = [];
  List<Map<String, dynamic>> fallOfWicketDataInnings1 = [];
  List<Map<String, dynamic>> fallOfWicketDataInnings2 = [];

  bool _isLoading = false;
  bool _isLoading2 = false;

  void getScoreBoardData() async {
    setState(() {
      _isLoading = true;
    });
    final res = await scoreservice.getScoreBoard(widget.matchId);
    print("Scoreboard-Res--$res");
    setState(() {
      scoreBoardData = res;
      _isLoading = false;
    });
  }

  void getScoreOversData() async {
    setState(() {
      _isLoading2 = true;
    });
    final res = await scoreservice.getOversDetailsData(widget.matchId);
    print("Over-Res--$res");
    setState(() {
      oversData = res;
      _isLoading2 = false;
    });
  }

  void getFallOfWickets() async {
    final resInnings1 = await scoreservice.getFallOfWicket(widget.matchId, 1);
    final resInnings2 = await scoreservice.getFallOfWicket(widget.matchId, 2);
    setState(() {
      fallOfWicketDataInnings1 = resInnings1;
      fallOfWicketDataInnings2 = resInnings2;
    });
  }

  Future<Uint8List> generateScoreBoardPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text("${widget.team1} vs ${widget.team2} Scoreboard",
                  style: pw.TextStyle(font: pw.Font.helvetica(), fontSize: 20)),
              pw.SizedBox(height: 10),
              for (var data in scoreBoardData)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(8.0),
                      decoration: pw.BoxDecoration(color: PdfColors.blue),
                      child: pw.Text(
                        '${data['name']} - ${data['totalRuns']}/${data['totalWkts']} (${data['overCount']})',
                        style:
                            pw.TextStyle(color: PdfColors.white, fontSize: 16),
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    if (data['players'] != null)
                      pw.Column(
                        children: [
                          pw.Container(
                            color: PdfColors.grey300,
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Container(
                                    width: 100, child: pw.Text('Batsman')),
                                pw.Container(width: 40, child: pw.Text('Runs')),
                                pw.Container(
                                    width: 40, child: pw.Text('Balls')),
                                pw.Container(width: 40, child: pw.Text('4s')),
                                pw.Container(width: 40, child: pw.Text('6s')),
                                pw.Container(width: 40, child: pw.Text('SR')),
                              ],
                            ),
                          ),
                          for (var player in data['players']
                              .where((p) => p['player_type'] == 'Batsman'))
                            pw.Container(
                              color: PdfColors.grey200,
                              child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Container(
                                      width: 100,
                                      child: pw.Text(player['player_name'])),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(
                                          player['total_run'].toString())),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(
                                          player['total_ball'].toString())),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(
                                          player['current_match_four']
                                              .toString())),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(player['current_match_six']
                                          .toString())),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(
                                          player['current_match_strike_rate']
                                              .toString())),
                                ],
                              ),
                            ),
                          pw.Container(
                            color: PdfColors.grey300,
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Container(
                                    width: 100, child: pw.Text('Bowler')),
                                pw.Container(width: 40, child: pw.Text('O')),
                                pw.Container(width: 40, child: pw.Text('M')),
                                pw.Container(width: 40, child: pw.Text('R')),
                                pw.Container(width: 40, child: pw.Text('W')),
                                pw.Container(width: 40, child: pw.Text('ER')),
                              ],
                            ),
                          ),
                          for (var player in data['players']
                              .where((p) => p['player_type'] == 'Baller'))
                            pw.Container(
                              color: PdfColors.grey200,
                              child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Container(
                                      width: 100,
                                      child: pw.Text(player['player_name'])),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(
                                          player['current_match_over']
                                              .toString())),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(
                                          player['current_match_maidan_over']
                                              .toString())),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(player['current_match_run']
                                          .toString())),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(
                                          player['current_match_wicket']
                                              .toString())),
                                  pw.Container(
                                      width: 40,
                                      child: pw.Text(
                                          player['current_match_economy_rate']
                                              .toString())),
                                ],
                              ),
                            ),
                        ],
                      ),
                    pw.SizedBox(height: 10),
                  ],
                ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> generateAndDownloadPdf() async {
    final pdfData = await generateScoreBoardPdf();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfData,
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getScoreBoardData();
    getScoreOversData();
    getFallOfWickets();
    print("match id --${widget.matchId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text("${widget.team1}  v/s  ${widget.team2}",
            style: GoogleFonts.getFont('Poppins',
                fontWeight: FontWeight.w500, fontSize: 22)),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Download PDF'),
                  content: const Text(
                      'Do you want to download the scoreboard details as a PDF?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await generateAndDownloadPdf();
                      },
                      child: const Text('Download',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _buildTabBar(context),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScoreBoardView(),
          _buildOversView(),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF0096c7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        controller: _tabController,
        labelPadding: EdgeInsets.zero,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        dividerColor: Colors.transparent,
        unselectedLabelColor: Colors.white,
        unselectedLabelStyle: GoogleFonts.getFont('Poppins',
            color: Colors.white, fontWeight: FontWeight.w200, fontSize: 12),
        labelStyle: GoogleFonts.getFont('Poppins',
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        tabs: const [
          Tab(child: Text("Scoreboard")),
          Tab(child: Text("Overs")),
        ],
      ),
    );
  }

  Widget _buildScoreBoardView() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: scoreBoardData.length,
            itemBuilder: (context, index) {
              final mData = scoreBoardData[index];
              final fallOfWicketData = (index == 0)
                  ? fallOfWicketDataInnings1
                  : fallOfWicketDataInnings2;
              return ExpandableScoreboardContainer(
                data: mData,
                fallOfWicket: fallOfWicketData,
              );
            },
          );
  }

  Widget _buildOversView() {
    return _isLoading2
        ? const Center(child: CircularProgressIndicator())
        : oversData.isEmpty
            ? Center(
                child: Text(
                  "No Data",
                  style: GoogleFonts.getFont('Poppins', color: Colors.black),
                ),
              )
            : ListView.builder(
                itemCount: oversData.length,
                itemBuilder: (context, index) {
                  final mData = oversData[index];
                  final overNumber = mData.keys.first;
                  final data = mData[overNumber];
                  return data == null
                      ? Center(
                          child: Text(
                            "No Data",
                            style: GoogleFonts.getFont('Poppins',
                                color: Colors.black),
                          ),
                        )
                      : OversContainer(
                          overNumber: overNumber,
                          data: data,
                        );
                },
              );
  }
}
