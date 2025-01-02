// import 'dart:typed_data';
// import 'package:flutter/material.dart';

// class MyTournamentModel {
//   List<Map<String, dynamic>> entities = [];
//   List<Map<String, dynamic>> filteredEntities = [];
//   List<Map<String, dynamic>> searchEntities = [];
//   List<Map<String, dynamic>> tournamentNameItems = [];
//   List<Map<String, dynamic>> selectedLogoImages = [];
//   bool isLoading = false;
//   bool showCardView = true;
//   int currentPage = 0;
//   int pageSize = 10;
//   Uint8List? logoImageBytes;
//   String? logoImageFileName;
//   DateTime selectedDate = DateTime.now();
//   TextEditingController searchController = TextEditingController();
//   List<Widget> logoimageUploadRows = [];

//   // Getters and setters for the properties

//   bool get getIsLoading => isLoading;
//   bool get getShowCardView => showCardView;
//   int get getCurrentPage => currentPage;
//   int get getPageSize => pageSize;
//   DateTime get getSelectedDate => selectedDate;

//   List<Map<String, dynamic>> get getEntities => entities;
//   List<Map<String, dynamic>> get getFilteredEntities => filteredEntities;
//   List<Map<String, dynamic>> get getSearchEntities => searchEntities;
//   List<Map<String, dynamic>> get getTournamentNameItems => tournamentNameItems;
//   List<Map<String, dynamic>> get getSelectedLogoImages => selectedLogoImages;
//   List<Widget> logoimageUploadRows = [];

//   // Setters

//   set setShowCardView(bool value) {
//     showCardView = value;
//   }

//   set setIsLoading(bool value) {
//     isLoading = value;
//   }

//   set setEntities(List<Map<String, dynamic>> value) {
//     entities = value;
//   }

//   set setFilteredEntities(List<Map<String, dynamic>> value) {
//     filteredEntities = value;
//   }

//   set setSearchEntities(List<Map<String, dynamic>> value) {
//     searchEntities = value;
//   }

//   set setTournamentNameItems(List<Map<String, dynamic>> value) {
//     tournamentNameItems = value;
//   }

//   set setSelectedLogoImages(List<Map<String, dynamic>> value) {
//     selectedLogoImages = value;
//   }

//   set setSelectedDate(DateTime value) {
//     selectedDate = value;
//   }

//   set setCurrentPage(int value) {
//     currentPage = value;
//   }

//   set setPageSize(int value) {
//     pageSize = value;
//   }

//   set setSearchController(TextEditingController value) {
//     searchController = value;
//   }

//   // Methods to handle adding new logo upload rows
//   void addLogoUploadRow() {
//     Map<String, dynamic> newImage = {};
//     selectedLogoImages.add(newImage);
//   }
// }
import 'dart:typed_data';
import 'package:flutter/material.dart';

class MyTournamentModel {
  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];
  List<Map<String, dynamic>> tournamentNameItems = [];
  List<Map<String, dynamic>> selectedLogoImages = [];
  bool isLoading = false;
  bool showCardView = true;
  int currentPage = 0;
  int pageSize = 10;
  Uint8List? logoImageBytes;
  String? logoImageFileName;
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();
  List<Widget> logoimageUploadRows = [];

  // Getters and setters for the properties

  bool get getIsLoading => isLoading;
  bool get getShowCardView => showCardView;
  int get getCurrentPage => currentPage;
  int get getPageSize => pageSize;
  DateTime get getSelectedDate => selectedDate;

  List<Map<String, dynamic>> get getEntities => entities;
  List<Map<String, dynamic>> get getFilteredEntities => filteredEntities;
  List<Map<String, dynamic>> get getSearchEntities => searchEntities;
  List<Map<String, dynamic>> get getTournamentNameItems => tournamentNameItems;
  List<Map<String, dynamic>> get getSelectedLogoImages => selectedLogoImages;
  List<Widget> get getLogoimageUploadRows => logoimageUploadRows;

  // Setters
  set setShowCardView(bool value) {
    showCardView = value;
  }

  set setIsLoading(bool value) {
    isLoading = value;
  }

  set setEntities(List<Map<String, dynamic>> value) {
    entities = value;
  }

  set setFilteredEntities(List<Map<String, dynamic>> value) {
    filteredEntities = value;
  }

  set setSearchEntities(List<Map<String, dynamic>> value) {
    searchEntities = value;
  }

  set setTournamentNameItems(List<Map<String, dynamic>> value) {
    tournamentNameItems = value;
  }

  set setSelectedLogoImages(List<Map<String, dynamic>> value) {
    selectedLogoImages = value;
  }

  set setSelectedDate(DateTime value) {
    selectedDate = value;
  }

  set setCurrentPage(int value) {
    currentPage = value;
  }

  set setPageSize(int value) {
    pageSize = value;
  }

  set setSearchController(TextEditingController value) {
    searchController = value;
  }

  // Method to add a new logo upload row
  void addLogoUploadRow() {
    Map<String, dynamic> newImage =
        {}; // New image placeholder, you can expand it
    selectedLogoImages.add(newImage);

    // Create a new widget row for the uploaded logo (this can be customized)
    logoimageUploadRows.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                // Add your logic for selecting image here
              },
            ),
            Text('Upload Logo'),
          ],
        ),
      ),
    );
  }
}
