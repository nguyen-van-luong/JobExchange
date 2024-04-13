import '../models/address.dart';
import '../models/industry_specialization.dart';
import 'employer.dart';

class Job {
  int id;
  Employer employer;
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
  DateTime updatedAt;

  Job({
    required this.id,
    required this.employer,
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
    required this.updatedAt,
  });

  Job.empty()
      : id = 0,
        employer = Employer.empty(),
        title = '',
        duration = DateTime.now(),
        ageFrom = 0,
        ageTo = 0,
        salaryFrom = 0,
        salaryTo = 0,
        quantity = 0,
        degree = '',
        experience = '',
        workingForm = '',
        sex = null,
        addresses = [],
        industrySpecializations = [],
        isPrivate = true,
        updatedAt = DateTime.now(),
        description = '',
        requirement = '';

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      employer: Employer.fromJson(json['employer']),
      title: json['title'],
      duration: DateTime.tryParse(json['duration']) ?? DateTime.now(),
      ageFrom: json['ageFrom'],
      ageTo: json['ageTo'],
      salaryFrom: json['salaryFrom'],
      salaryTo: json['salaryTo'],
      quantity: json['quantity'],
      degree: json['degree'],
      experience: json['experience'],
      workingForm: json['workingForm'],
      sex: json['sex'],
      addresses: (json['addresses'] as List<dynamic>)
          .map((address) => Address.fromJson(address))
          .toList(),
      industrySpecializations: (json['industrySpecializations'] as List<dynamic>)
          .map((industrySpecialization) => IndustrySpecialization.fromJson(industrySpecialization))
          .toList(),
      isPrivate: json['isPrivate'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
      description: json['description'],
      requirement: json['requirement'],
    );
  }

  Job copyWith({
    int? id,
    Employer? employer,
    String? title,
    DateTime? duration,
    int? ageFrom,
    int? ageTo,
    int? salaryFrom,
    int? salaryTo,
    int? quantity,
    String? degree,
    bool? sex,
    String? workingForm,
    String? experience,
    List<Address>? addresses,
    List<IndustrySpecialization>? industrySpecializations,
    String? description,
    String? requirement,
    bool? isPrivate,
    DateTime? updatedAt,
  }) {
    return Job(
      id: id ?? this.id,
      employer: employer ?? this.employer,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      ageFrom: ageFrom ?? this.ageFrom,
      ageTo: ageTo ?? this.ageTo,
      salaryFrom: salaryFrom ?? this.salaryFrom,
      salaryTo: salaryTo ?? this.salaryTo,
      quantity: quantity ?? this.quantity,
      degree: degree ?? this.degree,
      sex: sex ?? this.sex,
      workingForm: workingForm ?? this.workingForm,
      experience: experience ?? this.experience,
      addresses: addresses ?? this.addresses,
      industrySpecializations: industrySpecializations ?? this.industrySpecializations,
      description: description ?? this.description,
      requirement: requirement ?? this.requirement,
      isPrivate: isPrivate ?? this.isPrivate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}