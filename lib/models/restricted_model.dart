class RestrictedModel {
  final String campo1;
  final String campo2;
  final String campo3;

  RestrictedModel({
    required this.campo1,
    required this.campo2,
    required this.campo3,
  });

  factory RestrictedModel.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return RestrictedModel(
      campo1: snapshot['campo1'],
      campo2: snapshot['campo2'],
      campo3: snapshot['campo3'],
    );
  }

  factory RestrictedModel.fromMap(Map<String, dynamic> map) {
    return RestrictedModel(
      campo1: map['campo1'] ?? '',
      campo2: map['campo2'] ?? '',
      campo3: map['campo3'] ?? '',
    );
  }
}
