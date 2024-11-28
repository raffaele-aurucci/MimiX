class Exercise {
  int? id;
  String name;
  String description;
  int facialExpressionId;

  Exercise({
    this.id,
    required this.name,
    required this.description,
    required this.facialExpressionId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'facial_expression_id': facialExpressionId,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      facialExpressionId: json['facial_expression_id'],
    );
  }

  @override
  String toString() {
    return 'Exercise{id: $id, name: $name, description: $description, facialExpressionId: $facialExpressionId}';
  }
}
