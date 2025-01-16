import 'package:cricyard/Entity/matches/Match/model/Match_model.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/Match_api_service.dart'; 
import '../../../add_tournament/My_Tournament/repository/My_Tournament_api_service.dart';
import '../../../team/Teams/repository/Teams_api_service.dart';

class MatchProvider with ChangeNotifier {
  final MatchApiService apiService = MatchApiService();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  // MatchModel match = MatchModel.fromRawJson(response);

  Map<String, dynamic> entity = {};

  void updateField(String key, dynamic value) {
    entity[key] = value;
    notifyListeners();
  }

  Future<void> updateEntity() async {
    // API call to update entity
    await apiService.updateEntity(entity['id'], entity);
  }

  stt.SpeechToText _speech = stt.SpeechToText();

  List<Map<String, dynamic>> _entities = [];
  List<Map<String, dynamic>> _filteredEntities = [];
  List<Map<String, dynamic>> _searchEntities = [];

  bool _showCardView = true;
  bool _isLoading = false;

  int _currentPage = 0;
  int _pageSize = 10;

  List<Map<String, dynamic>> get entities => _filteredEntities;
  bool get isLoading => _isLoading;
  bool get showCardView => _showCardView;

  MatchProvider() {
    scrollController.addListener(_scrollListener);
    fetchEntities();
    fetchWithoutPaging();
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final fetchedEntities = await apiService.getEntities();
      _searchEntities = fetchedEntities;
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to fetch entities: $e");
    }
  }

  Future<void> fetchEntities() async {
    try {
      _isLoading = true;
      notifyListeners();

        final fetchedEntities =
            await apiService.getAllWithPagination(_currentPage, _pageSize);
        _entities.addAll(fetchedEntities);
        _filteredEntities = _entities.toList();
        _currentPage++;
        notifyListeners();
      
    } catch (e) {
      throw Exception("Failed to fetch entities: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await apiService.deleteEntity(entity['id']);
      _entities.remove(entity);
      _filteredEntities = _entities.toList();
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to delete entity: $e");
    }
  }

  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities
        .where((entity) =>
            entity['team_1']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['team_2']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['location']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['date_field']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['datetime_field']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['name']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['description']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['active']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['user_id']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {},
        onError: (error) {},
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              searchController.text = result.recognizedWords;
              searchEntities(result.recognizedWords);
            }
          },
        );
      }
    }
  }

  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
    }
  }

  void toggleViewMode() {
    _showCardView = !_showCardView;
    notifyListeners();
  }

  final teamsApiService teamApiService = teamsApiService();
  final MyTournamentApiService tournamentApiService = MyTournamentApiService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  DateTime selectedDateTime = DateTime.now();
  bool isActive = false;

  List<Map<String, dynamic>> tournamentNameItems = [];
  String? selectedTournamentName;

  List<Map<String, dynamic>> teamNameItems = [];
  String? selectedTeam1Name;
  String? selectedTeam2Name;

  final Map<String, dynamic> formData = {};

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        notifyListeners();
      }
    }
  }

  Future<void> loadTournamentNameItems() async {
    try {
      // final token = await TokenManager.getToken();
      final selectTdata = await tournamentApiService.getTournamentName();

      if (selectTdata != null && selectTdata.isNotEmpty) {
        tournamentNameItems = selectTdata;
      } else {
        tournamentNameItems = [];
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load tournament names: $e');
    }
  }

  Future<void> loadTeamNameItems() async {
    try {
      final selectTdata = await teamApiService.getMyTeam();

      if (selectTdata != null && selectTdata.isNotEmpty) {
        teamNameItems = selectTdata;
      } else {
        teamNameItems = [];
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load teams: $e');
    }
  }

  void toggleIsActive(bool value) {
    isActive = value;
    notifyListeners();
  }

  void updateFormData(String key, dynamic value) {
    formData[key] = value;
    notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }
}
