class AbsentHurtEntity {
  int id;
  String? playerName;
  bool active;
  String? description;

  AbsentHurtEntity({
    required this.id,
    required this.playerName,
    required this.active,
    this.description,
  });

  // Factory method to create an instance from JSON
  factory AbsentHurtEntity.fromJson(Map<String, dynamic> json) {
    return AbsentHurtEntity(
      id: json['id'],
      playerName: json['player_name'],
      active: json['active'] ?? false,
      description: json['description'],
    );
  }

  // Convert the model to JSON (useful for API calls)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'player_name': playerName,
      'active': active,
      'description': description,
    };
  }

  // Factory method to create an instance from a Map
  factory AbsentHurtEntity.fromMap(Map<String, dynamic> map) {
    return AbsentHurtEntity(
      id: map['id'],
      playerName: map['player_name'],
      active: map['active'] ?? false,
      description: map['description'],
    );
  }

  // Convert to Map for API calls
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'player_name': playerName,
      'active': active,
      'description': description,
    };
  }

  // Optional: Add methods for business logic (e.g., toggle active state)
  AbsentHurtEntity copyWith({
    int? id,
    String? playerName,
    bool? active,
    String? description,
  }) {
    return AbsentHurtEntity(
      id: id ?? this.id,
      playerName: playerName ?? this.playerName,
      active: active ?? this.active,
      description: description ?? this.description,
    );
  }
}

class AbsentHurtModel {
  bool _isActive = false;
  String? _selectedPlayerName;
  String? _description;
  AbsentHurtEntity _entity = AbsentHurtEntity(id: 0, playerName: '', active: false);
  List<AbsentHurtEntity> _entities = [];
  List<AbsentHurtEntity> _filteredEntities = [];
  List<AbsentHurtEntity> _searchEntities = [];
  Map<String, dynamic> _formData = {};
  bool _isLoading = false;
  bool _showCardView = false;
  int _currentPage = 0;
  int _pageSize = 20;
  

  // Getters
  bool get getIsActive => _isActive;
  String? get getSelectedPlayerName => _selectedPlayerName;
  String? get getDescription => _description;
  AbsentHurtEntity get getEntity => _entity;
  List<AbsentHurtEntity> get getEntities => _entities;
  List<AbsentHurtEntity> get getFilteredEntities => _filteredEntities;
  List<AbsentHurtEntity> get getSearchEntities => _searchEntities;
  Map<String, dynamic> get getFormData => _formData;
  bool get getIsLoading => _isLoading;
  bool get getShowCardView => _showCardView;
  int get currentPage => _currentPage;
  int get pageSize => _pageSize;

  // Setters
  set setIsActive(bool value) => _isActive = value;
  set setSelectedPlayerName(String? value) => _selectedPlayerName = value;
  set setDescription(String? value) => _description = value;
  set setEntity(AbsentHurtEntity value) => _entity = value;
  set setEntities(List<AbsentHurtEntity> value) => _entities = value;
  set setFilteredEntities(List<AbsentHurtEntity> value) =>
      _filteredEntities = value;
  set setSearchEntities(List<AbsentHurtEntity> value) =>
      _searchEntities = value;
  set setFormData(Map<String, dynamic> value) => _formData = value;
  set setIsLoading(bool value) => _isLoading = value;
  set setShowCardView(bool value) => _showCardView = value;
  set setCurrentPage(int value) => _currentPage = value;
}
