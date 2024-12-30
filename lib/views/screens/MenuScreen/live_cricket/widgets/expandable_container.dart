import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandableContainer extends StatefulWidget {
  final Map<String, dynamic> data;
  final String teamName;

  ExpandableContainer({required this.data,required this.teamName});

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final overData = widget.data;
    final balls = overData['balls'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggleExpand,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _mainTitleWidget(
                      overCount: overData['overCount'],
                      runsInCurrentOver: overData['runsInCurrentOver'],
                      wktsInCurrentOver: overData['wktsInCurrentOver'],
                      totalRuns: overData['totalScore'],
                      totalWkts: overData['totalWkts'],
                    ),
                    if (_isExpanded)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          itemCount: balls.length,
                          itemBuilder: (context, index) {
                            final ballData = balls[index];
                            return _contentWidget(
                              ballStatus: ballData['ballStatus'],
                              time: ballData['time'],
                              runs: ballData['score'],
                              wkts: ballData['wkts'],
                              overs: ballData['overs'],
                              overCount: ballData['overCount'],
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainTitleWidget({
    required int overCount,
    required int runsInCurrentOver,
    required int wktsInCurrentOver,
    required int totalRuns,
    required int totalWkts,
  }) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${overCount}th Over :",
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    " $runsInCurrentOver runs, ${wktsInCurrentOver}w",
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${widget.teamName} : $totalRuns-$totalWkts",
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _isExpanded
                      ? const Icon(
                    Icons.arrow_drop_up,
                    color: Colors.white,
                  )
                      : const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentWidget({
    required String ballStatus,
    required String time,
    required int runs,
    required int wkts,
    required double overs,
    required int overCount,
  }) {
    Color? getBackgroundColor(String ballStatus) {
      switch (ballStatus) {
        case 'W':
          return Colors.red;
        case '1':
        case '2':
        case '3':
          return Colors.blue;
        case '4':
          return Colors.green;
        case '6':
          return Colors.green;
        case 'WD':
          return Colors.grey[300];
        case 'NB':
          return Colors.red;
        case 'LB':
          return Colors.blueAccent;
        default:
          return Colors.grey; // Default color for any other cases
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const Divider(color: Colors.white, thickness: 0.5),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: getBackgroundColor(ballStatus),
                              child: Text(
                                ballStatus,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "$runs - $wkts",
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "$overs",
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "$time",
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child:  Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(widget.teamName)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "47",
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent[100],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "50",
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "$overCount Overs",
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Center(
                                  child: Text(
                                    "147",
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Center(
                                  child: Text(
                                    "150",
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
