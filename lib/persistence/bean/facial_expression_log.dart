class FacialExpressionLog {
  int id; // Primary key
  int count; // Number of occurrences of the facial expression
  int playLogId; // Foreign key referencing play_log
  int facialExpressionId; // Foreign key referencing facial_expression
  int executeLogId; // Foreign key referencing execute_log

  FacialExpressionLog({
    required this.id,
    required this.count,
    required this.playLogId,
    required this.facialExpressionId,
    required this.executeLogId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
      'play_log_id': playLogId,
      'facial_expression_id': facialExpressionId,
      'execute_log_id': executeLogId,
    };
  }

  factory FacialExpressionLog.fromJson(Map<String, dynamic> json) {
    return FacialExpressionLog(
      id: json['id'],
      count: json['count'],
      playLogId: json['play_log_id'],
      facialExpressionId: json['facial_expression_id'],
      executeLogId: json['execute_log_id'],
    );
  }

  @override
  String toString() {
    return 'FacialExpressionLog{id: $id, count: $count, playLogId: $playLogId, facialExpressionId: $facialExpressionId, executeLogId: $executeLogId}';
  }
}
