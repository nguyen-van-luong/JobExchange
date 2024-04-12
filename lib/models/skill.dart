class Skill {
  int id;
  String name;

  Skill({required this.id, required this.name});

  Skill.empty()
      : id = 0,
        name = '';

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
    );
  }

  Skill copyWith({
    int? id,
    String? name,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id':  this.id,
      'name': this.name
    };
  }
}