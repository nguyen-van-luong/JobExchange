class Specialization {
  int id;
  int industryId;
  String name;
  DateTime? updatedAt;

  Specialization({
    required this.id,
    required this.industryId,
    required this.name,
    required this.updatedAt,
  });

  Specialization.empty()
      : id = 0,
        industryId = 0,
        name = '',
        updatedAt = null;

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['id'],
      industryId: json['industryId'],
      name: json['name'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }

  Specialization copyWith({
    int? id,
    int? industryId,
    String? name,
    DateTime? updatedAt
  }) {
    return Specialization(
      id: id ?? this.id,
      industryId: industryId ?? this.industryId,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'industryId': this.industryId,
      'name': this.name,
      'updatedAt':  this.updatedAt?.toIso8601String()
    };
  }
}
