import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
Widget ButtonPSD({
  required String text,
  required Function() onPressed,
  required RxBool loading,
}) {
  return Obx(
    () => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: Get.width,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.white),
                ),
                // backgroundColor: purpleTheme5_,
              ),
              onPressed: loading.value ? null : onPressed,
              child: loading.value
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cargando...',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircularProgressIndicator.adaptive(),
                      ],
                    )
                  : Text(
                      text,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
          )
        ],
      ),
    ),
  );
}
