class IndustrySpecialization {
  final int industryId;
  final int specializationId;

  IndustrySpecialization({
    required this.industryId,
    required this.specializationId,
  });

  Map<String, dynamic> toJson() {
    return{
      'industryId':  this.industryId,
      'specializationId': this.specializationId
    };
  }
}