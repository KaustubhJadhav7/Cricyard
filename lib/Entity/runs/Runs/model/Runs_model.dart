class RunsEntity {
  int id;
  String? description;
  bool active;
  int numberOfRuns;
  String? selectField;

  RunsEntity({
    required this.id,
    required this.description,
    required this.active,
    required this.numberOfRuns,
    this.selectField,
  });

  // Factory method to create an instance from JSON
  factory RunsEntity.fromJson(Map<String, dynamic> json) {
    return RunsEntity(
      id: json['id'],
      description: json['description'] ?? '',
      active: json['active'] ?? false,
      numberOfRuns: json['number_of_runs'] ?? 0,
      selectField: json['select_field'],
    );
  }

  // Convert the model to JSON (useful for API calls)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'active': active,
      'number_of_runs': numberOfRuns,
      'select_field': selectField,
    };
  }

  // Factory method to create an instance from a Map
  factory RunsEntity.fromMap(Map<String, dynamic> map) {
    return RunsEntity(
      id: map['id'],
      description: map['description'] ?? '',
      active: map['active'] ?? false,
      numberOfRuns: map['number_of_runs'] ?? 0,
      selectField: map['select_field'],
    );
  }

  // Convert to Map for API calls
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'active': active,
      'number_of_runs': numberOfRuns,
      'select_field': selectField,
    };
  }

  // Optional: Add methods for business logic (e.g., toggle active state)
  RunsEntity copyWith({
    int? id,
    String? description,
    bool? active,
    int? numberOfRuns,
    String? selectField,
  }) {
    return RunsEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      active: active ?? this.active,
      numberOfRuns: numberOfRuns ?? this.numberOfRuns,
      selectField: selectField ?? this.selectField,
    );
  }
}
