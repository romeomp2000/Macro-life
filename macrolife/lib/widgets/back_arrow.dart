import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackArrow extends StatelessWidget {
  final String text;
  const BackArrow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.arrow_left,
            color: Colors.black,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
      onPressed: () {
        Get.back();
      },
    );
  }
}
