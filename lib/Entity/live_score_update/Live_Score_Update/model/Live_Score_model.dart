class LiveScoreUpdate {
  final int id;
  final String liveCommentary;
  final int boundary;
  final int wickets;
  final String name;
  final String description;
  final bool active;

  LiveScoreUpdate({
    required this.id,
    required this.liveCommentary,
    required this.boundary,
    required this.wickets,
    required this.name,
    required this.description,
    required this.active,
  });

  factory LiveScoreUpdate.fromJson(Map<String, dynamic> json) {
    return LiveScoreUpdate(
      id: json['id'] ?? 0,
      liveCommentary: json['live_commentary'] ?? '',
      boundary: json['boundary'] ?? 0,
      wickets: json['wickets'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'live_commentary': liveCommentary,
      'boundary': boundary,
      'wickets': wickets,
      'name': name,
      'description': description,
      'active': active,
    };
  }
}
