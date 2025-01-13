class RetiredEntity {
  final int id;
  final String description;
  final bool active;
  final String playerName;
  final String canBatterBatAgain;

  // Constructor
  RetiredEntity({
    required this.id,
    required this.description,
    required this.active,
    required this.playerName,
    required this.canBatterBatAgain,
  });

  // Factory method for creating a RetiredEntity instance from a JSON map
  factory RetiredEntity.fromJson(Map<String, dynamic> json) {
    return RetiredEntity(
      id: json['id'] as int,
      description: json['description'] as String,
      active: json['active'] as bool,
      playerName: json['player_name'] as String,
      canBatterBatAgain: json['can_batter_bat_again'] as String,
    );
  }

  // Method to convert a RetiredEntity instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'active': active,
      'player_name': playerName,
      'can_batter_bat_again': canBatterBatAgain,
    };
  }

  // Method to create a copy of the entity with updated values
  RetiredEntity copyWith({
    int? id,
    String? description,
    bool? active,
    String? playerName,
    String? canBatterBatAgain,
  }) {
    return RetiredEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      active: active ?? this.active,
      playerName: playerName ?? this.playerName,
      canBatterBatAgain: canBatterBatAgain ?? this.canBatterBatAgain,
    );
  }

  List<dynamic> get values => [id, playerName, active, canBatterBatAgain, description];
}
