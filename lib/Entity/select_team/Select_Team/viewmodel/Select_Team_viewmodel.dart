import 'package:cricyard/Entity/select_team/Select_Team/model/Select_Team_model.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/Select_Team_api_service.dart'; // Adjust import to match your file structure

class SelectTeamProvider extends ChangeNotifier {
  final SelectTeamApiService apiService = SelectTeamApiService();

  List<SelectTeamEntity> entities = [];
  List<SelectTeamEntity> filteredEntities = [];
  List<SelectTeamEntity> searchEntities = [];
  bool showCardView = true;
  bool isLoading = false;
  int currentPage = 0;
  int pageSize = 10;

  late stt.SpeechToText _speech;
  TextEditingController searchController = TextEditingController();

  SelectTeamProvider() {
    _speech = stt.SpeechToText();
    fetchEntities();
    fetchWithoutPaging();
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final fetchedEntities = await apiService.getEntities();
      searchEntities = fetchedEntities;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to fetch Select_Team: $e');
    }
  }

  Future<void> fetchEntities() async {
    try {
      isLoading = true;
      notifyListeners();

      final fetchedEntities =
          await apiService.getAllWithPagination(currentPage, pageSize);
      entities.addAll(fetchedEntities);
      filteredEntities = entities.toList();
      currentPage++;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to fetch Select_Team data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      // final token = await TokenManager.getToken();
      await apiService.deleteEntity(entity['id']);
      entities.remove(entity);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to delete entity: $e');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    filteredEntities = searchEntities
        .where((entity) => entity.teamName
            .toString()
            .toLowerCase()
            .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech recognition status: $status'),
        onError: (error) => debugPrint('Speech recognition error: $error'),
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
      }
    }
  }

  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
    }
  }

  Future<void> createEntity(SelectTeamEntity formData, BuildContext context) async {
    try {
      SelectTeamEntity createdEntity =
          await apiService.createEntity(formData);
      entities.add(createdEntity); // Add the new entity to the list
      filteredEntities = entities.toList();
      notifyListeners();

      Navigator.pop(context); // Navigate back after successful creation
    } catch (e) {
      debugPrint('Failed to create entity: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to create Select_Team: $e'),
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

  List<Map<String, dynamic>> teamNameItems = [];
  String? selectedTeamNameValue = '';

  Future<void> loadTeamNameItems() async {
    try {
        final selectTData = await apiService.getTeamName();
        if (selectTData != null && selectTData.isNotEmpty) {
          teamNameItems = selectTData;
          notifyListeners();
        } else {
          debugPrint('Team name data is null or empty');
        }
      
    } catch (e) {
      debugPrint('Failed to load team name items: $e');
    }
  }

  void setSelectedTeamNameValue(String value) {
    selectedTeamNameValue = value;
    notifyListeners();
  }

  Future<void> updateEntity(
      int id, Map<String, dynamic> updatedEntity, BuildContext context) async {
    try {
        await apiService.updateEntity(id, updatedEntity);
        notifyListeners();

        // Navigate back after a successful update
        Navigator.pop(context);
      
    } catch (e) {
      debugPrint('Failed to update entity: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to update Select_Team: $e'),
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
}
