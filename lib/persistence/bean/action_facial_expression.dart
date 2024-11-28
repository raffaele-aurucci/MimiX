class ActionFacialExpression {
  int actionId; // Foreign key referencing action
  int facialExpressionId; // Foreign key referencing facial_expression

  ActionFacialExpression({
    required this.actionId,
    required this.facialExpressionId,
  });

  Map<String, dynamic> toJson() {
    return {
      'action_id': actionId,
      'facial_expression_id': facialExpressionId,
    };
  }

  factory ActionFacialExpression.fromJson(Map<String, dynamic> json) {
    return ActionFacialExpression(
      actionId: json['action_id'],
      facialExpressionId: json['facial_expression_id'],
    );
  }

  @override
  String toString() {
    return 'ActionFacialExpression{actionId: $actionId, facialExpressionId: $facialExpressionId}';
  }
}
