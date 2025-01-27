class CheckLog {
  int? id;
  DateTime date;
  int userId;

  CheckLog({
    this.id,
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'user_id': userId,
    };
  }

  factory CheckLog.fromJson(Map<String, dynamic> json) {
    return CheckLog(
      id: json['id'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      userId: json['user_id'],
    );
  }

  @override
  String toString() {
    return 'CheckLog{id: $id, date: $date, userId: $userId}';
  }
}
