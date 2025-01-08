class HighlightModel {
  bool isLoading;
  String? errorMessage;
  bool isActive;
  bool showCardView;
  int currentPage;
  int pageSize;
  List<Map<String, dynamic>> entities;
  List<Map<String, dynamic>> filteredEntities;

  HighlightModel({
    this.isLoading = false,
    this.errorMessage,
    this.isActive = false,
    this.showCardView = true,
    this.currentPage = 0,
    this.pageSize = 10,
    List<Map<String, dynamic>>? entities,
    List<Map<String, dynamic>>? filteredEntities,
  })  : entities = entities ?? [],
        filteredEntities = filteredEntities ?? [];
}
