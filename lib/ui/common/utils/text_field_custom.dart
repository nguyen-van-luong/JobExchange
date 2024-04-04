import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFieldCustom(String lable, TextEditingController controller) {
  return Container(
    width: 450,
    child: Row(
      children: [
        Container(
          width: 120,
          padding: const EdgeInsets.only(right: 10),
          child: Text(lable),
        ),
        SizedBox(
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
        )
      ],
    ),
  );
}