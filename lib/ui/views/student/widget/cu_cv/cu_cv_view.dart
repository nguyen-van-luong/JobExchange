import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:job_exchange/ui/views/student/blocs/cv_cv/cu_cv_bloc.dart';
import 'package:job_exchange/ui/views/student/widget/skill_item.dart';

import '../../../../../dtos/cv_dto.dart';
import '../../../../../dtos/skill_dto.dart';
import '../../../../../models/industry.dart';
import '../../../../../models/industry_specialization.dart';
import '../../../../../models/province.dart';
import '../../../../../models/specialization.dart';
import '../../../../../repositories/specialization_repository.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../router.dart';
import '../../../../widgets/form_view_custom.dart';
import '../../../../widgets/header_form.dart';
import '../../../../widgets/header_view.dart';
import '../../../../widgets/industry_drop_down.dart';
import '../../../../widgets/notification.dart';
import '../../../employer/widget/cu_job/industry_specialization_item.dart';
import '../../../employer/widget/specialization_drop_down.dart';

class CUCVView extends StatefulWidget {
  const CUCVView();

  @override
  State<CUCVView> createState() => _CUCVViewState();
}

class _CUCVViewState extends State<CUCVView> {

  SpecializationRepository specializationRepository = SpecializationRepository();
  late CUCVBloc _bloc;

  final _fullnameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _provinceController = TextEditingController();
  final _addressController = TextEditingController();
  final _sexController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _positionCurrentController = TextEditingController();
  final _positionWantController = TextEditingController();
  final _degreeController = TextEditingController();
  final _experienceController = TextEditingController();
  final _workingFormController = TextEditingController();
  final _skillController = TextEditingController();
  final _salaryWantController = TextEditingController();
  final _industryController = TextEditingController();
  final _specializationController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _workExperienceController = TextEditingController();

  final List<String> degrees = ["Trên đại học", "Đại học", "Cao đẳng", "Trung cấp", "Trung học", "Chứng chỉ", "Không yêu cầu"];
  final List<String> experiences = ["Chưa có kinh nghiệm", "Dưới 1 năm", "1 năm", "2 năm", "3 năm", "4 năm", "5 năm", "Trên 5 năm"];
  final List<String> workingForms = ["Toàn thời gian", "Bán thời gian", "Thực tập", "Khác"];
  final List<String> sexs = ["Trống", "Nam", "Nữ"];

  List<SkillDto> skills = [];
  List<Specialization> specializations = [];
  List<IndustrySpecialization> industrySpecializations = [];

  Province? selectedProvince = null;
  Industry? industrySelected = null;
  Specialization? specializationSelected = null;

  @override
  void initState() {
    super.initState();
    _bloc = CUCVBloc()
      ..add(LoadEvent());
  }

  @override
  void didUpdateWidget(CUCVView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<CUCVBloc, CUCVState>(
        listener: (context, state) {
          if(state is SaveSuccess) {
            appRouter.go("/");
          } else if(state is LoadFailure) {
            showTopRightSnackBar(context, state.message, state.notifyType);
          }
        },
        child: BlocBuilder<CUCVBloc, CUCVState>(
          builder: (context, state) {
            if(state is CuCVStateData) {
              return Column(
                children: [
                  headerView("Hồ sơ"),
                  Container(
                      margin: EdgeInsets.all(40),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 40),
                                color: Colors.white,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 40,
                                      child: FilledButton(
                                        onPressed: () {
                                          _bloc.add(SaveEvent(cv: createJob(false)));
                                        },
                                        child: Text("Lưu",
                                            style: TextStyle(fontSize: 20),
                                            softWrap: false,
                                            maxLines: 1),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      padding: EdgeInsets.only(left: 16),
                                      child: FilledButton(
                                        onPressed: () {
                                          _bloc.add(SaveEvent(cv: createJob(true)));
                                        },
                                        child: Text("Lưu tạm",
                                            style: TextStyle(fontSize: 20),
                                            softWrap: false,
                                            maxLines: 1),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              buildIndividual(state.provinces),
                              buildCommon(),
                              buildSkill(),
                              buildIndustrySpecialization(state.industries),
                              buildFormView("Mô tả bản thân", _descriptionController),
                              buildFormView("Kinh nghiệm làm việc", _workExperienceController)
                            ],
                          ),
                        ],
                      )
                  )
                ],
              );
            } else if (state is LoadFailure) {
              return Container(
                alignment: Alignment.center,
                child:
                Text(state.message, style: const TextStyle(fontSize: 16)),
              );
            }

            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          },
        ),
      )
    );
  }

  Widget buildIndividual(List<Province> provinces) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          headerForm(lable: "Thông tin cá nhân"),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Họ và tên", textField(_fullnameController)),
                textFieldCustom("Ngày sinh", textFieldDate(context, _birthdayController))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Tỉnh / thành pố", proviceDropDown(provinces, _provinceController,"Chọn", (Province? province) {selectedProvince = province;})),
                textFieldCustom("Địa chỉ", textField(_addressController))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Giới tính", menuDropDown(sexs, _sexController)),
                textFieldCustom("Số điện thoại", textFieldNumber(_phoneNumberController))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Email", textField(_emailController)),
                Container()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommon() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          headerForm(lable: "Thông tin chung"),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Chức vụ mong muốn", textField(_positionWantController)),
                textFieldCustom("Chứ vụ hiện tại", textField(_positionCurrentController))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Số năm kinh nghiệm", menuDropDown(experiences, _experienceController)),
                textFieldCustom("Bằng cấp", menuDropDown(degrees, _degreeController))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Hình thức làm việc", menuDropDown(workingForms, _workingFormController)),
                Container(
                  width: 450,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("Mức lương mong muốn"),
                      ),
                      textFieldNumber(_salaryWantController),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Triệu"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSkill() {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerForm(lable: "Kĩ năng"),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                for (var skill in skills.asMap().entries)
                  SkillItem(
                    name: skill.value.name,
                    onDelete: () {
                      setState(() {
                        skills.removeAt(skill.key);
                      });
                    },
                  ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: textFieldCustom("Kĩ năng", textField(_skillController)),
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
                    onPressed: () {
                      if(_skillController.text.isNotEmpty) {
                        skills.add(SkillDto(name: _skillController.text));
                      }
                      setState(() {
                        _skillController.text = "";
                      });
                    },
                    child: Text("Thêm", style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  Widget buildIndustrySpecialization(List<Industry> industries) {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerForm(lable: "Lĩnh vực"),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                for (var item in industrySpecializations.asMap().entries)
                  IndustrySpecializationItem(
                    industry: item.value.industry.name,
                    specialization: item.value.specialization == null ? null:item.value.specialization!.name,
                    onDelete: () {
                      setState(() {
                        industrySpecializations.removeAt(item.key);
                      });
                    },
                  ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: textFieldCustom("Ngành",
                      industryDropDown(
                          industries,
                          _industryController,
                          "Chọn",
                          selectIndustry)),
                ),
                Expanded(
                  flex: 2,
                  child: textFieldCustom("Chuyên ngành", specializationDropDown(specializations, _specializationController, selectSpecialization)),
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
                    onPressed: () {
                      if(industrySelected != null) {
                        industrySpecializations.add(IndustrySpecialization(industry: industrySelected!, specialization: specializationSelected));
                      }
                      setState(() {
                        industrySelected = null;
                        specializationSelected = null;
                        _industryController.text = "";
                        _specializationController.text = "";
                        specializations = [];
                      });
                    },
                    child: Text("Thêm", style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  Future<void> selectIndustry(Industry? industry) async {
    Response<dynamic> response = await specializationRepository.getByIndustryId(industry!.id);
    specializations = response.data == null ? [] : response.data.map<Specialization>((e) => Specialization.fromJson(e as Map<String, dynamic>)).toList();
    industrySelected = industry!;
    setState(() {

    });
  }

  void selectSpecialization(Specialization? specialization) {
    specializationSelected = specialization!;
  }

  CVDto createJob(bool isPrivate) {
    return CVDto(fullname: _fullnameController.text,
        birthday: DateFormat('yyyy-MM-dd').parse(_birthdayController.text),
        address: _addressController.text,
        sex: getSex(),
        degree: _degreeController.text,
        description: _descriptionController.text,
        email: _emailController.text,
        experience: _experienceController.text,
        industrySpecializations: industrySpecializations,
        phoneNumber: _phoneNumberController.text,
        positionCurrent: _positionCurrentController.text,
        positionWant: _positionWantController.text,
        province: selectedProvince ?? Province.empty(),
        salaryWant: int.parse(_salaryWantController.text),
        skills: skills,
        workExperience: _workExperienceController.text,
        workingForm: _workingFormController.text,
        isPrivate: isPrivate
    );
  }

  bool? getSex() {
    if(_sexController.text == 'Nam')
      return false;
    else if(_sexController.text == 'Nữ')
      return true;
    return null;
  }
}