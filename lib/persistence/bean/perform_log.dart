class PerformLog {
  int? id;
  int date; // Timestamp (int)
  int progress; // Progress value (e.g., percentage)
  int outcome; // Outcome value (e.g., score or result)
  int userId; // Foreign key referencing user
  int taskId; // Foreign key referencing task

  PerformLog({
    this.id,
    required this.date,
    required this.progress,
    required this.outcome,
    required this.userId,
    required this.taskId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'progress': progress,
      'outcome': outcome,
      'user_id': userId,
      'task_id': taskId,
    };
  }

  factory PerformLog.fromJson(Map<String, dynamic> json) {
    return PerformLog(
      id: json['id'],
      date: json['date'],
      progress: json['progress'],
      outcome: json['outcome'],
      userId: json['user_id'],
      taskId: json['task_id'],
    );
  }

  @override
  String toString() {
    return 'PerformLog{id: $id, date: $date, progress: $progress, outcome: $outcome, userId: $userId, taskId: $taskId}';
  }
}
