import 'package:cricyard/Entity/runs/Score_board/model/Score_board_model.dart';
import 'package:cricyard/Entity/team/Teams/repository/Teams_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/Score_board_api_service.dart';

class ScoreBoardProvider extends ChangeNotifier {
  final score_boardApiService _apiService = score_boardApiService();
  final stt.SpeechToText _speech = stt.SpeechToText();

  ScoreBoardEntity _entity = ScoreBoardEntity();
  ScoreBoardEntity get entity => _entity;


  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];

  void updateModelEntity(ScoreBoardEntity newEntity) {
    _entity = newEntity;
    notifyListeners();
  }
  
  bool showCardView = true;
  bool isLoading = false;
  bool isListening = false;

  int currentPage = 0;
  int pageSize = 10;

  TextEditingController searchController = TextEditingController();

  ScoreBoardProvider() {
    fetchEntities();
    fetchWithoutPaging();
  }

  Future<void> fetchWithoutPaging() async {
    try {
        final fetchedEntities = await _apiService.getEntities();
        searchEntities = fetchedEntities;
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> fetchEntities() async {
    try {
      isLoading = true;
      notifyListeners();
        final fetchedEntities = await _apiService.getAllWithPagination(currentPage, pageSize);
        entities.addAll(fetchedEntities);
        filteredEntities = List.from(entities);
        currentPage++;
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch entities: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await _apiService.deleteEntity(entity['id']);
      entities.remove(entity);
      filteredEntities.remove(entity);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    filteredEntities = searchEntities.where((entity) {
      return entity.values.any((value) =>
          value.toString().toLowerCase().contains(keyword.toLowerCase()));
    }).toList();
    notifyListeners();
  }

  Future<void> startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech status: $status'),
        onError: (error) => debugPrint('Speech error: $error'),
      );
      if (available) {
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              searchController.text = result.recognizedWords;
              searchEntitiesByKeyword(result.recognizedWords);
            }
          },
        );
        isListening = true;
        notifyListeners();
      }
    }
  }

  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
      isListening = false;
      notifyListeners();
    }
  }

  Future<void> updateEntity(int id, Map<String, dynamic> updatedEntity) async {
    try {
        await _apiService.updateEntity(id, updatedEntity);
        notifyListeners(); // Notify listeners if you need to update UI
      
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  final score_boardApiService apiService = score_boardApiService();
  final teamsApiService teamApi = teamsApiService();

  List<Map<String, dynamic>> teamItems = [];
  List<Map<String, dynamic>> teamMembersBatting = [];
  List<Map<String, dynamic>> teamMembersBalling = [];


  String selectedbatting_teamValue = '';
  // String selectedChasingTeamValue = '';
  String selectedstrikerValue = '';
  String selectednon_strikerValue = '';
  String selectedballerValue = '';
  String selectedOversValue = '0';

  bool isTeamLoading = false;

  void _clearTeamData() {
    selectedstrikerValue = '';
    selectednon_strikerValue = '';
    selectedballerValue = '';
    teamMembersBatting.clear();
    teamMembersBalling.clear();
  }

  void updateTeamsBasedOnToss({
    required String selectedTossWinner,
    required String selectedOptedOption,
  }) {
    if (selectedTossWinner.isNotEmpty && selectedOptedOption.isNotEmpty) {
      final tossWinnerTeam = teamItems.firstWhere(
        (team) => team['team_name'] == selectedTossWinner,
        orElse: () => {},
      );

      if (tossWinnerTeam.isEmpty) return;

      if (selectedOptedOption == 'Bat') {
        selectedbatting_teamValue = tossWinnerTeam['id'].toString();
        selectedChasingTeamValue = teamItems
            .firstWhere(
                (team) => team['id'].toString() != selectedbatting_teamValue)['id']
            .toString();
        _clearTeamData();
        getAllBattingMembers(int.parse(selectedbatting_teamValue));
        getAllBallingMembers(int.parse(selectedChasingTeamValue));
      } else {
        selectedChasingTeamValue = tossWinnerTeam['id'].toString();
        selectedbatting_teamValue = teamItems
            .firstWhere(
                (team) => team['id'].toString() != selectedChasingTeamValue)['id']
            .toString();
        _clearTeamData();
        getAllBattingMembers(int.parse(selectedbatting_teamValue));
        getAllBallingMembers(int.parse(selectedChasingTeamValue));
      }

      notifyListeners();
    }
  }

  

  Future<void> loadTeams(int matchId) async {
    isTeamLoading = true;
    notifyListeners();
    try {
      final data = await apiService.getAllTeam(matchId);
      if (data.isNotEmpty) {
        teamItems = data;
      } else {
        print('Team data is null or empty');
      }
    } catch (e) {
      print('Failed to load Team items: $e');
    } finally {
      isTeamLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllBattingMembers(int teamId) async {
    try {
      final data = await teamApi.getAllMembers(teamId);
      teamMembersBatting = data;
      notifyListeners();
    } catch (e) {
      print("Error fetching Batting Members: $e");
    }
  }

  Future<void> getAllBallingMembers(int teamId) async {
    try {
      final data = await teamApi.getAllMembers(teamId);
      teamMembersBalling = data;
      notifyListeners();
    } catch (e) {
      print("Error fetching Balling Members: $e");
    }
  }


  List<Map<String, dynamic>> tournamentItems = [];
  var selectedTournamentValue;

  List<Map<String, dynamic>> battingTeamItems = [];
  var selectedBattingTeamValue;

  List<Map<String, dynamic>> strikerItems = [];
  var selectedStrikerValue;

  List<Map<String, dynamic>> ballerItems = [];
  var selectedBallerValue;

  List<Map<String, dynamic>> chasingTeamItems = [];
  var selectedChasingTeamValue;

  List<Map<String, dynamic>> nonStrikerItems = [];
  var selectedNonStrikerValue;

  bool isValidBallDelivery = false;
  bool isNoBall = false;

  var selectedRunsScoredByRunning;
  List<String> runsScoredByRunningList = ['bar_code', 'qr_code'];

  bool isDeclared2 = false;
  bool isDeclared4 = false;

  var selectedExtraRuns;
  List<String> extraRunsList = ['bar_code', 'qr_code'];

  var selectedMatchDate;
  List<String> matchDateList = ['bar_code', 'qr_code'];

  var selectedMatchNumber;
  List<String> matchNumberList = ['bar_code', 'qr_code'];

  var selectedOvers;
  List<String> oversList = ['bar_code', 'qr_code'];

  var selectedBall;
  List<String> ballList = ['bar_code', 'qr_code'];

  bool isFreeHit = false;
  bool isWideBall = false;
  bool isDeadBall = false;
  bool isDeclared6 = false;
  bool isLegBy = false;
  bool isOverThrow = false;


  Future<void> fetchTournamentItems() async {
    try {
      final data = await _apiService.gettournament();
      if (data != null && data.isNotEmpty) {
        tournamentItems = data;
        selectedTournamentValue = selectedTournamentValue ?? null;
      }
    } catch (e) {
      print('Failed to fetch tournament items: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchBattingTeamItems() async {
    try {
      final data = await _apiService.getbatting_team();
      if (data != null && data.isNotEmpty) {
        battingTeamItems = data;
        selectedBattingTeamValue = selectedBattingTeamValue ?? null;
      }
    } catch (e) {
      print('Failed to fetch batting team items: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchStrikerItems() async {
    try {
      final data = await _apiService.getstriker();
      if (data != null && data.isNotEmpty) {
        strikerItems = data;
        selectedStrikerValue = selectedStrikerValue ?? null;
      }
    } catch (e) {
      print('Failed to fetch striker items: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchBallerItems() async {
    try {
      final data = await _apiService.getballer();
      if (data != null && data.isNotEmpty) {
        ballerItems = data;
        selectedBallerValue = selectedBallerValue ?? null;
      }
    } catch (e) {
      print('Failed to fetch baller items: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchChasingTeamItems() async {
    try {
      final data = await _apiService.getchasing_team();
      if (data != null && data.isNotEmpty) {
        chasingTeamItems = data;
        selectedChasingTeamValue = selectedChasingTeamValue ?? null;
      }
    } catch (e) {
      print('Failed to fetch chasing team items: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchNonStrikerItems() async {
    try {
      final data = await _apiService.getnon_striker();
      if (data != null && data.isNotEmpty) {
        nonStrikerItems = data;
        selectedNonStrikerValue = selectedNonStrikerValue ?? null;
      }
    } catch (e) {
      print('Failed to fetch non-striker items: $e');
    } finally {
      notifyListeners();
    }
  }

  void toggleIsValidBallDelivery() {
    isValidBallDelivery = !isValidBallDelivery;
    notifyListeners();
  }

  void toggleIsNoBall() {
    isNoBall = !isNoBall;
    notifyListeners();
  }

  void setSelectedRunsScoredByRunning(String value) {
    selectedRunsScoredByRunning = value;
    notifyListeners();
  }

  void setSelectedExtraRuns(String value) {
    selectedExtraRuns = value;
    notifyListeners();
  }

  void setSelectedMatchDate(String value) {
    selectedMatchDate = value;
    notifyListeners();
  }

  void setSelectedMatchNumber(String value) {
    selectedMatchNumber = value;
    notifyListeners();
  }

  void setSelectedOvers(String value) {
    selectedOvers = value;
    notifyListeners();
  }

  void setSelectedBall(String value) {
    selectedBall = value;
    notifyListeners();
  }
}


