class ObstructingTheField {
  final int id;
  final String playerName;
  final int runsScored;
  final String teamName;

  ObstructingTheField({
    required this.id,
    required this.playerName,
    required this.runsScored,
    required this.teamName,
  });

  // Factory constructor to create an instance from a map (e.g., from API response)
  factory ObstructingTheField.fromMap(Map<String, dynamic> map) {
    return ObstructingTheField(
      id: map['id'] ?? 0,
      playerName: map['player_name'] ?? '',
      runsScored: map['runs_scored'] ?? 0,
      teamName: map['team_name'] ?? '',
    );
  }

  // Convert an instance to a map (e.g., for API requests)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'player_name': playerName,
      'runs_scored': runsScored,
      'team_name': teamName,
    };
  }
}
