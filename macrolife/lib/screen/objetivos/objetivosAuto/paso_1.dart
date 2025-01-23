import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/models/list_tile_model.dart';
import 'package:macrolife/screen/objetivos/objetivosAuto/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_1(ObjetivosAutoController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enableScroll: true,
        isActivo: controller.isNivelActividad,
        title: 'Seleccione el nivel de actividad',
        description: 'Utilizamos esta información para crear tu perfil',
        options: [
          ListTileModel(
            title: 'Mínimo',
            subtitle:
                'Perfecto para aquellos con un estilo de vida predominantemente estacionario.',
          ),
          ListTileModel(
            title: 'Moderadamente',
            subtitle: 'Diseñado para quienes realizan ejercicio regularmente.',
          ),
          ListTileModel(
            title: 'Muy activo',
            subtitle:
                'Diseñado para deportistas, entusiastas del fitness o personas con rutinas muy activas.',
          ),
        ],
        onOptionSelected: (entrenamiento) async {
          controller.isNivelActividad.value = true;
          controller.entrenamiento.value = entrenamiento;
          FuncionesGlobales.vibratePress();
        },
        selectedOption: controller.entrenamiento.value,
        onNext:
            controller.isEntrenamientoSelected() ? controller.nextStep : null,
      ),
    ),
  );
}
