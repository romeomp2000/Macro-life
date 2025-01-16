import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/models/list_tile_model.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';

Widget paso_9(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(
      () => Steep(
        enableScroll: true,
        title: '¿Qué le gustaría conseguir?',
        isActivo: controller.isConseguir,
        options: [
          ListTileModel(
            check: false,
            title: 'Comer y vivir más sano',
            // subtitle: '',
            leading: Image.asset(
              'assets/icons/icono_logros_alimenticios_outline_63x63_5.png',
              height: 25,
            ),
          ),
          ListTileModel(
            title: 'Aumentar mi energía y mi estado de ánimo',
            check: false,
            leading: Image.asset(
              'assets/icons/icono_logros_alimenticios_outline_63x63_6.png',
              height: 25,
            ),
          ),
          ListTileModel(
            check: false,
            title: 'Mantener la motivación y la constancia',
            leading: Image.asset(
              'assets/icons/icono_logros_alimenticios_outline_63x63_7.png',
              height: 25,
            ),
          ),
          ListTileModel(
            check: false,
            title: 'Sentirme mejor con mi cuerpo',
            leading: Image.asset(
              'assets/icons/icono_brazo_outline_100x100_activo.png',
              height: 25,
            ),
          ),
        ],
        body: null,
        selectedOptions: controller.lograr.value,
        onOptionSelected: (lograr) {
          if (controller.lograr.value.contains(lograr)) {
            controller.lograr.value.remove(lograr);
          } else {
            controller.lograr.value.add(lograr);
          }
          if (controller.isLograrSelected() == true) {
            controller.isConseguir.value = true;
          } else {
            controller.isConseguir.value = false;
          }
          controller.lograr.refresh();
        },
        onNext: controller.isLograrSelected() ? controller.nextStep : null,
      ),
    ),
  );
}
