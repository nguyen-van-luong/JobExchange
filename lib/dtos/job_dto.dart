import '../models/address.dart';
import '../models/industry_specialization.dart';

class JobDto {
  String title;
  DateTime duration;
  int? ageFrom;
  int? ageTo;
  int? salaryFrom;
  int? salaryTo;
  int? quantity;
  String? degree;
  bool? sex;
  String workingForm;
  String experience;
  List<Address> addresses;
  List<IndustrySpecialization> industrySpecializations;
  String description;
  String requirement;
  bool isPrivate;

  JobDto({
    required this.title,
    required this.duration,
    required this.ageFrom,
    required this.ageTo,
    required this.salaryFrom,
    required this.salaryTo,
    required this.quantity,
    required this.degree,
    required this.sex,
    required this.workingForm,
    required this.experience,
    required this.addresses,
    required this.industrySpecializations,
    required this.description,
    required this.requirement,
    required this.isPrivate,
  });

  Map<String, dynamic> toJson() {
    return{
      'title':  this.title,
      'duration': this.duration.toIso8601String(),
      'ageFrom':  this.ageFrom,
      'ageTo': this.ageTo,
      'salaryFrom':  this.salaryFrom,
      'salaryTo': this.salaryTo,
      'quantity':  this.quantity,
      'degree':  this.degree,
      'sex': this.sex,
      'workingForm': this.workingForm,
      'experience':  this.experience,
      'addresses': this.addresses.map((address) => address.toJson()).toList(),
      'industrySpecializations':  this.industrySpecializations.map((industrySpecialization) => industrySpecialization.toJson()).toList(),
      'description': this.description,
      'requirement': this.requirement,
      'private': this.isPrivate,
    };
  }
}