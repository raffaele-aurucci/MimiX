class Action {
  int? id;
  String name;
  String description;

  Action({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'Action{id: $id, name: $name, description: $description}';
  }
}
