import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
Widget TextFieldPSD({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  required TextInputType keyboardType,
  RxBool? enabled,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          width: Get.width,
          height: 60,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              // fillColor: purpleTheme5_,
              filled: true,
            ),
            style: const TextStyle(fontSize: 18, color: Colors.white),
            enabled: enabled?.value,
          ),
        )
      ],
    ),
  );
}
