class FacialExpression {
  int? id;
  String name;
  String description;
  String parameter;
  double value;

  FacialExpression({
    this.id,
    required this.name,
    required this.description,
    required this.parameter,
    required this.value
  });

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name,
      'description' : description,
      'parameter' : parameter,
      'value' : value
    };
  }

  factory FacialExpression.fromJson(Map<String, dynamic> json) {
    return FacialExpression(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      parameter: json['parameter'],
      value: json['value'],
    );
  }

  @override
  String toString() {
    return 'FacialExpression{id: $id, name: $name, description: $description, parameter: $parameter, '
        'value: $value}';
  }
}