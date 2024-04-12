import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../models/industry.dart';

Widget industryDropDown(List<Industry> industries, TextEditingController controller, String hintText,Future<void> Function(Industry?) onSelect) {
  final List<DropdownMenuEntry<Industry>> industryEntries = industries.map((Industry industry) {
    return DropdownMenuEntry<Industry>(
      value: industry,
      labelWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${industry.name}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            maxLines: 1,
          ),
        ],
      ),
      label: industry.name,
    );
  }).toList();

  return DropdownMenu<Industry>(
    controller: controller,
    enableFilter: true,
    initialSelection: null,
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    hintText: hintText,
    dropdownMenuEntries: industryEntries,
    onSelected: (Industry? industry) async {
      onSelect(industry);
    },
  );
}