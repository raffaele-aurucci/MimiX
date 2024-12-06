class ExpressionScores {
  Map<String, double> scores;

  ExpressionScores({required this.scores});

  factory ExpressionScores.fromJson(Map<String, dynamic> json) {
    Map<String, double> scores = {};
    json.forEach((key, value) {
      scores[key] = value.toDouble();
    });
    return ExpressionScores(scores: scores);
  }

  double? getScore(String category) {
    return scores[category];
  }

  @override
  String toString() {
    return 'ExpressionScores(${scores.map((key, value) => MapEntry(key, value.toStringAsFixed(3)))})';
  }
}