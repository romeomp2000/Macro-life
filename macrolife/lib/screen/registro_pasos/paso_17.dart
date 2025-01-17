import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_17(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        isActivo: true.obs,
        decoration: null,
        body: Column(
          // spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/icono_configuracion_lista_146x146_activo.png',
              width: 60,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 40),
              width: Get.width * 0.6,
              child: Text(
                'Gracias por tu confianza',
                // 'Thank you for trusting us',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10),
              width: Get.width * 0.5,
              child: Text(
                'Prometemos mantener siempre tu información personal privada y segura.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
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
