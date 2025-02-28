import 'package:flutter/material.dart';

import '../../../../../Entity/runs/Score_board/repository/Score_board_api_service.dart';

class ScoreBoardManager {
  score_boardApiService scoreservice = score_boardApiService();
  final int tournamentId;
  final int matchId;
  final int inning;
  final int striker;
  final int nonStriker;
  final int baller;

  ScoreBoardManager(
    this.inning,
    this.striker,
    this.nonStriker,
    this.baller, {
    required this.tournamentId,
    required this.matchId,
  });

  Future<void> updateAllData(BuildContext context) async {
    await getUpdatedScore(context).then(
      (_) async => await getLastRecOfPlayer(),
    );
    // getLastRecOfPlayer();
  }

  Future<void> getUpdatedScore(BuildContext context) async {
    try {
      await scoreservice.getlastrecord(tournamentId, matchId);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              'Failed to fetch : $e',
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // get last record of player career
  Future<void> getLastRecOfPlayer() async {
    print('match id is $matchId');
    
    await scoreservice.getlastrecordPlayerCareer(matchId, inning, striker);
    await scoreservice.getlastrecordPlayerCareer(matchId, inning, nonStriker);
    await scoreservice.getlastrecordPlayerCareer(matchId, inning, baller);
  }
}
