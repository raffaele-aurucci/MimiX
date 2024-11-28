class Minigame {
  int? id;
  String name;
  String description;

  Minigame({
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

  factory Minigame.fromJson(Map<String, dynamic> json) {
    return Minigame(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'Minigame{id: $id, name: $name, description: $description}';
  }
}
