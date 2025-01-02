class AbsentHurtModel {
  bool isActive;
  String? selectedPlayerName;
  final Map<String, dynamic> formData;
  String? description;
  Map<String, dynamic> entity;
  List<Map<String, dynamic>> entities;
  List<Map<String, dynamic>> filteredEntities;
  List<Map<String, dynamic>> searchEntities;
  bool isLoading;
  bool showCardView;
  int currentPage;
  int pageSize;

  AbsentHurtModel({
    this.isActive = false,
    this.selectedPlayerName,
    Map<String, dynamic>? formData,
    this.description,
    Map<String, dynamic>? entity,
    List<Map<String, dynamic>>? entities,
    List<Map<String, dynamic>>? filteredEntities,
    List<Map<String, dynamic>>? searchEntities,
    this.isLoading = false,
    this.showCardView = true,
    this.currentPage = 0,
    this.pageSize = 10,
  })  : formData = formData ?? {},
        entity = entity ?? {},
        entities = entities ?? [],
        filteredEntities = filteredEntities ?? [],
        searchEntities = searchEntities ?? [];

  // Getters
  bool get getIsActive => isActive;
  String? get getSelectedPlayerName => selectedPlayerName;
  Map<String, dynamic> get getFormData => formData;
  String? get getDescription => description;
  Map<String, dynamic> get getEntity => entity;
  List<Map<String, dynamic>> get getEntities => entities;
  List<Map<String, dynamic>> get getFilteredEntities => filteredEntities;
  List<Map<String, dynamic>> get getSearchEntities => searchEntities;
  bool get getIsLoading => isLoading;
  bool get getShowCardView => showCardView;

  // Setters
  set setIsActive(bool value) {
    isActive = value;
  }

  set setSelectedPlayerName(String? value) {
    selectedPlayerName = value;
  }

  set setDescription(String? value) {
    description = value;
  }

  set setEntity(Map<String, dynamic> value) {
    entity = value;
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

  set setIsLoading(bool value) {
    isLoading = value;
  }

  set setShowCardView(bool value) {
    showCardView = value;
  }

  set setCurrentPage(int value) {
    currentPage = value;
  }

  set setPageSize(int value) {
    pageSize = value;
  }
}
