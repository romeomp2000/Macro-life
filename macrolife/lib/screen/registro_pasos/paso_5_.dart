import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';
import 'package:macrolife/widgets/FechaNacimientoPicker.dart';

Widget paso_5(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        // enableScroll: true,
        isActivo: true.obs,
        body: Column(
          children: [
            FechaNacimientoPicker(
              defaultAnio: controller.anio.value,
              defaultMes: controller.mes.value,
              defaultDia: controller.dia.value,
              onFechaSeleccionada: (fecha) {
                // print(fecha);
                // print('------------');
                controller.fechaNacimiento.value = fecha;
              },
            ),
          ],
        ),
        title: '¿Cuántos años tienes?',
        description:
            'Utilizamos esta información para crear su perfil personalizado',
        options: const [],
        onOptionSelected: (probado) => controller.probado.value = probado,
        selectedOption: controller.probado.value,
        onNext:
            // () {
            //   controller.isFechaNacimientoSelected();
            // }
            controller.isFechaNacimientoSelected() ? controller.nextStep : null,
      ),
    ),
  );
}
