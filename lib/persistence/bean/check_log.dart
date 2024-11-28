class CheckLog {
  int? id;
  int date; // Timestamp (int)
  int userId; // Foreign key referencing user

  CheckLog({
    this.id,
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'user_id': userId,
    };
  }

  factory CheckLog.fromJson(Map<String, dynamic> json) {
    return CheckLog(
      id: json['id'],
      date: json['date'],
      userId: json['user_id'],
    );
  }

  @override
  String toString() {
    return 'CheckLog{id: $id, date: $date, userId: $userId}';
  }
}
