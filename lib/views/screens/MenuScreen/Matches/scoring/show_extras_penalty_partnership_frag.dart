import 'package:cricyard/views/screens/MenuScreen/Matches/scoring/scoreboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Entity/runs/Score_board/Score_board_api_service.dart';

class ShowExtras_Partnership_PenaltyFrag {
  final score_boardApiService scoreservice = score_boardApiService();
  final TextEditingController _penaltyRunsController = TextEditingController();

  Future<void> showExtrasAndPenaltyDialog(
      BuildContext ctx,
      type,
      Map<String, dynamic> extraRunsMap,
      List<Map<String, dynamic>> partnershipMap,
      matchId,
      inning,
      tourId,
      striker,
      nonStriker,
      baller,
      BuildContext context) async {
    // Show dialog with options
    showDialog<String>(
      context: ctx,
      builder: (BuildContext ctx) {
        if (type == 'extras') {
          print("Data:- type== $type");
          print("matchId: $matchId");
          return AlertDialog(
            title: const Text('Extra runs'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${extraRunsMap['B']} B",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "${extraRunsMap['LB']} LB",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "${extraRunsMap['WD']} WD",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "${extraRunsMap['NB']} NB",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "${extraRunsMap['P']} P",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          );
        } else if (type == 'partnership') {
          return AlertDialog(
            title: const Text('Partnership'),
            content: Container(
              width: MediaQuery.of(ctx).size.width * 1.4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: partnershipMap.length,
                itemBuilder: (context, index) {
                  final data = partnershipMap[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          "${data['striker']} - ${data['non-striker']}",
                          style: GoogleFonts.getFont('Poppins',
                              fontSize: 12, color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${data['runsScored']} R  ${data['ballsPlayed']} B",
                          style: GoogleFonts.getFont('Poppins',
                              fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
        return AlertDialog(
          title: const Text('Select Penalty Runs'),
          content: TextField(
            keyboardType: const TextInputType.numberWithOptions(),
            controller: _penaltyRunsController,
            decoration: const InputDecoration(
                labelText: 'Penalty Runs',
                labelStyle: TextStyle(color: Colors.black)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                print("Data:- type== $type");
                print("runs: ${_penaltyRunsController.text}");
                print("matchId: $matchId");
                print("innings: $inning");
                try {
                  Navigator.pop(ctx);
                  scoreservice
                      .postOverThrowAndPenalty(
                          int.parse(_penaltyRunsController.text),
                          matchId,
                          inning,
                          'Penalty')
                      .then(
                    (value) async {
                      await ScoreBoardManager(
                              inning, striker, nonStriker, baller,
                              tournamentId: tourId, matchId: matchId)
                          .updateAllData(context);
                    },
                  );
                  // );
                } finally {
                  Navigator.pop(ctx);
                }
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
