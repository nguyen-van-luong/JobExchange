import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_exchange/ui/common/utils/function_util.dart';

import '../../../models/province.dart';

Widget textFieldNumber(TextEditingController controller) {
  return SizedBox(
    width: 120,
    child: TextField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(
          fontSize: 18, color: Colors.black),
      controller: controller,
      decoration: const InputDecoration(
        labelStyle: TextStyle(
            color: Color(0xff888888),
            fontSize: 15),
      ),
    ),
  );
}

Widget textFieldDate(BuildContext context ,TextEditingController controller) {
  return SizedBox(
    width: 280,
    child: TextField(
      style: const TextStyle(
          fontSize: 18, color: Colors.black),
      controller: controller,
      readOnly: true, // Đặt TextField ở chế độ chỉ đọc
      onTap: () => selectDate(context, controller),
      decoration: const InputDecoration(
        labelStyle: TextStyle(
            color: Color(0xff888888),
            fontSize: 15),
      ),
    ),
  );
}

Widget textForm(TextEditingController controller) {
  return Container(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        top: 16,
        bottom: 16,
      ),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập nội dung';
                }
                return null;
              },
              maxLines: null,
              decoration: const InputDecoration.collapsed(
                hintText: 'Viết nội dung ở đây...',
              ),
              onChanged: (value) {
              },
            ),
          )
        ],
      ));
}

Widget menuDropDown(List<String> strs, TextEditingController controller) {
  final List<DropdownMenuEntry<String>> provinceEntries = strs.map((String str) {
    return DropdownMenuEntry<String>(
      value: str,
      labelWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${str}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            maxLines: 1,
          ),
        ],
      ),
      label: str,
    );
  }).toList();

  return DropdownMenu<String>(
    controller: controller,
    enableFilter: true,
    initialSelection: null,
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    hintText: "Chọn",
    dropdownMenuEntries: provinceEntries,
  );
}

Widget textField(TextEditingController controller) {
  return SizedBox(
    width: 280,
    child: TextField(
      style: const TextStyle(
          fontSize: 18, color: Colors.black),
      controller: controller,
      decoration: const InputDecoration(
        labelStyle: TextStyle(
            color: Color(0xff888888),
            fontSize: 15),
      ),
    ),
  );
}

Widget proviceDropDown(List<Province> provinces, TextEditingController controller, String hintText, Function(Province?) onSelect) {
  List<DropdownMenuEntry<Province>> provinceEntries = provinces.map((Province province) {
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
    controller: controller,
    enableFilter: true,
    initialSelection: null,
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    hintText: hintText,
    dropdownMenuEntries: provinceEntries,
    onSelected: onSelect,
  );
}