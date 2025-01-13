import 'dart:developer';

import 'package:cricyard/providers/token_manager.dart';
import 'package:dio/dio.dart';
import '/resources/api_constants.dart';

class score_boardApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>> getEntities(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get('$baseUrl/Score_board/Score_board');
      final entities = (response.data as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllWithPagination(
      String token, int page, int Size) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          '$baseUrl/Score_board/Score_board/getall/page?page=$page&size=$Size');
      final entities =
          (response.data['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all without pagination: $e');
    }
  }

  Future<Map<String, dynamic>> createEntity(
      String token, Map<String, dynamic> entity) async {
    try {
      print("in post api$entity");
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.post('$baseUrl/Score_board/Score_board', data: entity);

      print(entity);

      // Assuming the response is a Map<String, dynamic>
      Map<String, dynamic> responseData = response.data;

      return responseData;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<void> updateEntity(
      String token, int entityId, Map<String, dynamic> entity) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.put('$baseUrl/Score_board/Score_board/$entityId', data: entity);
      print(entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(String token, int entityId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.delete('$baseUrl/Score_board/Score_board/$entityId');
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  Future<Map<String, dynamic>?> getlastrecord(int tourId, int matchId) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          '$baseUrl/runs/score/lastRecord?tournamentId=$tourId&match_id=$matchId');

      print('score response ${response.data}');
      // Check if response is successful and data is not null
      if (response.statusCode == 200 && response.data != null) {
        print('response get..');
        // Assuming the response is a Map<String, dynamic>
        Map<String, dynamic> responseData = response.data;
        return responseData;
      } else {
        // If response is not successful, return null
        return null;
      }
    } catch (e) {
      // Handle errors and return null
      print('Failed to get last record: $e');
      return null;
    }
  }

// update score
  Future<Map<String, dynamic>> updateScore(
      int tourId, int scdata, String type, Map<String, dynamic> entity) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
          '$baseUrl/runs/score/score/$tourId/$scdata/$type',
          data: entity);
      // Assuming the response is a Map<String, dynamic>
      Map<String, dynamic> responseData = response.data;

      return responseData;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<List<Map<String, dynamic>>> gettournament(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          '$baseUrl/Tournament_List_ListFilter1/Tournament_List_ListFilter1');
      final entities = (response.data as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getbatting_team(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.get('$baseUrl/TeamList_ListFilter1/TeamList_ListFilter1');
      final entities = (response.data as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getstriker(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio
          .get('$baseUrl/PlayerList_ListFilter1/PlayerList_ListFilter1');
      final entities = (response.data as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getballer(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio
          .get('$baseUrl/PlayerList_ListFilter1/PlayerList_ListFilter1');
      final entities = (response.data as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getchasing_team(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.get('$baseUrl/TeamList_ListFilter1/TeamList_ListFilter1');
      final entities = (response.data as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getnon_striker(String token) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio
          .get('$baseUrl/PlayerList_ListFilter1/PlayerList_ListFilter1');
      final entities = (response.data as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

// get All team by match id
  Future<List<Map<String, dynamic>>> getAllTeam(int matchId) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get('$baseUrl/Match/Match/teams/$matchId');
      final entities = (response.data as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all Teams: $e');
    }
  }

  // get last record of player career
  Future<Map<String, dynamic>> getlastrecordPlayerCareer(
      int matchId, int inning, int playerId) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          '$baseUrl/runs/playercareer/career/$matchId/$inning?playerId=$playerId');

      // print('$playerName response ${response.data}');
      // Check if response is successful and data is not null
      if (response.statusCode == 200 && response.data != null) {
        print('$matchId .. $playerId response get..');
        // Assuming the response is a Map<String, dynamic>
        Map<String, dynamic> responseData = response.data;
        return responseData;
      } else {
        Map<String, dynamic> errorresponseData = {'message': 'not found'};
        return errorresponseData;
      }
    } catch (e) {
      // Handle errors and return null
      print('Failed to get last record: $e');
      Map<String, dynamic> errorresponseData = {'message': '$e'};
      return errorresponseData;
    }
  }

// All balls of over
  Future<List<dynamic>> allballofOvers(int tourId, int matchId) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          '$baseUrl/runs/score/ballstatus?tournamentId=$tourId&match_id=$matchId');

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> responseData = response.data;
        print('over resp: $responseData');

        return responseData;
      } else {
        List<dynamic> errorresponseData = [];
        return errorresponseData;
      }
    } catch (e) {
      // Handle errors and return null
      print('Failed to get last record: $e');
      List<dynamic> errorresponseData = [];
      return errorresponseData;
    }
  }

  // strike rotation
  Future<Map<String, dynamic>> strikerotation(
      int tourId, Map<String, dynamic> entity) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
          '$baseUrl/runs/score/strikerotation?tournamentId=$tourId',
          data: entity);
      // Assuming the response is a Map<String, dynamic>
      Map<String, dynamic> responseData = response.data;

      return responseData;
    } catch (e) {
      throw Exception('Failed to Strike Rotate: $e');
    }
  }

  // get partnership in innings
  Future<List<Map<String, dynamic>>> getPartnershipDetails(int matchId) async {
    try {
      final response =
          await dio.get('$baseUrl/token/Practice/score/partnership/$matchId');
      print("Kachha res--${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> data = response.data;
        List<Map<String, dynamic>> responseData =
            data.map((item) => Map<String, dynamic>.from(item)).toList();
        print('Partnership : $responseData');

        return responseData;
      } else {
        List<Map<String, dynamic>> errorresponseData = [];
        return errorresponseData;
      }
    } catch (e) {
      // Handle errors and return null
      print('Failed to get Partnership: $e');
      List<Map<String, dynamic>> errorresponseData = [];
      return errorresponseData;
    }
  }

  // get extra runs in innings
  Future<Map<String, dynamic>> getExtrasDetails(int matchId) async {
    try {
      final response =
          await dio.get('$baseUrl/token/Practice/score/extra/$matchId');

      if (response.statusCode == 200 && response.data != null) {
        Map<String, dynamic> responseData = response.data;
        print('Extras runs: $responseData');

        return responseData;
      } else {
        Map<String, dynamic> errorresponseData = {};
        return errorresponseData;
      }
    } catch (e) {
      // Handle errors and return null
      print('Failed to get last record: $e');
      Map<String, dynamic> errorresponseData = {};
      return errorresponseData;
    }
  }

  // wicket of player
  Future<void> wicket({
    required int tournamentId,
    required String type,
    required String outType,
    required String outPlayer,
    required String playerHelped,
    required String newPlayer,
    required Map<String, dynamic> lastRec,
  }) async {
    print("Request details: \n"
        "Out Type: $outType\n"
        "Out Player: $outPlayer\n"
        "Player Helped: $playerHelped\n"
        "New Player: $newPlayer\n"
        "Last Record: $lastRec");

    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.post(
        "$baseUrl/runs/score/wicket?tournamentId=$tournamentId&type=$type&outType=$outType&outplayerType=$outPlayer&whohelped=$playerHelped&NewPlayerId=$newPlayer",
        data: lastRec,
      );
      print("Response: ${res.data}");
    } catch (e) {
      if (e is DioException) {
        print("Error details: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      } else {
        print("Unexpected error: $e");
      }
      log('Error while taking wicket: $e');
    }
  }

  Future<void> runOutwicket({
    required int tournamentId,
    required String type,
    required String outType,
    required String outPlayer,
    required String playerHelped,
    required String newPlayer,
    required int runs,
    required Map<String, dynamic> lastRec,
  }) async {
    print("Request details: \n"
        "Out Type: $outType\n"
        "Out Player: $outPlayer\n"
        "Player Helped: $playerHelped\n"
        "New Player: $newPlayer\n"
        "Runs: $runs\n"
        "Last Record: $lastRec");

    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.post(
        "$baseUrl/runs/score/wicket?tournamentId=$tournamentId&type=$type&outType=$outType&outplayerType=$outPlayer&whohelped=$playerHelped&NewPlayerId=$newPlayer&runs=$runs",
        data: lastRec,
      );
      print("Response: ${res.data}");
    } catch (e) {
      if (e is DioException) {
        print("Error details: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      } else {
        print("Unexpected error: $e");
      }
      log('Error while taking wicket: $e');
    }
  }

  // updating bowler after over
  Future<void> newPlayerEntry(int tourId, String playerType, int playerId,
      String batsmanplayerType, Map<String, dynamic> lastRec) async {
    print("New-Bowler-Details\nName-$playerId\n");
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      dio.post(
          '$baseUrl/runs/score/newplayer/entry?tournamentId=$tourId&playerType=$playerType&playerId=$playerId&batsmanplayerType=$batsmanplayerType',
          data: lastRec);
    } catch (e) {
      print("Error-Updating Bowler -- $e");
    }
  }

  // undo action
  Future<void> undo(int tourId, int matchId) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.post('$baseUrl/runs/score/undo/$tourId/$matchId');
    } catch (e) {
      print("Error undoing $e");
    }
  }

  // for penalty and over throw runs
  Future<void> postOverThrowAndPenalty(
      int runs, int matchId, int innings, String type) async {
    print('$type -Details\Runs-$runs\nmatchid-$matchId\n innings-$innings');
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      dio.post('');
    } catch (e) {
      print("Error-Updating Bowler -- $e");
    }
  }

  // for WD,LB AND other  runs
  Future<void> postWideExtra(String type, int runs, int matchId, int innings,
      Map<String, dynamic> lastRec) async {
    print(
        'Details---$type \nRuns- $runs\nmatchid- $matchId\n innings-$innings');
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      dio.post('$baseUrl/runs/score/extra/$matchId/$innings/$runs/$type',
          data: lastRec);
    } catch (e) {
      print("Error-Updating Bowler -- $e");
    }
  }

  // get all players in team change api
  Future<List<Map<String, dynamic>>> getAllPlayersInTeam(int teamId) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.get('$baseUrl/team/Register_team/member/$teamId');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> data = response.data;
        //  print('res--$response');
        List<Map<String, dynamic>> responseData =
            data.map((item) => Map<String, dynamic>.from(item)).toList();
        // print('all players in team : $responseData');

        return responseData;
      } else {
        List<Map<String, dynamic>> errorresponseData = [];
        return errorresponseData;
      }
    } catch (e) {
      // Handle errors and return null
      print('Failed to get all players in team: $e');
      List<Map<String, dynamic>> errorresponseData = [];
      return errorresponseData;
    }
  }

  // new player entry  after inning end
  // ********** CHANGE API REQ *********///
  Future<void> newPlayerEntryInningend(
    String striker,
    String non_striker,
    String baller,
    Map<String, dynamic> lastRec,
  ) async {
    print("Request details: \n"
        "striker: $striker\n"
        "non_striker: $non_striker\n"
        "baller: $baller\n"
        "Last Record: $lastRec");

    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.post(
          "$baseUrl/runs/score/inningEnd/entry?striker=$striker&non_striker=$non_striker&baller=$baller",
          data: lastRec);
      print("Response: ${res.data}");
    } catch (e) {
      if (e is DioException) {
        print("Error details: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      } else {
        print("Unexpected error: $e");
      }
      log('Error while taking wicket: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getScoreBoard(int matchId) async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio
          .get('$baseUrl/runs/playercareer/scorecard?matchId=$matchId');
      if (res.statusCode == 200) {
        List<dynamic> data = res.data;
        List<Map<String, dynamic>> scoreBoardData =
            data.map((item) => Map<String, dynamic>.from(item)).toList();
        return scoreBoardData;
      } else {
        print("Error Fetching Scoreboard: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching scoreboard: $e");
    }
    return [];
  }

  Future<List<dynamic>> getOversDetailsData(int matchId) async {
    try {
      final res = await dio.get('$baseUrl/token/score/everyOver/$matchId');
      print("OVERS-DATA--${res.data}");
      if (res.statusCode == 200) {
        if (res.data is List) {
          // If the response data is directly a List
          return res.data;
        } else if (res.data is Map) {
          // If the response data is a Map, convert it to a List
          return [res.data];
        } else {
          print("Error: Response data is neither a list nor a map");
        }
      } else {
        print("Error Fetching everyOver: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching scoreboard: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getFallOfWicket(
      int matchId, int inning) async {
    try {
      final response = await dio
          .get('$baseUrl/score/wicket/fall?matchId=$matchId&inning=$inning');

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> data = response.data;
        List<Map<String, dynamic>> responseData =
            data.map((item) => Map<String, dynamic>.from(item)).toList();
        print('$matchId fall of wickets : $responseData');

        return responseData;
      } else {
        List<Map<String, dynamic>> errorresponseData = [];
        return errorresponseData;
      }
    } catch (e) {
      // Handle errors and return null
      print('Failed to Fall of wickets $e');
      List<Map<String, dynamic>> errorresponseData = [];
      return errorresponseData;
    }
  }
}
