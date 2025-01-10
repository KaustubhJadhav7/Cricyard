class MatchSetting {
  String? name;
  String? description;
  String? forOvers;
  bool isActive;
  bool isDisableWagonWheelForDotBall;
  bool isDisableWagonWheelFor1s2sAnd3s;
  bool isDisableShotSelection;
  bool isCountWideAsLegalDelivery;
  bool isCountNoBallAsLegalDelivery;

  MatchSetting({
    this.name,
    this.description,
    this.forOvers,
    this.isActive = false,
    this.isDisableWagonWheelForDotBall = false,
    this.isDisableWagonWheelFor1s2sAnd3s = false,
    this.isDisableShotSelection = false,
    this.isCountWideAsLegalDelivery = false,
    this.isCountNoBallAsLegalDelivery = false,
  });

  // Convert model to a map for API calls
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'for_overs': forOvers,
      'active': isActive,
      'disable_wagon_wheel_for_dot_ball': isDisableWagonWheelForDotBall,
      'disable_wagon_wheel_for_1s_2s_and_3s': isDisableWagonWheelFor1s2sAnd3s,
      'disable_shot_selection': isDisableShotSelection,
      'count_wide_as_a_legal_delivery': isCountWideAsLegalDelivery,
      'count_no_ball_as_a_legal_delivery': isCountNoBallAsLegalDelivery,
    };
  }
}
