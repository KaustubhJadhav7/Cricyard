import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/Matches_model.dart';
import '../repository/Matches_api_service.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MatchesProvider with ChangeNotifier {
  final MatchesApiService apiService = MatchesApiService();
  final stt.SpeechToText speech = stt.SpeechToText();

  TextEditingController searchController = TextEditingController();
  List<MatchModel> _entities = [];
  List<MatchModel> _filteredEntities = [];
  List<MatchModel> _searchEntities = [];
  bool _isLoading = false;
  int _currentPage = 0;
  int _pageSize = 10;

  List<MatchModel> get entities => _entities;
  List<MatchModel> get filteredEntities => _filteredEntities;
  bool get isLoading => _isLoading;

  DateTime selectedDate = DateTime.now();
  DateTime selectedDateTime = DateTime.now();

  void fetchWithoutPaging() async {
    try {
        final fetchedEntities = await apiService.getEntities();
        _searchEntities = fetchedEntities
            .map((json) => MatchModel.fromJson(json))
            .toList();
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch matches: $e');
    }
  }
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
  bool isActive = false;

  void toggleActive(bool newValue) {
    isActive = newValue;
    notifyListeners();
  }

  Future<void> updateEntity(dynamic id, Map<String, dynamic> updatedEntity) async {
    try {
      await apiService.updateEntity(id, updatedEntity);
      notifyListeners(); // Notify listeners if needed (e.g., for UI updates)
    } catch (error) {
      throw Exception("Failed to update entity: $error");
    }
  }
  Future<void> createEntity(dynamic data) async {
    try { 
        final newEntity = await apiService.createEntity(data);
        entities.add(newEntity);
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to create entity: $e');
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

  Future<void> fetchEntities() async {
    try {
      _isLoading = true;
      notifyListeners();
        final fetchedEntities = await apiService.getAllWithPagination(
          _currentPage,
          _pageSize,
        );
        _entities.addAll(fetchedEntities.map((json) => MatchModel.fromJson(json)));
        _filteredEntities = [..._entities];
        _currentPage++;
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch matches data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future deleteEntity(dynamic entity) async {
    try {
      await apiService.deleteEntity(entity.id);
      _entities.remove(entity);
      _filteredEntities.remove(entity);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities.where((entity) {
      return entity.matchName.toLowerCase().contains(keyword.toLowerCase()) ||
          entity.score.toLowerCase().contains(keyword.toLowerCase()) ||
          entity.result.toLowerCase().contains(keyword.toLowerCase()) ||
          entity.dateField.toLowerCase().contains(keyword.toLowerCase()) ||
          entity.description.toLowerCase().contains(keyword.toLowerCase()) ||
          entity.active.toString().toLowerCase().contains(keyword.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void startListening() async {
    if (!speech.isListening) {
      bool available = await speech.initialize(
        onStatus: (status) => print('Speech recognition status: $status'),
        onError: (error) => print('Speech recognition error: $error'),
      );

      if (available) {
        speech.listen(
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
    if (speech.isListening) {
      speech.stop();
    }
  }
}
