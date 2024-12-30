import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TourExpandableScoreboardContainer extends StatefulWidget {
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> fallOfWicket;
  const TourExpandableScoreboardContainer({super.key, required this.data, required this.fallOfWicket});

  @override
  State<TourExpandableScoreboardContainer> createState() =>
      _TourExpandableScoreboardContainerState();
}

class _TourExpandableScoreboardContainerState
    extends State<TourExpandableScoreboardContainer> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: _toggleExpand,
        child: Column(
          children: [
            _mainTitleWidget(),
            if (_isExpanded) _buildPlayerDetails(widget.data['players']),
          ],
        ),
      ),
    );
  }

  Widget _mainTitleWidget() {
    return Container(
      decoration: const BoxDecoration(color: Color(0xff0077b6)),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.data['name']}',
              style: GoogleFonts.getFont('Poppins',
                  color: Colors.white, fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  "${widget.data['totalRuns']}/${widget.data['totalWkts']}",
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "(${widget.data['overCount']})",
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.white, fontSize: 14),
                ),
                const SizedBox(
                  width: 8,
                ),
                _isExpanded
                    ? const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerDetails(List<dynamic>? players) {
    if (players == null) {
      print("Players list is null");
      return Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.red,
        child: const Text("No player data available"),
      );
    }

    print("Players--$players");

    List<dynamic> batsmen = players
        .where((player) => player != null && player['player_type'] == 'Batsman')
        .toList();
    List<dynamic> bowlers = players
        .where((player) => player != null && player['player_type'] == 'Baller')
        .toList();

    return Column(
      children: [
        _buildBatsmanTableHeader(),
        for (var player in batsmen) ...[
          _buildBatsmanRow(player),
          const Divider(color: Color(0xffe9ecef)),
        ],
        // _buildExtrasRow(extras),
        _buildBowlerTableHeader(),
        for (var player in bowlers) ...[
          _buildBowlerRow(player),
          const Divider(color: Color(0xffe9ecef)),
        ],
        _buildFallOfWicketsTableHeader(),
        for(var fallWicket in widget.fallOfWicket)...[
          _buildFallOfWicketsRow(fallWicket),
        ],
      ],
    );
  }

  Widget _buildBatsmanTableHeader() {
    return Container(
      color: const Color(0xffced4da),
      child: Table(
        children: [
          TableRow(
            children: [
              _buildTableCell("Batsman", isHeader: true),
              _buildTableCell("Runs", isHeader: true),
              _buildTableCell("Balls", isHeader: true),
              _buildTableCell("4s", isHeader: true),
              _buildTableCell("6s", isHeader: true),
              _buildTableCell("SR", isHeader: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBowlerTableHeader() {
    return Container(
      color: const Color(0xffced4da),
      child: Table(
        children: [
          TableRow(
            children: [
              _buildTableCell("Bowler", isHeader: true),
              _buildTableCell("O", isHeader: true),
              _buildTableCell("M", isHeader: true),
              _buildTableCell("R", isHeader: true),
              _buildTableCell("W", isHeader: true),
              _buildTableCell("ER", isHeader: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallOfWicketsTableHeader() {
    return Container(
      color: const Color(0xffced4da),
      child: Table(
        children: [
          TableRow(
            children: [
              _buildTableCell("Fall of Wickets ", isHeader: true),
              _buildTableCell("Score", isHeader: true),
              _buildTableCell("Over", isHeader: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBatsmanRow(Map<String, dynamic> player) {
    return Container(
      color: Colors.grey[300],
      child: Table(
        children: [
          TableRow(
            children: [
              _buildTableCell("${player["player_name"]}\n${player["out_type"]}",
                  isHeader: false),
              _buildTableCell(player["current_match_run"].toString(),
                  isHeader: false),
              _buildTableCell(player["current_match_ball"].toString(),
                  isHeader: false),
              _buildTableCell(player["current_match_four"].toString(),
                  isHeader: false),
              _buildTableCell(player["current_match_six"].toString(),
                  isHeader: false),
              _buildTableCell(player["current_match_strike_rate"].toString(),
                  isHeader: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBowlerRow(Map<String, dynamic> player) {
    return Container(
      color: Colors.grey[300],
      child: Table(
        children: [
          TableRow(
            children: [
              _buildTableCell(player["player_name"], isHeader: false),
              _buildTableCell(player["overs"].toString(), isHeader: false),
              _buildTableCell(player["maidens"].toString(), isHeader: false),
              _buildTableCell(player["current_match_run"].toString(),
                  isHeader: false),
              _buildTableCell(player["current_match_wicket"].toString(),
                  isHeader: false),
              _buildTableCell(player["economyRate"].toString(),
                  isHeader: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExtrasRow(Map<String, dynamic> data) {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Extras:",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${data['totalExtra']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black)), // TOTAL
              const SizedBox(
                width: 4,
              ),
              Text("${data['B']} B,",
                  style: const TextStyle(color: Colors.black)),
              Text("${data['LB']} LB,",
                  style: const TextStyle(color: Colors.black)),
              Text("${data['WD']} WD,",
                  style: const TextStyle(color: Colors.black)),
              Text("${data['NB']} NB,",
                  style: const TextStyle(color: Colors.black)),
              Text("${data['P']} P,",
                  style: const TextStyle(color: Colors.black)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFallOfWicketsRow(Map<String,dynamic> data) {
    return Container(
      color: const Color(0xffe9ecef),
      child: Table(
        children: [
          TableRow(
            children: [
              _buildTableCell('${data['playerName']}', isHeader: false),
              _buildTableCell('${data['Score']}/${data['Wicket']}', isHeader: false),
              _buildTableCell('${data['Over']}.${data['Ball']}',
                  isHeader: false),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: isHeader ? Colors.black : Colors.black,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
