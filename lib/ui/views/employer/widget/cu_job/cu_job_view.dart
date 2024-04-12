import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:job_exchange/dtos/job_dto.dart';
import 'package:job_exchange/ui/views/employer/blocs/cu_job/cu_job_bloc.dart';
import 'package:job_exchange/ui/views/employer/widget/cu_job/address_item.dart';
import 'package:job_exchange/ui/views/employer/widget/cu_job/create_address.dart';
import 'package:job_exchange/ui/views/employer/widget/cu_job/industry_specialization_item.dart';

import '../../../../../models/address.dart';
import '../../../../../models/industry.dart';
import '../../../../../models/industry_specialization.dart';
import '../../../../../models/province.dart';
import '../../../../../models/specialization.dart';
import '../../../../../repositories/industry_repository.dart';
import '../../../../../repositories/specialization_repository.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/text_form_custom.dart';
import '../../../../common/utils/widget.dart';
import '../../../../router.dart';
import '../../../../widgets/form_view_custom.dart';
import '../../../../widgets/header_form.dart';
import '../../../../widgets/notification.dart';
import '../specialization_drop_down.dart';
import 'industry_drop_down.dart';

class CUJobView extends StatefulWidget {
  const CUJobView();

  @override
  State<CUJobView> createState() => _CUJobViewState();
}

class _CUJobViewState extends State<CUJobView> {

  late CUJobBloc _bloc;

  SpecializationRepository specializationRepository = SpecializationRepository();

  final _titleController = TextEditingController();
  final _duationController = TextEditingController();
  final _ageFromController = TextEditingController();
  final _ageToController = TextEditingController();
  final _salaryFromController = TextEditingController();
  final _salaryToController = TextEditingController();
  final _sexController = TextEditingController();
  final _quantityController = TextEditingController();
  final _degreeController = TextEditingController();
  final _workingFormController = TextEditingController();
  final _experienceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementController = TextEditingController();
  final _industryController = TextEditingController();
  final _specializatoinController = TextEditingController();

  final List<String> degrees = ["Trên đại học", "Đại học", "Cao đẳng", "Trung cấp", "Trung học", "Chứng chỉ", "Không yêu cầu"];
  final List<String> experiences = ["Chưa có kinh nghiệm", "Dưới 1 năm", "1 năm", "2 năm", "3 năm", "4 năm", "5 năm", "Trên 5 năm"];
  final List<String> workingForms = ["Toàn thời gian", "Bán thời gian", "Thực tập", "Khác"];
  final List<String> sexs = ["Trống", "Nam", "Nữ"];

  List<Province> provinces = [];
  List<Industry> industries = [];
  List<Address> addresses = [];
  List<Specialization> specializations = [];
  List<IndustrySpecialization> industrySpecializations = [];
  Industry? industrySelected = null;
  Specialization? specializationSelected = null;

  @override
  void initState() {
    super.initState();
    _bloc = CUJobBloc()
      ..add(LoadEvent());
  }

  @override
  void didUpdateWidget(CUJobView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<CUJobBloc, CUJobState>(
        listener: (context, state) {
          if(state is SaveSuccess) {
            appRouter.go("/");
          } else if(state is PostFailure) {
            showTopRightSnackBar(context, state.message, state.notifyType);
          }
        },
        child: BlocBuilder<CUJobBloc, CUJobState>(
          builder: (context, state) {
            if(state is CuJobStateData) {
              provinces = state.provinces;
              industries = state.industries;
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    color: Colors.white,
                    child: Text(
                      "Tạo bài viết",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 600,
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.black),
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    labelText: 'Tiêu đề',
                                    labelStyle: const TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 80,
                                    padding: EdgeInsets.all(16),
                                    child: FilledButton(
                                      onPressed: () {
                                        _bloc.add(SaveEvent(job: createJob(false)));
                                      },
                                      child: Text("Lưu",
                                          style: TextStyle(fontSize: 20),
                                          softWrap: false,
                                          maxLines: 1),
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    padding: EdgeInsets.all(16),
                                    child: FilledButton(
                                      onPressed: () {
                                        _bloc.add(SaveEvent(job: createJob(true)));
                                      },
                                      child: Text("Lưu tạm",
                                          style: TextStyle(fontSize: 20),
                                          softWrap: false,
                                          maxLines: 1),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        buildCommon(),
                        Container(
                            margin: EdgeInsets.only(bottom: 40),
                            color: Colors.white,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headerForm(lable: "Địa chỉ"),
                                SizedBox(height: 10),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  children: [
                                    for (var address in addresses.asMap().entries)
                                      AddressItem(
                                        provinceName: address.value.province.name,
                                        address: address.value.address,
                                        onDelete: () {
                                          setState(() {
                                            addresses.removeAt(address.key);
                                          });
                                        },
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                CreateAddress(provinces: provinces, onCreate: (province, address) {
                                  setState(() {
                                    addresses.add(Address(province: province, address: address));
                                  });
                                })
                              ],
                            )
                        ),
                        Container(
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
                                      child: textFieldCustom("Ngành", industryDropDown(industries, _industryController, "Chọn", selectIndustry)),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: textFieldCustom("Chuyên ngành", specializationDropDown(specializations, _specializatoinController, selectSpecialization)),
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
                                            _specializatoinController.text = "";
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
                        ),
                        buildFormView("Mô tả", _descriptionController),
                        buildFormView("Yêu cầu", _requirementController)
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is PostFailure) {
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
      ),
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
                Container(
                  width: 450,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("Hạn nộp hồ sơ"),
                      ),
                      textFieldDate(context, _duationController)
                    ],
                  ),
                ),
                Container(
                  width: 450,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("Độ tuổi"),
                      ),
                      textFieldNumber(_ageFromController),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text("~"),
                      ),
                      textFieldNumber(_ageToController)
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Kinh nghiệm", menuDropDown(experiences, _experienceController)),
                Container(
                  width: 450,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("Mức lương"),
                      ),
                      textFieldNumber(_salaryFromController),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text("~"),
                      ),
                      textFieldNumber(_salaryToController),
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
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Giớ tính", menuDropDown(sexs, _sexController)),
                textFieldCustom("Bằng cấp", menuDropDown(degrees, _degreeController))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldCustom("Số lượng tuyển", textFieldNumber(_quantityController)),
                textFieldCustom("Hình thức làm việc", menuDropDown(workingForms, _workingFormController)),
              ],
            ),
          )
        ],
      ),
    );
  }

  JobDto createJob(bool isPrivate) {
    return JobDto(title: _titleController.text,
        duration: DateFormat('yyyy-MM-dd').parse(_duationController.text),
        ageFrom: int.parse(_ageFromController.text),
        ageTo: int.parse(_ageToController.text),
        experience: _experienceController.text,
        sex: _sexController.text == 'Nam' ? false:true,
        salaryFrom: int.parse(_salaryFromController.text),
        salaryTo: int.parse(_salaryToController.text),
        degree: _degreeController.text,
        quantity: int.parse(_quantityController.text),
        workingForm: _workingFormController.text,
        addresses: addresses,
        industrySpecializations: industrySpecializations,
        description: _descriptionController.text,
        requirement: _requirementController.text,
        isPrivate: isPrivate
    );
  }
}
