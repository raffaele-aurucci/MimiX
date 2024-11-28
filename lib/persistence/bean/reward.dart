class Reward {
  int? id;
  String name;
  String description;
  int level;
  int score;
  int facialExpressionId;

  Reward({
    this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.score,
    required this.facialExpressionId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'level': level,
      'score': score,
      'facial_expression_id': facialExpressionId,
    };
  }

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      level: json['level'],
      score: json['score'],
      facialExpressionId: json['facial_expression_id'],
    );
  }

  @override
  String toString() {
    return 'Reward{id: $id, name: $name, description: $description, level: $level, '
        'score: $score, facialExpressionId: $facialExpressionId}';
  }
}
