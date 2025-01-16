class BookmarkEntity {
  int id;
  String? title;
  String? description;
  String? url;
  bool active;

  BookmarkEntity({
    required this.id,
    this.title,
    this.description,
    this.url,
    required this.active,
  });

  // Factory method to create an instance from JSON
  factory BookmarkEntity.fromJson(Map<String, dynamic> json) {
    return BookmarkEntity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      active: json['active'] ?? false,
    );
  }

  // Convert the model to JSON (useful for API calls)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'active': active,
    };
  }

  // Factory method to create an instance from a Map
  factory BookmarkEntity.fromMap(Map<String, dynamic> map) {
    return BookmarkEntity(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      active: map['active'] ?? false,
    );
  }

  // Convert to Map for API calls
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'active': active,
    };
  }

  // Optional: Add methods for business logic (e.g., toggle active state)
  BookmarkEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? url,
    bool? active,
  }) {
    return BookmarkEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      active: active ?? this.active,
    );
  }
}
