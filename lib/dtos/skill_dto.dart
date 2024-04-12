class SkillDto {
  String name;
  SkillDto({required this.name});

  Map<String, dynamic> toJson() {
    return{
      'name':  this.name,
    };
  }
}