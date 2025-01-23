import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/controller.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/paso_1.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/paso_2.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/paso_3.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/paso_4.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/paso_5.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/paso_6.dart';

class ObjetivosAutoScreen extends StatelessWidget {
  const ObjetivosAutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ObjetivosAutoController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        leading: Container(
          margin: EdgeInsets.only(top: 1, bottom: 1),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 237, 237, 237),
                    offset: Offset(0.1, 0.1),
                    blurRadius: 1),
              ]),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {controller.back()},
          ),
        ),
        title: Row(
          spacing: 15,
          children: [
            Obx(
              () => Container(
                height: 40,
                width: Get.width - 95,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 237, 237, 237),
                        offset: Offset(0.1, 0.1),
                        blurRadius: 1,
                      ),
                    ]),
                padding: EdgeInsets.symmetric(vertical: 19, horizontal: 15),
                child: LinearProgressIndicator(
                  minHeight: 3.5,
                  value: controller.progress.value,
                  color: Colors.black,
                  backgroundColor: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ],
        ),
        // backgroundColor: Colors.white,
      ),
      body: Obx(
        () => PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: (index) => controller.activePage.value = index + 1,
          children: [
            paso_1(controller),
            paso_2(controller),
            paso_3(controller),
            paso_4(controller),
            paso_5(controller),
            paso_6(controller)
          ],
        ),
      ),
    );
  }
}
