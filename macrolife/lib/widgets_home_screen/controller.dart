import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class WidgetController extends GetxController {
  final usuarioController = Get.put(UsuarioController());
  RxInt counter = 0.obs;
  RxInt caloriasRestantes = 0.obs;
  RxInt caloriasLimite = 0.obs;
  RxString title = ''.obs;
  RxString fats = ''.obs;
  RxString carbs = ''.obs;
  RxString protein = ''.obs;
  RxString content = ''.obs;

  @override
  void onInit() {
    if (usuarioController.usuario.value.sId != null) {
      title.value =
          usuarioController.macronutrientes.value.caloriasRestantes.toString();
      fats.value =
          usuarioController.macronutrientes.value.grasasRestantes.toString();
      carbs.value = usuarioController
          .macronutrientes.value.carbohidratosRestante
          .toString();
      protein.value =
          usuarioController.macronutrientes.value.proteinaRestantes.toString();

      if (usuarioController.macronutrientes.value.calorias != null) {
        caloriasLimite.value =
            usuarioController.macronutrientes.value.calorias!.toInt();
      }
    }
    updateHomeWidget(title.value, caloriasLimite.value, carbs.value, fats.value,
        protein.value);

    super.onInit();
  }

  void updateHomeWidget(String? cal, int limit, String? carbs, String? fats,
      String? protein) async {
    // content.value = 'Calorías restantes';
    // title.value = cal ?? '0';
    // double progress = calculateProgress(int.parse(cal ?? '0'), limit);

    // if (int.parse(cal!) < 0) {
    //   content.value = 'calorías más';
    //   title.value = int.parse(cal).abs().toString();
    // }

    // await HomeWidget.saveWidgetData<String>('title', title.value);
    // await HomeWidget.saveWidgetData<String>('content', content.value);
    // await HomeWidget.saveWidgetData<double>('progress', progress);

    // await HomeWidget.saveWidgetData<String>('protein', protein ?? '0');
    // await HomeWidget.saveWidgetData<String>('carbs', carbs ?? '0');
    // await HomeWidget.saveWidgetData<String>('fats', fats ?? '0');

    // await HomeWidget.renderFlutterWidget(
    //   image('assets/icons/icono_filetecarne_outline_93x93_activo.png'),
    //   key: 'proLogo',
    //   logicalSize: const Size(100, 100),
    // );
    // await HomeWidget.renderFlutterWidget(
    //   image('assets/icons/icono_panintegral_outline_79x79_activo.png'),
    //   key: 'carLogo',
    //   logicalSize: const Size(100, 100),
    // );
    // await HomeWidget.renderFlutterWidget(
    //   image('assets/icons/icono_almendra_outline_78x78_activo.png'),
    //   key: 'fatLogo',
    //   logicalSize: const Size(100, 100),
    // );

    // await HomeWidget.updateWidget(
    //     name: 'HomeWidgetProvider', iOSName: 'HomeWidget');
  }

  double calculateProgress(int caloriasRestantes, int caloriasLimite) {
    // if (caloriasLimite == 0) return 0.0; // Evitar división por cero

    int limite = caloriasRestantes + caloriasLimite;
    if (limite == caloriasRestantes) {
      return 0.0;
    }

    double progress = 1 - (caloriasRestantes / limite);

    return progress.clamp(0.0, 1.0);
  }

  Widget image(ruta) {
    return Image.asset(ruta);
  }
}
