import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/My_Tournament_api_service.dart';
import '/providers/token_manager.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'dart:typed_data';

class MyTournamentProvider with ChangeNotifier {
  final List<Map<String, dynamic>> selectedLogoImages = [];
  DateTime selectedDate = DateTime.now();
  bool isListening = false;
  Future<void> createTournamentEntity(Map<String, dynamic> formData) async {
    final token = await TokenManager.getToken();
    // final prefs = await SharedPreferences.getInstance();

    try {
      // // Fetch the preferred sport
      // String? preferredSport = prefs.getString('preferred_sport') ?? 'Unknown';

      // // Add preferred sport to formData
      // formData['preferred_sport'] = preferredSport;
      Map<String, dynamic> createdEntity =
          await apiService.createEntity(token!, formData);

      // Upload images if any
      for (var selectedImage in selectedLogoImages) {
        await apiService.uploadlogoimage(
          token,
          createdEntity['id'].toString(),
          'My_Tournament',
          selectedImage['imageFileName'],
          selectedImage['imageBytes'],
        );
      }
      print('Tournament entity created successfully: $createdEntity');
    } catch (e) {
      print('Failed to create tournament entity: $e');
      throw Exception('Error creating tournament entity');
    }
  }

  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];
  bool showCardView = true; // Controls view mode
  TextEditingController searchController = TextEditingController();
  late stt.SpeechToText _speech;

  bool isLoading = false; // Tracks loading state
  int currentPage = 0;
  int pageSize = 10; // Pagination size

  final ScrollController scrollController = ScrollController();

  Widget logobuildImageUploadRow(Map<String, dynamic> newImage) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () async {
            await pickImage(ImageSource.gallery, newImage);
          },
          child: const Text('Upload Image'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () async {
            await pickImage(ImageSource.camera, newImage);
          },
          child: const Text('Take Photo'),
        ),
      ],
    );
  }

  Future<void> pickImage(
      ImageSource source, Map<String, dynamic> newImage) async {
    final imagePicker = ImagePicker();

    try {
      final pickedImage = await imagePicker.pickImage(source: source);

      if (pickedImage != null) {
        final imageBytes = await pickedImage.readAsBytes();

        newImage['imageBytes'] = imageBytes;
        newImage['imageFileName'] = pickedImage.name;

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void addlogoUploadRow() {
    Map<String, dynamic> newImage = {};
    selectedLogoImages.add(newImage);
    notifyListeners();
  }

  void removelogoImageUploadRow(int index) {
    selectedLogoImages.removeAt(index);
    notifyListeners();
  }

  Future<void> uploadlogoImageFile() async {
    final imagePicker = ImagePicker();

    try {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        final imageBytes = await pickedImage.readAsBytes();

        selectedLogoImages.add({
          'imageBytes': imageBytes,
          'imageFileName': pickedImage.name,
        });

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> takelogoPhoto() async {
    final imagePicker = ImagePicker();

    try {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        final imageBytes = await pickedImage.readAsBytes();

        selectedLogoImages.add({
          'imageBytes': imageBytes,
          'imageFileName': pickedImage.name,
        });

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners(); // Notify listeners of the change
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

  Future<void> fetchEntities() async {
    if (isLoading) return; // Prevent duplicate requests
    isLoading = true;
    notifyListeners();

    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities =
            await apiService.getAllWithPagination(token, currentPage, pageSize);
        entities.addAll(fetchedEntities);
        filteredEntities = List.from(entities);
        currentPage++;
        notifyListeners();
      }
    } catch (e) {
      print('Failed to fetch paginated entities: $e');
      throw Exception('Failed to fetch paginated entities');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Deletes an entity
  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        await apiService.deleteEntity(token, entity['id']);
        entities.remove(entity);
        filteredEntities = List.from(entities);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to delete entity: $e');
      throw Exception('Failed to delete entity');
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }

  void filterEntities(String query) {
    if (query.isEmpty) {
      filteredEntities = List.from(entities);
    } else {
      filteredEntities = entities
          .where((entity) =>
              entity.values.any((value) => value.toString().contains(query)))
          .toList();
    }
    notifyListeners();
  }

  

  void toggleViewMode() {
    showCardView = !showCardView;
    notifyListeners();
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities = await apiService.getEntities(token);
        searchEntities = fetchedEntities;
        notifyListeners();
      }
    } catch (e) {
      print('Failed to fetch entities without paging: $e');
      throw Exception('Failed to fetch entities without paging');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    filteredEntities = searchEntities
        .where((entity) =>
            entity['description']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['rules']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['venues']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['dates']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['sponsors']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['tournament_name']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Speech recognition status: $status');
        },
        onError: (error) {
          print('Speech recognition error: $error');
        },
      );

      if (available) {
        isListening = true;
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              searchController.text = result.recognizedWords;
              searchEntitiesByKeyword(result.recognizedWords);
            }
          },
        );
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

  final MyTournamentApiService apiService = MyTournamentApiService();
  List<Map<String, dynamic>> tournament_nameItems = [];
  var selectedtournament_nameValue;

  Future<void> fetchtournament_nameItems() async {
    try {
      final selectTdata = await apiService.getTournamentName();
      print('tournament_name data is : $selectTdata');
      if (selectTdata != null && selectTdata.isNotEmpty) {
        tournament_nameItems = selectTdata;
        notifyListeners();
      } else {
        print('tournament_name data is null or empty');
      }
    } catch (e) {
      print('Failed to load tournament_name items: $e');
    }
  }

  Future<void> loadTournamentNameItems() async {
    try {
      // final token = await TokenManager.getToken();
      // final selectTdata = await apiService.getTournamentName(token!);

      // Example placeholder logic
      final selectTdata = [
        {'id': 1, 'name': 'Tournament 1'},
        {'id': 2, 'name': 'Tournament 2'},
      ];

      if (selectTdata.isNotEmpty) {
        // Logic to store tournament name items
        notifyListeners();
      }
    } catch (e) {
      print('Failed to load tournament name items: $e');
    }
  }
}
