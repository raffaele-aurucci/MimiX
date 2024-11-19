class User {
  int? id;
  String username;
  int age;
  int level;
  DateTime levelCompletionDate;

  User({
    this.id,
    required this.username,
    required this.age,
    required this.level,
    required this.levelCompletionDate
  });

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'username' : username,
      'age' : age,
      'level' : level,
      'level_completion_date' : levelCompletionDate.millisecondsSinceEpoch
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      age: json['age'],
      level: json['level'],
      levelCompletionDate: DateTime.fromMillisecondsSinceEpoch(json['level_completion_date']),
    );
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, age: $age, level: $level, '
        'levelCompletionDate: $levelCompletionDate}';
  }

}