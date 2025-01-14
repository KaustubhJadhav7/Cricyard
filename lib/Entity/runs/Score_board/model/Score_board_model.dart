class ScoreBoardEntity {
  String? selectedTossWinner;
  String? selectedOptedOption;

  List<Map<String, dynamic>> teamItems;
  String? selectedBattingTeamValue;
  String? selectedChasingTeamValue;

  List<Map<String, dynamic>> teamMembersBatting;
  List<Map<String, dynamic>> teamMembersBalling;

  bool isValidBallDelivery;
  bool isNoBall;
  bool isDeclared2;
  bool isDeclared4;
  bool isDeclared6;
  bool isWideBall;
  bool isDeadBall;
  bool isFreeHit;
  bool isLegBy;
  bool isOverThrow;

  String? selectedRunsScoredByRunning;
  String? selectedExtraRuns;
  String? selectedMatchDate;
  String? selectedMatchNumber;
  String? selectedOvers;
  String? selectedBall;

  ScoreBoardEntity({
    this.selectedTossWinner,
    this.selectedOptedOption = 'Bat',
    this.teamItems = const [],
    this.selectedBattingTeamValue,
    this.selectedChasingTeamValue,
    this.teamMembersBatting = const [],
    this.teamMembersBalling = const [],
    this.isValidBallDelivery = false,
    this.isNoBall = false,
    this.isDeclared2 = false,
    this.isDeclared4 = false,
    this.isDeclared6 = false,
    this.isWideBall = false,
    this.isDeadBall = false,
    this.isFreeHit = false,
    this.isLegBy = false,
    this.isOverThrow = false,
    this.selectedRunsScoredByRunning,
    this.selectedExtraRuns,
    this.selectedMatchDate,
    this.selectedMatchNumber,
    this.selectedOvers,
    this.selectedBall,
  });

  // Factory method for JSON deserialization
  factory ScoreBoardEntity.fromJson(Map<String, dynamic> json) {
    return ScoreBoardEntity(
      selectedTossWinner: json['selectedTossWinner'],
      selectedOptedOption: json['selectedOptedOption'],
      teamItems: List<Map<String, dynamic>>.from(json['teamItems'] ?? []),
      selectedBattingTeamValue: json['selectedBattingTeamValue'],
      selectedChasingTeamValue: json['selectedChasingTeamValue'],
      teamMembersBatting:
          List<Map<String, dynamic>>.from(json['teamMembersBatting'] ?? []),
      teamMembersBalling:
          List<Map<String, dynamic>>.from(json['teamMembersBalling'] ?? []),
      isValidBallDelivery: json['isValidBallDelivery'] ?? false,
      isNoBall: json['isNoBall'] ?? false,
      isDeclared2: json['isDeclared2'] ?? false,
      isDeclared4: json['isDeclared4'] ?? false,
      isDeclared6: json['isDeclared6'] ?? false,
      isWideBall: json['isWideBall'] ?? false,
      isDeadBall: json['isDeadBall'] ?? false,
      isFreeHit: json['isFreeHit'] ?? false,
      isLegBy: json['isLegBy'] ?? false,
      isOverThrow: json['isOverThrow'] ?? false,
      selectedRunsScoredByRunning: json['selectedRunsScoredByRunning'],
      selectedExtraRuns: json['selectedExtraRuns'],
      selectedMatchDate: json['selectedMatchDate'],
      selectedMatchNumber: json['selectedMatchNumber'],
      selectedOvers: json['selectedOvers'],
      selectedBall: json['selectedBall'],
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'selectedTossWinner': selectedTossWinner,
      'selectedOptedOption': selectedOptedOption,
      'teamItems': teamItems,
      'selectedBattingTeamValue': selectedBattingTeamValue,
      'selectedChasingTeamValue': selectedChasingTeamValue,
      'teamMembersBatting': teamMembersBatting,
      'teamMembersBalling': teamMembersBalling,
      'isValidBallDelivery': isValidBallDelivery,
      'isNoBall': isNoBall,
      'isDeclared2': isDeclared2,
      'isDeclared4': isDeclared4,
      'isDeclared6': isDeclared6,
      'isWideBall': isWideBall,
      'isDeadBall': isDeadBall,
      'isFreeHit': isFreeHit,
      'isLegBy': isLegBy,
      'isOverThrow': isOverThrow,
      'selectedRunsScoredByRunning': selectedRunsScoredByRunning,
      'selectedExtraRuns': selectedExtraRuns,
      'selectedMatchDate': selectedMatchDate,
      'selectedMatchNumber': selectedMatchNumber,
      'selectedOvers': selectedOvers,
      'selectedBall': selectedBall,
    };
  }
}
