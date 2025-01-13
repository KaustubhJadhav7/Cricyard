class RetiredOutEntity {
   int id;
   String description;
   String playerName;
   bool active;

  RetiredOutEntity({
    required this.id,
    required this.description,
    required this.playerName,
    required this.active,
  });

  // Factory method to create an instance from JSON
  factory RetiredOutEntity.fromJson(Map<String, dynamic> json) {
    return RetiredOutEntity(
      id: json['id'],
      description: json['description'] ?? '',
      playerName: json['player_name'] ?? '',
      active: json['active'] ?? false,
    );
  }

  // Convert the model to JSON (useful for API calls)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'player_name': playerName,
      'active': active,
    };
  }
  factory RetiredOutEntity.fromMap(Map<String, dynamic> map) {
    return RetiredOutEntity(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      active: map['active'] ?? false,
      playerName: map['player_name'] ?? '',
    );
  }

  // Convert to Map for API calls
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'active': active,
      'player_name': playerName,
    };
  }

  // Optional: Add methods for business logic (e.g., toggle active state)
  RetiredOutEntity copyWith({
    int? id,
    String? description,
    String? playerName,
    bool? active,
  }) {
    return RetiredOutEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      playerName: playerName ?? this.playerName,
      active: active ?? this.active,
    );
  }
}
