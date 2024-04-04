import 'package:flutter/material.dart';
import 'package:job_exchange/models/province.dart';

import '../../../../../dtos/address.dart';
import '../../../../common/utils/text_field_custom.dart';

class CreateAddress extends StatefulWidget {
  final List<Province> provinces;
  final Function(Province, String) onCreate;

  const CreateAddress({super.key, required this.provinces, required this.onCreate});

  @override
  State<CreateAddress> createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  Province? selectedProvince;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            SizedBox(
              width: 120,
              child: Text("Tỉnh/Thành phố"),
            ),
            proviceDropDown()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: textFieldCustom("Chi tiết dịa chỉ", addressController),
        ),
        SizedBox(
          width: 100,
          child: TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 86, 143)) ),
            onPressed: () {
              if(selectedProvince != null && addressController.text.isNotEmpty) {
                widget.onCreate(selectedProvince!, addressController.text);
              }
              setState(() {
                provinceController.text = '';
                addressController.text = '';
              });
            },
            child: Text("Thêm", style: TextStyle(color: Colors.white),),
          ),
        )
      ],
    );
  }

  Widget proviceDropDown() {
    final List<DropdownMenuEntry<Province>> provinceEntries = widget.provinces.map((Province province) {
      return DropdownMenuEntry<Province>(
        value: province,
        labelWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${province.name}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
              maxLines: 1,
            ),
          ],
        ),
        label: province.name,
      );
    }).toList();

    return DropdownMenu<Province>(
      controller: provinceController,
      enableFilter: true,
      initialSelection: null,
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      hintText: "Chọn tỉnh/thành phố",
      dropdownMenuEntries: provinceEntries,
      onSelected: (Province? province) {
        selectedProvince = province;
      },
    );
  }
}
