import 'package:job_exchange/dtos/skill_dto.dart';
import 'package:job_exchange/models/province.dart';

import '../models/industry_specialization.dart';

class CVDto {
  String fullname;
  DateTime birthday;
  String email;
  Province province;
  String address;
  bool? sex;
  String phoneNumber;
  String? positionCurrent;
  String positionWant;
  String degree;
  String? experience;
  int? salaryWant;
  String workingForm;
  List<SkillDto> skills;
  List<IndustrySpecialization> industrySpecializations;
  String? description;
  String? workExperience;
  bool isPrivate;

  CVDto({
    required this.fullname,
    required this.birthday,
    required this.email,
    required this.province,
    required this.address,
    required this.sex,
    required this.phoneNumber,
    required this.positionCurrent,
    required this.positionWant,
    required this.degree,
    required this.experience,
    required this.workingForm,
    required this.skills,
    required this.salaryWant,
    required this.industrySpecializations,
    required this.description,
    required this.workExperience,
    required this.isPrivate,
  });

  Map<String, dynamic> toJson() {
    return{
      'fullname':  this.fullname,
      'birthday': this.birthday.toIso8601String(),
      'email': this.email,
      'province':  this.province.toJson(),
      'address': this.address,
      'sex':  this.sex,
      'phoneNumber': this.phoneNumber,
      'positionCurrent':  this.positionCurrent,
      'positionWant':  this.positionWant,
      'experience': this.experience,
      'workingForm': this.workingForm,
      'degree': this.degree,
      'industrySpecializations':  this.industrySpecializations.map((industrySpecialization) => industrySpecialization.toJson()).toList(),
      'skills': this.skills.map((skill) => skill.toJson()).toList(),
      'salaryWant': this.salaryWant,
      "description": this.description,
      "workExperience": this.workExperience,
      'private': this.isPrivate,
    };
  }
}
