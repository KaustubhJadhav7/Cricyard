class SelectTeamEntity {
  final int id;
  final String teamName;
  final bool active;
  final int memberCount;
  final String? description;

  SelectTeamEntity({
    required this.id,
    required this.teamName,
    required this.active,
    required this.memberCount,
    this.description,
  });

  // Factory method to create an instance from JSON
  factory SelectTeamEntity.fromJson(Map<String, dynamic> json) {
    return SelectTeamEntity(
      id: json['id'],
      teamName: json['team_name'] ?? '',
      active: json['active'] ?? false,
      memberCount: json['member_count'] ?? 0,
      description: json['description'],
    );
  }

  // Convert the model to JSON (useful for API calls)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_name': teamName,
      'active': active,
      'member_count': memberCount,
      'description': description,
    };
  }

  // Factory method to create an instance from a Map
  factory SelectTeamEntity.fromMap(Map<String, dynamic> map) {
    return SelectTeamEntity(
      id: map['id'],
      teamName: map['team_name'] ?? '',
      active: map['active'] ?? false,
      memberCount: map['member_count'] ?? 0,
      description: map['description'],
    );
  }

  // Convert to Map for API calls
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'team_name': teamName,
      'active': active,
      'member_count': memberCount,
      'description': description,
    };
  }
  

  // Optional: Add methods for business logic (e.g., toggle active state)
  SelectTeamEntity copyWith({
    int? id,
    String? teamName,
    bool? active,
    int? memberCount,
    String? description,
  }) {
    return SelectTeamEntity(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      active: active ?? this.active,
      memberCount: memberCount ?? this.memberCount,
      description: description ?? this.description,
    );
  }
}
