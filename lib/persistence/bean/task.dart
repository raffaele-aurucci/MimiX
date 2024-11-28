class Task {
  int? id;
  String name;
  String description;
  int score;
  int level;
  int experiencePoints;
  int? minigameId;
  int? facialExpressionId;
  int? exerciseId;

  Task({
    this.id,
    required this.name,
    required this.description,
    required this.score,
    required this.level,
    required this.experiencePoints,
    this.minigameId,
    this.facialExpressionId,
    this.exerciseId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'score': score,
      'level': level,
      'experience_points': experiencePoints,
      'minigame_id': minigameId,
      'facial_expression_id': facialExpressionId,
      'exercise_id': exerciseId,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      score: json['score'],
      level: json['level'],
      experiencePoints: json['experience_points'],
      minigameId: json['minigame_id'],
      facialExpressionId: json['facial_expression_id'],
      exerciseId: json['exercise_id'],
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, description: $description, score: $score, level: $level, '
        'experiencePoints: $experiencePoints, minigameId: $minigameId, '
        'facialExpressionId: $facialExpressionId, exerciseId: $exerciseId}';
  }
}
