import 'package:cricyard/views/screens/practice_match/practiceAppUrls/practice_appurls.dart';

import '../../../../data/network/base_network_service.dart';
import '../../../../data/network/network_api_service.dart';

class PracticeRepo {
  final BaseNetworkService _networkService = NetworkApiService();

  Future<dynamic> createPracticeMatch(
    dynamic data,
  ) async {
    try {
      final response = await _networkService.getPostApiResponse(
          PracticeAppurls.createPracticeMatch, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllmatches() async {
    try {
      final response = await _networkService
          .getGetApiResponse(PracticeAppurls.getAllmatches);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllWithPagination(int page, int size) async {
    try {
      final response = await _networkService.getGetApiResponse(
        '${PracticeAppurls.getAllWithPagination}?page=$page&size=$size',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

// get all teams
  Future<dynamic> getAllTeams() async {
    try {
      final response =
          await _networkService.getGetApiResponse(PracticeAppurls.getAllTeams);
      return response;
    } catch (e) {
      rethrow;
    }
  }

//   Future<void> updateEntity(int entityId, Map<String, dynamic> entity) async {
//     try {
//       await dio.put('$baseUrl/token/Practice/score/Score_board/$entityId',
//           data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

  Future<void> deleteEntity(int entityId) async {
    await _networkService.getDeleteApiResponse(PracticeAppurls.deleteEntity);
  }

// // get last record of score
  Future<dynamic> getlastrecord(int matchId) async {
    try {
      final response = await _networkService
          .getGetApiResponse('${PracticeAppurls.getlastrecord}/$matchId');
      return response;
    } catch (e) {
      rethrow;
    }
  }

//   // get last record of player career
//   Future<Map<String, dynamic>> getlastrecordPlayerCareer(
//       int matchId, int inning, String playerName) async {
//     try {
//       final response = await dio.get(
//           '$baseUrl/token/practice/playercareer/career/$matchId/$inning?playerName=$playerName');

//       // print('$playerName response ${response.data}');
//       // Check if response is successful and data is not null
//       if (response.statusCode == 200 && response.data != null) {
//         print('$matchId .. $playerName response get..');
//         // Assuming the response is a Map<String, dynamic>
//         Map<String, dynamic> responseData = response.data;
//         print('$playerName respone.. $responseData');
//         return responseData;
//       } else {
//         Map<String, dynamic> errorresponseData = {'message': 'not found'};
//         return errorresponseData;
//       }
//     } catch (e) {
//       // Handle errors and return null
//       print('Failed to get last record: $e');
//       Map<String, dynamic> errorresponseData = {'message': '$e'};
//       return errorresponseData;
//     }
//   }

// // All balls of over
//   Future<List<dynamic>> allballofOvers(int matchId) async {
//     try {
//       final response =
//           await dio.get('$baseUrl/token/Practice/score/ballstatus/$matchId');

//       if (response.statusCode == 200 && response.data != null) {
//         List<dynamic> responseData = response.data;
//         print('over resp: $responseData');

//         return responseData;
//       } else {
//         List<dynamic> errorresponseData = [];
//         return errorresponseData;
//       }
//     } catch (e) {
//       // Handle errors and return null
//       print('Failed to get last record: $e');
//       List<dynamic> errorresponseData = [];
//       return errorresponseData;
//     }
//   }

// // update score
//   Future<Map<String, dynamic>> updateScore(
//       int scdata, String type, Map<String, dynamic> entity) async {
//     try {
//       final response = await dio.post(
//           '$baseUrl/token/Practice/score/score/$scdata/$type',
//           data: entity);
//       // Assuming the response is a Map<String, dynamic>
//       Map<String, dynamic> responseData = response.data;

//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to create entity: $e');
//     }
//   }

//   // strike rotation
//   Future<Map<String, dynamic>> strikerotation(
//       Map<String, dynamic> entity) async {
//     try {
//       final response = await dio
//           .post('$baseUrl/token/Practice/score/strikerotation', data: entity);
//       // Assuming the response is a Map<String, dynamic>
//       Map<String, dynamic> responseData = response.data;

//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to Strike Rotate: $e');
//     }
//   }

// // get All team
//   Future<List<Map<String, dynamic>>> getAllTeam() async {
//     try {
//       final response =
//           await dio.get('$baseUrl/token/Practice/Teams/PracticeTeam/myTeam');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all Teams: $e');
//     }
//   }

  Future<dynamic> createNewTeam(dynamic data) async {
    try {
      final response = await _networkService.getPostApiResponse(
          PracticeAppurls.createPracticeMatch, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

//   // add new player to team in teams screen
//   void addNewPlayer(String playerName, int teamId) async {
//     try {
//       Map<String, dynamic> entity = {};

//       entity['team_id'] = teamId;
//       entity['player_name'] = playerName;

//       final response = await dio.post(
//           '$baseUrl/token/Practice/Player/PracticeTeamPlayer',
//           data: entity);
//       print('Create new Player res--$response');
//     } catch (e) {}
//   }

// // update player
//   void updatePlayer(String playerName, int teamId) async {
//     try {
//       Map<String, dynamic> entity = {};

//       entity['team_id'] = teamId;
//       entity['player_name'] = playerName;

//       final response = await dio.post(
//           '$baseUrl/token/Practice/Player/PracticeTeamPlayer',
//           data: entity);

//       print('Create new Player res--$response');
//     } catch (e) {}
//   }

//   Future<void> wicket({
//     required String outType,
//     required String outPlayer,
//     required String playerHelped,
//     required String newPlayer,
//     required Map<String, dynamic> lastRec,
//   }) async {
//     print("Request details: \n"
//         "Out Type: $outType\n"
//         "Out Player: $outPlayer\n"
//         "Player Helped: $playerHelped\n"
//         "New Player: $newPlayer\n"
//         "Last Record: $lastRec");

//     try {
//       final res = await dio.post(
//         "$baseUrl/token/Practice/score/wicket?type=wicket&outType=$outType&outplayerType=$outPlayer&whohelped=$playerHelped&NewPlayerName=$newPlayer",
//         data: lastRec,
//       );
//       print("Response: ${res.data}");
//     } catch (e) {
//       if (e is DioException) {
//         print("Error details: ${e.response?.data}");
//         print("Status code: ${e.response?.statusCode}");
//       } else {
//         print("Unexpected error: $e");
//       }
//       log('Error while taking wicket: $e');
//     }
//   }

//   Future<void> runOutwicket({
//     required String outType,
//     required String outPlayer,
//     required String playerHelped,
//     required String newPlayer,
//     required int run,
//     required Map<String, dynamic> lastRec,
//   }) async {
//     print("Request details: \n"
//         "Out Type: $outType\n"
//         "Out Player: $outPlayer\n"
//         "Player Helped: $playerHelped\n"
//         "New Player: $newPlayer\n"
//         "Last Record: $lastRec");

//     try {
//       final res = await dio.post(
//         "$baseUrl/token/Practice/score/wicket/runout?type=wicket&outType=$outType&outplayerType=$outPlayer&whohelped=$playerHelped&NewPlayerName=$newPlayer&run=$run",
//         data: lastRec,
//       );
//       print("Response: ${res.data}");
//     } catch (e) {
//       if (e is DioException) {
//         print("Error details: ${e.response?.data}");
//         print("Status code: ${e.response?.statusCode}");
//       } else {
//         print("Unexpected error: $e");
//       }
//       log('Error while taking wicket: $e');
//     }
//   }

// // new player entry
//   Future<void> newPlayerEntry(
//     String playerType,
//     String newPlayerName,
//     String batsmanplayerType,
//     Map<String, dynamic> lastRec,
//   ) async {
//     print("Request details: \n"
//         "playerType: $playerType\n"
//         "newPlayerName: $newPlayerName\n"
//         "batsmanplayerType: $batsmanplayerType\n"
//         "Last Record: $lastRec");

//     try {
//       final res = await dio.post(
//           "$baseUrl/token/Practice/score/newplayer/entry?playerType=$playerType&NewPlayerName=$newPlayerName&batsmanplayerType=$batsmanplayerType",
//           data: lastRec);
//       print("Response: ${res.data}");
//     } catch (e) {
//       if (e is DioException) {
//         print("Error details: ${e.response?.data}");
//         print("Status code: ${e.response?.statusCode}");
//       } else {
//         print("Unexpected error: $e");
//       }
//       log('Error while taking wicket: $e');
//     }
//   }

  // new player entry  after inning end

  // new Player Entry After Inning end
  Future<dynamic> newPlayerEntryInningend(
    String striker,
    String nonStriker,
    String baller,
    Map<String, dynamic> lastRec,
  ) async {
    try {
      final response = await _networkService.getPostApiResponse(
          '${PracticeAppurls.newPlayerEntryInningend}?striker=$striker&non_striker=$nonStriker&baller=$baller',
          lastRec);
      return response;
    } catch (e) {
      rethrow;
    }
  }

//   Future<void> updateBowler1(String playerName, int matchId) async {
//     print("New-Bowler-Details\nName-$playerName\nmatchid-$matchId");
//     try {
//       dio.post('');
//     } catch (e) {
//       print("Error-Updating Bowler -- $e");
//     }
//   }

//   Future<void> undo(int matchId, int inning) async {
//     try {
//       await dio.post('$baseUrl/token/Practice/score/undo/$matchId/$inning');
//     } catch (e) {
//       print("Error undoing $e");
//     }
//   }

//   Future<List<Map<String, dynamic>>> getScoreBoard(int matchId) async {
//     try {
//       final res = await dio.get(
//           '$baseUrl/token/practice/playercareer/scorecard?matchId=$matchId');
//       if (res.statusCode == 200) {
//         List<dynamic> data = res.data;
//         List<Map<String, dynamic>> scoreBoardData =
//             data.map((item) => Map<String, dynamic>.from(item)).toList();
//         return scoreBoardData;
//       } else {
//         print("Error Fetching Scoreboard: ${res.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching scoreboard: $e");
//     }
//     return [];
//   }

//   Future<List<dynamic>> getOversDetailsData(int matchId) async {
//     try {
//       final res =
//           await dio.get('$baseUrl/token/Practice/score/everyOver/$matchId');
//       print("OVERS-DATA--${res.data}");
//       if (res.statusCode == 200) {
//         if (res.data is List) {
//           // If the response data is directly a List
//           return res.data;
//         } else if (res.data is Map) {
//           // If the response data is a Map, convert it to a List
//           return [res.data];
//         } else {
//           print("Error: Response data is neither a list nor a map");
//         }
//       } else {
//         print("Error Fetching everyOver: ${res.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching scoreboard: $e");
//     }
//     return [];
//   }

//   // for penalty and over throw runs
//   Future<void> postOverThrowAndPenalty(
//       int runs, int matchId, int innings, String type) async {
//     print('$type -Details\Runs-$runs\nmatchid-$matchId\n innings-$innings');
//     try {
//       Map<String, dynamic> entity = {};

//       final res = await dio.post(
//           "$baseUrl/token/Practice/score/penalty?type=$type&matchId=$matchId&inning=$innings&runs=$runs",
//           data: entity);
//     } catch (e) {
//       print("Error-Updating Bowler -- $e");
//     }
//   }

//   // get extra runs in innings
//   Future<Map<String, dynamic>> getExtrasDetails(
//       int matchId, int innings) async {
//     try {
//       final response =
//           await dio.get('$baseUrl/token/Practice/score/extra/$matchId');

//       if (response.statusCode == 200 && response.data != null) {
//         Map<String, dynamic> responseData = response.data;
//         print('Extras runs: $responseData');

//         return responseData;
//       } else {
//         Map<String, dynamic> errorresponseData = {};
//         return errorresponseData;
//       }
//     } catch (e) {
//       // Handle errors and return null
//       print('Failed to get last record: $e');
//       Map<String, dynamic> errorresponseData = {};
//       return errorresponseData;
//     }
//   }

//   // get partnership in innings
//   Future<List<Map<String, dynamic>>> getPartnershipDetails(int matchId) async {
//     try {
//       final response =
//           await dio.get('$baseUrl/token/Practice/score/partnership/$matchId');
//       print("Kachha res--${response.data}");

//       if (response.statusCode == 200 && response.data != null) {
//         List<dynamic> data = response.data;
//         List<Map<String, dynamic>> responseData =
//             data.map((item) => Map<String, dynamic>.from(item)).toList();
//         print('Partnership : $responseData');

//         return responseData;
//       } else {
//         List<Map<String, dynamic>> errorresponseData = [];
//         return errorresponseData;
//       }
//     } catch (e) {
//       // Handle errors and return null
//       print('Failed to get Partnership: $e');
//       List<Map<String, dynamic>> errorresponseData = [];
//       return errorresponseData;
//     }
//   }

  // one api needed for getting all players in one team , deleting team,deleting players form team and adding player to team and editing player name in team

  // get All Players In Team
  Future<dynamic> getAllPlayersInTeam(int teamId) async {
    try {
      final response = await _networkService
          .getGetApiResponse('${PracticeAppurls.getAllPlayersInTeam}/$teamId');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // // delete  player  in teams screen
  // Future<void> deletePlayer(int id) async {
  //   try {
  //     final response = await dio
  //         .delete('$baseUrl/token/Practice/Player/PracticeTeamPlayer/$id');
  //     print('delete player form team  res--$response');
  //   } catch (e) {
  //     print('Failed to delete player form team $e');
  //   }
  // }

  // // delete  team  in teams screen
  // Future<void> deleteTeam(int id) async {
  //   try {
  //     final response =
  //         await dio.delete('$baseUrl/token/Practice/Teams/PracticeTeam/$id');
  //     print('delete   team  res--$response');
  //   } catch (e) {
  //     print('Failed to delete  team $e');
  //   }
  // }

  // // edit   player name  in teams screen

  // // edit   player name  in teams screen
  // Future<void> editPlayerName(String playerName, int teamId, int id) async {
  //   try {
  //     final response = await dio.post(
  //         '$baseUrl/token/Practice/Player/PracticeTeamPlayer/$id/team_id=$teamId,player_name=$playerName');
  //     print('edit player name  in teams screen res--$response');
  //   } catch (e) {
  //     print('failed to edit   player name  in teams screen $e');
  //   }
  // }

  // Future<void> editTeamName(String teamName, int id) async {
  //   try {
  //     final response = await dio.put(
  //       '$baseUrl/token/Practice/Teams/PracticeTeam/$id',
  //       data: {
  //         'team_name': teamName,
  //       },
  //     );
  //     print('edit team name  in teams screen res--$response');
  //   } catch (e) {
  //     print('failed to edit   team name  in teams screen $e');
  //   }
  // }

  // // for WD,LB AND other  runs
  // Future<void> postWideExtra(String type, int runs, int matchId, int innings,
  //     Map<String, dynamic> lastRec) async {
  //   print(
  //       'Details---$type \nRuns- $runs\nmatchid- $matchId\n innings-$innings');
  //   try {
  //     await dio.post(
  //         '$baseUrl/token/Practice/score/extra/$matchId/$innings/$runs/$type',
  //         data: lastRec);
  //   } catch (e) {
  //     print("Error-Updating Bowler -- $e");
  //   }
  // }

  Future<dynamic> archiveMatch(int matchId) async {
    try {
      final response = await _networkService
          .getGetApiResponse('${PracticeAppurls.archiveMatch}/$matchId');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> unArchiveMatch(int matchId) async {
    try {
      final response = await _networkService
          .getGetApiResponse('${PracticeAppurls.unArchiveMatch}/$matchId');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllArchivedMatches() async {
    try {
      final response = await _networkService
          .getGetApiResponse(PracticeAppurls.getAllArchivedMatches);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<List<Map<String, dynamic>>> getFallOfWicket(
  //     int matchId, int inning) async {
  //   try {
  //     final response = await dio.post(
  //         '$baseUrl/token/Practice/score/wicket/fall?matchId=$matchId&inning=$inning');

  //     if (response.statusCode == 200 && response.data != null) {
  //       List<dynamic> data = response.data;
  //       print("Raw res--$data");
  //       List<Map<String, dynamic>> responseData =
  //           data.map((item) => Map<String, dynamic>.from(item)).toList();
  //       print('$matchId fall of wickets : $responseData');

  //       return responseData;
  //     } else {
  //       List<Map<String, dynamic>> errorresponseData = [];
  //       return errorresponseData;
  //     }
  //   } catch (e) {
  //     // Handle errors and return null
  //     print('Failed to Fall of wickets $e');
  //     List<Map<String, dynamic>> errorresponseData = [];
  //     return errorresponseData;
  //   }
  // }

  // Future<void> downloadAsPdf() async {
  //   try {
  //     await dio.post('$baseUrl/');
  //   } catch (e) {
  //     print("Error-Updating Bowler -- $e");
  //   }
  // }
}
