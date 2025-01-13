import 'package:cricyard/Entity/obstructing_the_field/Obstructing_The_Field/model/Obstructing_The_Field_model.dart';
import 'package:flutter/material.dart';
import '../repository/Obstructing_The_Field_api_service.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class ObstructingTheFieldProvider with ChangeNotifier {
  final ObstructingTheFieldApiService apiService =
      ObstructingTheFieldApiService();

  List<ObstructingTheField> _entities = [];
  List<ObstructingTheField> _filteredEntities = [];
  List<ObstructingTheField> _searchEntities = [];
  final Map<String, dynamic> formData = {};

  bool _showCardView = true;
  bool _isLoading = false;
  int _currentPage = 0;
  final int _pageSize = 10;
  late stt.SpeechToText _speech;

  List<ObstructingTheField> get entities => _entities;
  List<ObstructingTheField> get filteredEntities => _filteredEntities;
  bool get isLoading => _isLoading;
  bool get showCardView => _showCardView;

  ObstructingTheFieldProvider() {
    _speech = stt.SpeechToText();
    fetchEntities();
    fetchWithoutPaging();
  }

  Future<dynamic> createEntity(Map<String, dynamic> formData) async {
    try {
      Map<String, dynamic> createdEntity =
          await apiService.createEntity(formData);
      // Handle successful creation (e.g., add to local state or notify listeners if needed)
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateEntity(int id, Map<String, dynamic> updatedData) async {
    await apiService.updateEntity(id, updatedData);
    notifyListeners(); // Notify listeners if needed for UI updates
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final fetchedEntities = await apiService.getEntities();
      _searchEntities = fetchedEntities;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch entities without paging: $e');
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
      throw Exception('Failed to fetch entities: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await apiService.deleteEntity(entity['id']);
      _entities.remove(entity);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities
        // .where((entity) => entity['runs_scored']
        .where((entity) => entity.runsScored
            .toString()
            .toLowerCase()
            .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> startListening(TextEditingController searchController) async {
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
}

// class ObstructingTheFieldScreen extends StatelessWidget {
//   final TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ObstructingTheFieldProvider(),
//       child: Consumer<ObstructingTheFieldProvider>(
//         builder: (context, provider, child) {
//           return Scaffold(
//             appBar: AppBar(
//               title: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                 ),
//                 onChanged: provider.searchEntities,
//               ),
//               actions: [
//                 IconButton(
//                   icon: Icon(Icons.mic),
//                   onPressed: () => provider.startListening(searchController),
//                 ),
//               ],
//             ),
//             body: provider.isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     itemCount: provider.filteredEntities.length,
//                     itemBuilder: (context, index) {
//                       final entity = provider.filteredEntities[index];
//                       return ListTile(
//                         title: Text(entity['runs_scored'].toString()),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => provider.deleteEntity(entity),
//                         ),
//                       );
//                     },
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }
