import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_1(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enableScroll: true,
        isActivo: controller.isActivoGenero,
        title: '¿Cuál es tu genero?',
        description: 'Utilizamos esta información para crear tu perfil',
        options: [],
        body: Column(
          spacing: 20,
          children: [
            GeneroSelect(
              selected: controller.selectedGender.value == 'Masculino',
              onTap: () {
                controller.isActivoGenero.value = true;
                controller.selectedGender.value = 'Masculino';
              },
              genero: 'Masculino',
              icon:
                  'assets/icons/icono_seleccion_genero_161x161_2025_masculino_activo.png',
            ),
            GeneroSelect(
              selected: controller.selectedGender.value == 'Femenino',
              onTap: () {
                controller.isActivoGenero.value = true;
                controller.selectedGender.value = 'Femenino';
              },
              genero: 'Femenino',
              icon:
                  'assets/icons/icono_seleccion_genero_161x161_2025_femenino_activo.png',
            ),
            GeneroSelect(
              selected: controller.selectedGender.value == 'Otro',
              onTap: () {
                controller.isActivoGenero.value = true;
                controller.selectedGender.value = 'Otro';
              },
              genero: 'Otro',
              icon:
                  'assets/icons/icono_seleccion_genero_161x161_2025_sn_activo.png',
            ),
            // const SizedBox(height: 10)
          ],
        ),
        onOptionSelected: (gender) {
          controller.isActivoGenero.value = true;
          controller.selectedGender.value = gender;
        },
        selectedOption: controller.selectedGender.value,
        onNext: controller.isGenderSelected() ? controller.nextStep : null,
      ),
    ),
  );
}
