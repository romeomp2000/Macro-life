import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_11(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(() {
      FuncionesGlobales.getDeviceToken();

      return Steep(
        enableScroll: true,
        enablePadding: true,
        isActivo: true.obs,
        body: Column(
          spacing: 10,
          children: [
            const Text(
              'Desactiva las notificaciones en cualquier momento desde ajustes',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(60),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Color.fromARGB(255, 246, 246, 246),
                  )),
              child: Image.asset(
                'assets/icons/icono_campana_notificacion_156x156_activo.png',
                width: 60,
              ),
            ),
          ],
        ),
        title: '¡Recibe notificaciones!',
        options: const [],
        onOptionSelected: (probado) => controller.probado.value = probado,
        selectedOption: controller.probado.value,
        onNext: () async {
          // await FuncionesGlobales().permisos();
          controller.nextStep();
        },
      );
    }),
  );
}
