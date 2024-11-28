class ActionMinigame {
  int actionId; // Foreign key referencing action
  int minigameId; // Foreign key referencing minigame

  ActionMinigame({
    required this.actionId,
    required this.minigameId,
  });

  Map<String, dynamic> toJson() {
    return {
      'action_id': actionId,
      'minigame_id': minigameId,
    };
  }

  factory ActionMinigame.fromJson(Map<String, dynamic> json) {
    return ActionMinigame(
      actionId: json['action_id'],
      minigameId: json['minigame_id'],
    );
  }

  @override
  String toString() {
    return 'ActionMinigame{actionId: $actionId, minigameId: $minigameId}';
  }
}
