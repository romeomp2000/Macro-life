import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/models/list_tile_model.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_10(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enableScroll: true,
        isRuler: true,
        isDiet: true,
        isActivo: controller.isDieta,
        title: '¿Sigues una dieta específica?',
        options: [
          ListTileModel(
            check: false,
            title: 'Clásico',
            leading: Image.asset(
              'assets/icons/icono_dietas_alimenticias_outline_60x60_clasico.png',
              height: 25,
            ),
          ),
          ListTileModel(
            check: false,
            title: 'Pescetariano',
            leading: Image.asset(
              'assets/icons/icono_dietas_alimenticias_outline_60x60_pescetario.png',
              height: 25,
            ),
          ),
          ListTileModel(
            check: false,
            title: 'Vegetariano',
            leading: Image.asset(
              'assets/icons/icono_dietas_alimenticias_outline_60x60_vegetariano.png',
              height: 25,
            ),
          ),
          ListTileModel(
            check: false,
            title: 'Vegano',
            leading: Image.asset(
              'assets/icons/icono_dietas_alimenticias_outline_60x60_vegano.png',
              height: 25,
            ),
          ),
          ListTileModel(
            check: false,
            title: 'Otro',
            leading: SizedBox.shrink(),
          ),
        ],
        body: null,
        description: null,
        onOptionSelected: (dieta) {
          controller.isDieta.value = true;
          controller.dieta.value = dieta;
          FuncionesGlobales.vibratePress();
        },
        selectedOption: controller.dieta.value,
        onNext: controller.isDietadoSelected() ? controller.nextStep : null,
      ),
    ),
  );
}
