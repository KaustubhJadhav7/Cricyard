import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/Start_Match_api_service.dart';


class StartMatchProvider with ChangeNotifier {
  final StartMatchApiService apiService = StartMatchApiService();
  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];
  bool isLoading = false;
  int currentPage = 0;
  final int pageSize = 10;
  TextEditingController searchController = TextEditingController();
  late stt.SpeechToText speech;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateTime = DateTime.now();

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


  StartMatchProvider() {
    fetchEntities();
    fetchWithoutPaging();
  }

  Future<void> fetchEntities() async {
    try {
      _setLoading(true);
        final fetchedEntities =
            await apiService.getAllWithPagination(currentPage, pageSize);
        entities.addAll(fetchedEntities);
        filteredEntities = List.from(entities);
        currentPage++;
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch Start_Match data: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final fetchedEntities = await apiService.getEntities();
      searchEntities = fetchedEntities;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch Start_Match without paging: $e');
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await apiService.deleteEntity(entity['id']);
      entities.remove(entity);
      filteredEntities = List.from(entities);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    filteredEntities = searchEntities
        .where((entity) =>
            entity['name_of_match']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['format']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['rules']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['venue']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['date_field']
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
                .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void startListening() async {
    if (!speech.isListening) {
      bool available = await speech.initialize(
        onStatus: (status) {
          print('Speech recognition status: $status');
        },
        onError: (error) {
          print('Speech recognition error: $error');
        },
      );

      if (available) {
        speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              searchController.text = result.recognizedWords;
              searchEntitiesByKeyword(result.recognizedWords);
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

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
