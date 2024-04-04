import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_exchange/ui/views/employer/widget/cu_job/address_item.dart';
import 'package:job_exchange/ui/views/employer/widget/cu_job/create_address.dart';

import '../../../../../dtos/address.dart';
import '../../../../../models/industry.dart';
import '../../../../../models/province.dart';
import '../../../../../models/specialization.dart';
import '../../../../common/utils/text_field_custom.dart';
import '../../../../common/utils/text_form_custom.dart';

class CUJobView extends StatefulWidget {
  const CUJobView();

  @override
  State<CUJobView> createState() => _CUJobViewState();
}

class _CUJobViewState extends State<CUJobView> {

  final _titleController = TextEditingController();
  final _duationController = TextEditingController();
  final _ageFromController = TextEditingController();
  final _ageToController = TextEditingController();
  final _salaryController = TextEditingController();
  final _experienceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementController = TextEditingController();
  final _addressController = TextEditingController();

  // final List<Industry> industrys = [Industry(id: 1, name: "Công nghệ thông tin", updatedAt: null),
  //   Industry(id: 2, name: "Kỹ thuật điện", updatedAt: null)];
  //
  // final List<Specialization> specializations = [Sp];

  final List<Province> provinces = [Province(id: 1, name: "Bình Định", updatedAt: null),
    Province(id: 2, name: "Nha Trang", updatedAt: null)];
  List<Address> addresses = [];

  @override
  Widget build(BuildContext context) {
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
          color: Colors.white,
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 300,
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black),
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: const TextStyle(
                              color: Color(0xff888888),
                              fontSize: 15),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Lưu"),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textFieldCustom("Hạn nộp hồ sơ", _duationController),
                    Container(
                      width: 450,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            padding: const EdgeInsets.only(right: 10),
                            child: Text("Độ tuổi"),
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              controller: _ageFromController,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                    color: Color(0xff888888),
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text("~"),
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              controller: _ageToController,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                    color: Color(0xff888888),
                                    fontSize: 15),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textFieldCustom("Mức lương", _salaryController),
                    textFieldCustom("Kinh nghiệm", _experienceController)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: textFormCustom("Mô tả", _descriptionController),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: textFormCustom("Yêu cầu", _requirementController),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text("Địa chỉ")
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                        CreateAddress(provinces: provinces, onCreate: (province, address) {
                          setState(() {
                            addresses.add(Address(province: province, address: address));
                          });
                        })
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
