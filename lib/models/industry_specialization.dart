import 'package:job_exchange/models/industry.dart';
import 'package:job_exchange/models/specialization.dart';

class IndustrySpecialization {
  final Industry industry;
  final Specialization? specialization;

  IndustrySpecialization({
    required this.industry,
    required this.specialization,
  });

  Map<String, dynamic> toJson() {
    return{
      'industry':  this.industry.toJson(),
      'specialization': this.specialization?.toJson()
    };
  }

  IndustrySpecialization.empty()
      : industry = Industry.empty(),
        specialization = null;

  factory IndustrySpecialization.fromJson(Map<String, dynamic> json) {
    return IndustrySpecialization(
      industry: Industry.fromJson(json['industry']),
      specialization: Specialization.fromJson(json['specialization']),
    );
  }

  IndustrySpecialization copyWith({
    Industry? industry,
    Specialization? specialization
  }) {
    return IndustrySpecialization(
      industry: industry ?? this.industry,
      specialization: specialization ?? this.specialization,
    );
  }
}