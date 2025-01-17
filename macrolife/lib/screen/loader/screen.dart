import 'package:macrolife/screen/loader/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoaderController controller = Get.put(LoaderController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              child: Obx(() {
                if (controller.loading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ),
            Container(
              width: Get.width * 0.7,
              alignment: Alignment.center,
              child: const Text(
                'Estamos configurando todo para ti',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: Get.width * 0.7,
              alignment: Alignment.center,
              child: Obx(
                () => Text(
                  controller.texto.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
