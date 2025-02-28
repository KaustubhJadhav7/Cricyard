import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/network/network_api_service.dart';
import 'package:dio/dio.dart';
import '/resources/api_constants.dart';

class score_boardApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final Dio dio = Dio();
  final apiService = NetworkApiService();

  Future<List<Map<String, dynamic>>> getEntities() async {
    try {
      final response = await apiService
          .getGetApiResponse('$baseUrl/Score_board/Score_board');
      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllWithPagination(
      int page, int size) async {
    final apiService = NetworkApiService();
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/Score_board/Score_board/getall/page?page=$page&size=$size');
      final entities =
          (response['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all without pagination: $e');
    }
  }

  Future<Map<String, dynamic>> createEntity(Map<String, dynamic> entity) async {
    final apiService = NetworkApiService();
    try {
      print("in post api$entity");
      final response = await apiService.getPostApiResponse(
          '$baseUrl/Score_board/Score_board', entity);
      print(entity);

      // Assuming the response is a Map<String, dynamic>
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<void> updateEntity(int entityId, Map<String, dynamic> entity) async {
    final apiService = NetworkApiService();
    try {
      await apiService.getPutApiResponse(
          '$baseUrl/Score_board/Score_board/$entityId', entity);
      print(entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(int entityId) async {
    try {
      await apiService
          .getDeleteApiResponse('$baseUrl/Score_board/Score_board/$entityId');
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  Future<Map<String, dynamic>?> getlastrecord(int tourId, int matchId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? preferredSport = prefs.getString('preferred_sport');
      final response = await apiService.getGetApiResponse(
          '$baseUrl/runs/score/lastRecord?tournamentId=$tourId&match_id=$matchId&preferredSport=$preferredSport');

      print('score response $response');
      // Check if response is successful and data is not null
      if (response != null && response is Map<String, dynamic>) {
        print('response get..');
        return response;
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to get last record {getlastrecord}: $e');
      return null;
    }
  }

// Update score
  Future<Map<String, dynamic>> updateScore(
      int tourId, int scdata, String type, Map<String, dynamic> entity) async {
    try {
      final response = await apiService.getPostApiResponse(
          '$baseUrl/runs/score/score/$tourId/$scdata/$type', entity);

      if (response is Map<String, dynamic>) {
        return response;
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<List<Map<String, dynamic>>> gettournament() async {
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/Tournament_List_ListFilter1/Tournament_List_ListFilter1');

      if (response is List) {
        return response.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getbatting_team() async {
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/TeamList_ListFilter1/TeamList_ListFilter1');

      if (response is List) {
        return response.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getstriker() async {
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/PlayerList_ListFilter1/PlayerList_ListFilter1');

      if (response is List) {
        return response.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getballer() async {
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/PlayerList_ListFilter1/PlayerList_ListFilter1');

      if (response is List) {
        return response.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getchasing_team() async {
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/TeamList_ListFilter1/TeamList_ListFilter1');

      if (response is List) {
        return response.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getnon_striker() async {
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/PlayerList_ListFilter1/PlayerList_ListFilter1');

      if (response is List) {
        return response.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

// Get all teams by match ID
  Future<List<Map<String, dynamic>>> getAllTeam(int matchId) async {
    try {
      final response = await apiService
          .getGetApiResponse('$baseUrl/Match/Match/teams/$matchId');

      if (response is List) {
        return response.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to get all Teams: $e');
    }
  }

// Get last record of player career
  Future<Map<String, dynamic>> getlastrecordPlayerCareer(
      int matchId, int inning, int playerId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? preferredSport = prefs.getString('preferred_sport');
      final response = await apiService.getGetApiResponse(
          '$baseUrl/runs/playercareer/career/$matchId/$inning?playerId=$playerId&preferredSport=$preferredSport');

      print("Response for getlastrecordPlayerCareer:  $response");

      if (response != null && response is Map<String, dynamic>) {
        print('$matchId .. $playerId response get..');
        return response;
      } else {
        return {'message': 'not found'};
      }
    } catch (e) {
      print('Failed to get last record: {getlastrecordPlayerCareer} Score_board_api_service $e');
      return {'message': '$e'};
    }
  }

// All balls of over
  Future<List<dynamic>> allballofOvers(int tourId, int matchId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? preferredSport = prefs.getString('preferred_sport');
      final response = await apiService.getGetApiResponse(
          "$baseUrl/runs/score/ballstatus?tournamentId=$tourId&match_id=$matchId&preferredSport=$preferredSport");
      print("Response for allballofOvers: $response");
      if (response != null && response is List) {
        print('over resp: $response');
        return response;
      } else {
        print("Failed to fetch allballofOvers");
        return [];
      }
    } catch (e) {
      print('Failed to get last record {allballofOvers}: $e');
      return [];
    }
  }

// Strike rotation
  Future<Map<String, dynamic>> strikerotation(
      int tourId, Map<String, dynamic> entity) async {
    try {
      final response = await apiService.getPostApiResponse(
          '$baseUrl/runs/score/strikerotation?tournamentId=$tourId', entity);

      if (response != null && response is Map<String, dynamic>) {
        return response;
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to Strike Rotate: $e');
    }
  }

// Get partnership in innings
  Future<List<Map<String, dynamic>>> getPartnershipDetails(int matchId) async {
    final prefs = await SharedPreferences.getInstance();
    String? preferredSport = prefs.getString('preferred_sport');
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/token/Practice/score/partnership/$matchId&preferredSport=$preferredSport');

      if (response != null && response is List) {
        return response.map((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Failed to get Partnership: $e');
      return [];
    }
  }

// Get extra runs in innings
  Future<Map<String, dynamic>> getExtrasDetails(int matchId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? preferredSport = prefs.getString('preferred_sport');
      final response = await apiService.getGetApiResponse(
          '$baseUrl/token/Practice/score/extra/$matchId?preferredSport=$preferredSport');

      if (response != null && response is Map<String, dynamic>) {
        print('Extras runs: $response');
        return response;
      } else {
        return {};
      }
    } catch (e) {
      print('Failed to get last record: {getExtrasDetails} $e');
      return {};
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
      final url =
          "$baseUrl/runs/score/wicket?tournamentId=$tournamentId&type=$type&outType=$outType&outplayerType=$outPlayer&whohelped=$playerHelped&NewPlayerId=$newPlayer";
      final response = await apiService.getPostApiResponse(url, lastRec);
      print("Response: $response");
    } catch (e) {
      print("Error while taking wicket: $e");
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
      final url =
          "$baseUrl/runs/score/wicket?tournamentId=$tournamentId&type=$type&outType=$outType&outplayerType=$outPlayer&whohelped=$playerHelped&NewPlayerId=$newPlayer&runs=$runs";
      final response = await apiService.getPostApiResponse(url, lastRec);
      print("Response: $response");
    } catch (e) {
      print("Error while taking wicket: $e");
      log('Error while taking wicket: $e');
    }
  }

// Updating bowler after over
  Future<void> newPlayerEntry(int tourId, String playerType, int playerId,
      String batsmanplayerType, Map<String, dynamic> lastRec) async {
    print("New-Bowler-Details\nName-$playerId\n");
    try {
      final url =
          '$baseUrl/runs/score/newplayer/entry?tournamentId=$tourId&playerType=$playerType&playerId=$playerId&batsmanplayerType=$batsmanplayerType';
      await apiService.getPostApiResponse(url, lastRec);
    } catch (e) {
      print("Error-Updating Bowler -- $e");
    }
  }

// Undo action
  Future<void> undo(int tourId, int matchId) async {
    try {
      final url = '$baseUrl/runs/score/undo/$tourId/$matchId';
      await apiService.getPostApiResponse(url, {});
    } catch (e) {
      print("Error undoing $e");
    }
  }

// For penalty and over throw runs
  Future<void> postOverThrowAndPenalty(
      int runs, int matchId, int innings, String type) async {
    print('$type -Details\nRuns-$runs\nmatchid-$matchId\ninnings-$innings');
    try {
      final url =
          '$baseUrl/runs/score/penalty?matchId=$matchId&innings=$innings&type=$type&runs=$runs';
      await apiService.getPostApiResponse(url, {});
    } catch (e) {
      print("Error-Updating Bowler -- $e");
    }
  }

// For WD, LB and other runs
  Future<void> postWideExtra(String type, int runs, int matchId, int innings,
      Map<String, dynamic> lastRec) async {
    print('Details---$type \nRuns- $runs\nmatchid- $matchId\ninnings-$innings');
    try {
      final url = '$baseUrl/runs/score/extra/$matchId/$innings/$runs/$type';
      await apiService.getPostApiResponse(url, lastRec);
    } catch (e) {
      print("Error-Updating Bowler -- $e");
    }
  }

  // get all players in team change api
  Future<List<Map<String, dynamic>>> getAllPlayersInTeam(int teamId) async {
    final prefs = await SharedPreferences.getInstance();
    String? preferredSport = prefs.getString('preferred_sport');
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/team/Register_team/member/$teamId?preferredSport=$preferredSport');
      if (response != null && response is List) {
        List<Map<String, dynamic>> responseData =
            response.map((item) => Map<String, dynamic>.from(item)).toList();
        return responseData;
      } else {
        return [];
      }
    } catch (e) {
      print('Failed to get all players in team: $e');
      return [];
    }
  }

// new player entry after inning end
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
      await apiService.getPostApiResponse(
        "$baseUrl/runs/score/inningEnd/entry?striker=$striker&non_striker=$non_striker&baller=$baller",
        lastRec,
      );
      print("Request successful.");
    } catch (e) {
      print("Error during new player entry after inning end: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getScoreBoard(int matchId) async {
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/runs/playercareer/scorecard?matchId=$matchId');
      if (response != null && response is List) {
        List<Map<String, dynamic>> scoreBoardData =
            response.map((item) => Map<String, dynamic>.from(item)).toList();
        return scoreBoardData;
      } else {
        print("Error Fetching Scoreboard: Unexpected response format.");
        return [];
      }
    } catch (e) {
      print("Error fetching scoreboard: $e");
      return [];
    }
  }

  Future<List<dynamic>> getOversDetailsData(int matchId) async {
    try {
      final response = await apiService
          .getGetApiResponse('$baseUrl/token/score/everyOver/$matchId');
      if (response != null) {
        if (response is List) {
          return response;
        } else if (response is Map) {
          return [response];
        } else {
          print("Error: Response data is neither a list nor a map.");
        }
      } else {
        print("Error Fetching everyOver: Unexpected response format.");
      }
    } catch (e) {
      print("Error fetching overs details: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getFallOfWicket(
      int matchId, int inning) async {
    try {
      final response = await apiService.getGetApiResponse(
          '$baseUrl/score/wicket/fall?matchId=$matchId&inning=$inning');
      if (response != null && response is List) {
        List<Map<String, dynamic>> responseData =
            response.map((item) => Map<String, dynamic>.from(item)).toList();
        print('$matchId fall of wickets: $responseData');
        return responseData;
      } else {
        return [];
      }
    } catch (e) {
      print('Failed to fetch fall of wickets: $e');
      return [];
    }
  }
}
