class PlayLog {
  int? id;
  int date; // Timestamp (int)
  int record;
  int outcome;
  int time; // Duration in seconds
  int userId; // Foreign key referencing user
  int minigameId; // Foreign key referencing minigame

  PlayLog({
    this.id,
    required this.date,
    required this.record,
    required this.outcome,
    required this.time,
    required this.userId,
    required this.minigameId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'record': record,
      'outcome': outcome,
      'time': time,
      'user_id': userId,
      'minigame_id': minigameId,
    };
  }

  factory PlayLog.fromJson(Map<String, dynamic> json) {
    return PlayLog(
      id: json['id'],
      date: json['date'],
      record: json['record'],
      outcome: json['outcome'],
      time: json['time'],
      userId: json['user_id'],
      minigameId: json['minigame_id'],
    );
  }

  @override
  String toString() {
    return 'PlayLog{id: $id, date: $date, record: $record, outcome: $outcome, time: $time, userId: $userId, minigameId: $minigameId}';
  }
}
