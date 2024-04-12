import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_exchange/models/specialization.dart';


Widget specializationDropDown(List<Specialization> specializations, TextEditingController controller, Function(Specialization? specialization) onSelect) {
  final List<DropdownMenuEntry<Specialization>> specializationEntries = specializations.map((Specialization specialization) {
    return DropdownMenuEntry<Specialization>(
      value: specialization,
      labelWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${specialization.name}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            maxLines: 1,
          ),
        ],
      ),
      label: specialization.name,
    );
  }).toList();

  return DropdownMenu<Specialization>(
    controller: controller,
    enableFilter: true,
    initialSelection: null,
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    hintText: "Chọn",
    dropdownMenuEntries: specializationEntries,
    onSelected: (Specialization? specialization) => onSelect(specialization),
  );
}