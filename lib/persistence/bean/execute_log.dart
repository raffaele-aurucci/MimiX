class ExecuteLog {
  int? id;
  int date; // Timestamp (int)
  int time; // Duration in seconds
  int userId; // Foreign key referencing user
  int exerciseId; // Foreign key referencing exercise

  ExecuteLog({
    this.id,
    required this.date,
    required this.time,
    required this.userId,
    required this.exerciseId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'user_id': userId,
      'exercise_id': exerciseId,
    };
  }

  factory ExecuteLog.fromJson(Map<String, dynamic> json) {
    return ExecuteLog(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      userId: json['user_id'],
      exerciseId: json['exercise_id'],
    );
  }

  @override
  String toString() {
    return 'ExecuteLog{id: $id, date: $date, time: $time, userId: $userId, exerciseId: $exerciseId}';
  }
}
