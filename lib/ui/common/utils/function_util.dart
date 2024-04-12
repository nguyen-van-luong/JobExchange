import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> selectDate(BuildContext context, TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    // Cập nhật ngày đã chọn vào _dateController
    controller.text = DateFormat('yyyy-MM-dd').format(picked);
  }
}