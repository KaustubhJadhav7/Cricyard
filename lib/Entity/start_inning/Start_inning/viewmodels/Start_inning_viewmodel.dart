import 'package:cricyard/Entity/start_inning/Start_inning/model/Start_inning_model.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/Start_inning_api_service.dart'; // Replace with the actual path of your API service

class StartInningProvider extends ChangeNotifier {
  final start_inningApiService apiService = start_inningApiService();

  List<StartInningModel> entities = [];
  List<StartInningModel> filteredEntities = [];
  List<StartInningModel> searchEntities = [];
  bool showCardView = true;
  TextEditingController searchController = TextEditingController();
  late stt.SpeechToText _speech;
  final StartInningModel formData = StartInningModel(
    id: 0,
    selectMatch: '',
    selectTeam: '',
    selectPlayer: '',
    datetimeField: '',
  );

  final formKey = GlobalKey<FormState>();

  String? selectedSelectMatch;
  List<String> selectMatchList = ['bar_code', 'qr_code'];

  String? selectedSelectTeam;
  List<String> selectTeamList = ['bar_code', 'qr_code'];

  String? selectedSelectPlayer;
  List<String> selectPlayerList = ['bar_code', 'qr_code'];

  DateTime selectedDateTime = DateTime.now();

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (pickedTime != null) {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        notifyListeners();
      }
    }
  }

  bool isLoading = false;
  int currentPage = 0;
  int pageSize = 10;

  StartInningProvider() {
    _speech = stt.SpeechToText();
    fetchEntities();
    fetchWithoutPaging();
  }

  Future<void> fetchWithoutPaging() async {
    try{
        final fetchedEntities = await apiService.getEntities();
        searchEntities = fetchedEntities;
        notifyListeners();
      
    } catch (e) {
      debugPrint('Failed to fetch Start_inning: $e');
    }
  }

  Future<void> fetchEntities() async {
    try {
      isLoading = true;
      notifyListeners();

        final fetchedEntities =
            await apiService.getAllWithPagination(currentPage, pageSize);
        entities.addAll(fetchedEntities);
        filteredEntities = List.from(entities);
        currentPage++;
        notifyListeners();
      
    } catch (e) {
      debugPrint('Failed to fetch Start_inning data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(StartInningModel entity) async {
    try {
      await apiService.deleteEntity(entity.id);
      entities.remove(entity);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to delete entity: $e');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    filteredEntities = searchEntities
        .where((entity) =>
            entity.selectMatch
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity.selectTeam
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity.selectPlayer
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity.datetimeField
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

  void scrollListener(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchEntities();
      }
    });
  }

  Future<void> updateEntity(StartInningModel updatedEntity, BuildContext context) async {
    try {
        // Send the updated entity data to the backend for update
        await apiService.updateEntity(updatedEntity.id, updatedEntity);

        // Navigate back after successful update
        Navigator.pop(context);
      
    } catch (e) {
      debugPrint("Failed to update Start_inning: $e");

      // Show the error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to update Start_inning: $e'),
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

  Future<dynamic> createEntity(StartInningModel formData, BuildContext context) async {
    try {
        await apiService.createEntity(formData);

        
        Navigator.pop(context);
      
    } catch (e) {
      debugPrint("Failed to create Start_inning: $e");

      // Show the error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to create Start_inning: $e'),
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
