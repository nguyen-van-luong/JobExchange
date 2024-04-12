import 'package:flutter/material.dart';
import 'package:job_exchange/models/province.dart';
import 'package:job_exchange/ui/common/utils/widget.dart';

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
        Expanded(
          flex: 2,
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: Text("Tỉnh/Thành phố"),
              ),
              proviceDropDown(widget.provinces, provinceController, "Chọn", (Province? province) {selectedProvince = province;})
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: textFieldCustom("Chi tiết địa chỉ", textField(addressController)),
          ),
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
}
