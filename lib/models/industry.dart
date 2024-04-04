class Industry {
  int id;
  String name;
  DateTime? updatedAt;

  Industry({
    required this.id,
    required this.name,
    required this.updatedAt,
  });

  Industry.empty()
      : id = 0,
        name = '',
        updatedAt = null;

  factory Industry.fromJson(Map<String, dynamic> json) {
    return Industry(
      id: json['id'],
      name: json['name'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Industry copyWith({
    int? id,
    String? name,
    DateTime? updatedAt
  }) {
    return Industry(
      id: id ?? this.id,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
