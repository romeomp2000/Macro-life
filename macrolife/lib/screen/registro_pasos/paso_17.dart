import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_17(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        isActivo: true.obs,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/icons/confetti3.gif',
            ),
          ),
        ),
        body: Column(
          spacing: 20,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Gracias por confiar en nosotros',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Prometemos mantener siempre su información personal privada y segura.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        title: '',
        options: const [],
        onOptionSelected: (probado) => controller.probado.value = probado,
        selectedOption: controller.probado.value,
        onNext: () => controller.onRegistrarLoader(),
      ),
    ),
  );
}
