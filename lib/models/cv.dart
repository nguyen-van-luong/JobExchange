import 'package:job_exchange/models/province.dart';
import 'package:job_exchange/models/skill.dart';
import 'package:job_exchange/models/student.dart';

import '../models/address.dart';
import '../models/industry_specialization.dart';
import 'employer.dart';

class CV {
  int id;
  Student student;
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
  String? workingForm;
  List<Skill> skills;
  List<IndustrySpecialization> industrySpecializations;
  String description;
  String workExperience;
  bool isPrivate;
  DateTime updatedAt;

  CV({
    required this.id,
    required this.student,
    required this.fullname,
    required this.province,
    required this.address,
    required this.skills,
    required this.workExperience,
    required this.email,
    required this.salaryWant,
    required this.degree,
    required this.positionWant,
    required this.workingForm,
    required this.experience,
    required this.positionCurrent,
    required this.phoneNumber,
    required this.description,
    required this.industrySpecializations,
    required this.sex,
    required this.birthday,
    required this.updatedAt,
    required this.isPrivate
  });

  CV.empty()
      : id = 0,
        student = Student.empty(),
        fullname = '',
        birthday = DateTime.now(),
        positionCurrent = null,
        phoneNumber = '',
        positionWant = '',
        salaryWant = null,
        email = '',
        workExperience = '',
        skills = [],
        province = Province.empty(),
        address = '',
        degree = '',
        experience = '',
        workingForm = '',
        sex = null,
        industrySpecializations = [],
        isPrivate = true,
        updatedAt = DateTime.now(),
        description = '';

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
      id: json['id'],
      student: Student.fromJson(json['student']),
      fullname: json['fullname'],
      birthday: DateTime.tryParse(json['birthday']) ?? DateTime.now(),
      email: json['email'],
      province: Province.fromJson(json['province']),
      address: json['address'],
      sex: json['sex'],
      phoneNumber: json['phoneNumber'],
      positionCurrent: json['positionCurrent'],
      positionWant: json['positionWant'],
      degree: json['degree'],
      experience: json['experience'],
      salaryWant: json['salaryWant'],
      workingForm: json['workingForm'],
      skills: (json['skills'] as List<dynamic>)
          .map((skill) => Skill.fromJson(skill))
          .toList(),
      industrySpecializations: (json['industrySpecializations'] as List<dynamic>)
          .map((industrySpecialization) => IndustrySpecialization.fromJson(industrySpecialization))
          .toList(),
      isPrivate: json['isPrivate'],
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
      description: json['description'],
      workExperience: json['workExperience'],
    );
  }

  CV copyWith({
    int? id,
    Student? student,
    String? fullname,
    DateTime? birthday,
    String? email,
    Province? province,
    String? address,
    bool? sex,
    String? phoneNumber,
    String? positionCurrent,
    String? positionWant,
    String? degree,
    String? experience,
    int? salaryWant,
    String? workingForm,
    List<Skill>? skills,
    List<IndustrySpecialization>? industrySpecializations,
    String? description,
    String? workExperience,
    bool? isPrivate,
    DateTime? updatedAt,
  }) {
    return CV(
      id: id ?? this.id,
      student: student ?? this.student,
      fullname: fullname ?? this.fullname,
      birthday: birthday ?? this.birthday,
      email: email ?? this.email,
      province: province ?? this.province,
      address: address ?? this.address,
      sex: sex ?? this.sex,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      positionCurrent: positionCurrent ?? this.positionCurrent,
      positionWant: positionWant ?? this.positionWant,
      degree: degree ?? this.degree,
      experience: experience ?? this.experience,
      salaryWant: salaryWant ?? this.salaryWant,
      workingForm: workingForm ?? this.workingForm,
      skills: skills ?? this.skills,
      industrySpecializations: industrySpecializations ?? this.industrySpecializations,
      description: description ?? this.description,
      workExperience: workExperience ?? this.workExperience,
      isPrivate: isPrivate ?? this.isPrivate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}