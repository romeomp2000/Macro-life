import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class WidgetController extends GetxController {
  final usuarioController = Get.put(UsuarioController());
  RxInt counter = 0.obs;
  RxInt caloriasRestantes = 0.obs;
  RxDouble caloriasLimite = 0.0.obs;
  RxString title = ''.obs;
  RxString fats = ''.obs;
  RxString carbs = ''.obs;
  RxString protein = ''.obs;
  RxString content = ''.obs;

  RxDouble carbsPercent = 0.0.obs;
  RxDouble fatsPercent = 0.0.obs;
  RxDouble proPercent = 0.0.obs;
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
            usuarioController.macronutrientes.value.caloriasPorcentaje!;

        carbsPercent.value =
            usuarioController.macronutrientes.value.carbohidratosPorcentaje!;
        fatsPercent.value =
            usuarioController.macronutrientes.value.grasasPorcentaje!;
        proPercent.value =
            usuarioController.macronutrientes.value.proteinaPorcentaje!;
      }
    }
    updateHomeWidget(
        title.value,
        carbs.value,
        fats.value,
        protein.value,
        caloriasLimite.value,
        carbsPercent.value,
        proPercent.value,
        fatsPercent.value);

    super.onInit();
  }

  void updateHomeWidget(
      String? cal,
      String? carbs,
      String? fats,
      String? protein,
      double? progress,
      double? progressFats,
      double? progressPro,
      double? progressCarbs) async {
    // print('Hola');
    content.value = 'Calorías\nrestantes';
    title.value = cal ?? '0';
    // double progress = calculateProgress(int.parse(cal ?? '0'), limit);

    String proteinData = protein ?? '0';
    String fatsData = fats ?? '0';
    String carbsData = carbs ?? '0';

    if (int.parse(cal!) < 0) {
      content.value = 'calorías más';
      title.value = int.parse(cal).abs().toString();
    }

    if (int.parse(protein!) < 0) {
      proteinData = '${int.parse(protein).abs().toString()}g más ';
    } else {
      proteinData = '${protein}g';
    }

    if (int.parse(carbs!) < 0) {
      carbsData = '${int.parse(carbs).abs().toString()}g más ';
    } else {
      carbsData = '${carbs}g';
    }

    if (int.parse(fats!) < 0) {
      fatsData = '${int.parse(fats).abs().toString()}g más ';
    } else {
      fatsData = '${fats}g';
    }

    await HomeWidget.saveWidgetData<String>('title', title.value);
    await HomeWidget.saveWidgetData<String>('content', content.value);
    await HomeWidget.saveWidgetData<double>('progress', progress);

    await HomeWidget.saveWidgetData<double>('progressCarbs', progressCarbs);
    await HomeWidget.saveWidgetData<double>('progressProt', progressPro);
    await HomeWidget.saveWidgetData<double>('progressFats', progressFats);

    await HomeWidget.saveWidgetData<String>('protein', proteinData);
    await HomeWidget.saveWidgetData<String>('carbs', carbsData);
    await HomeWidget.saveWidgetData<String>('fats', fatsData);

    await HomeWidget.renderFlutterWidget(
      image('assets/icons/icono_filetecarne_90x69_nuevo_1.png'),
      key: 'proLogo',
      logicalSize: const Size(100, 100),
    );

    await HomeWidget.renderFlutterWidget(
      image('assets/icons/icono_panintegral_amarillo_76x70_nuevo_1.png'),
      key: 'carLogo',
      logicalSize: const Size(100, 100),
    );

    await HomeWidget.renderFlutterWidget(
      image('assets/icons/icono_almedraazul_74x70_nuevo_1.png'),
      key: 'fatLogo',
      logicalSize: const Size(100, 100),
    );

    await HomeWidget.updateWidget(
        name: 'HomeWidgetProvider', iOSName: 'HomeWidget');
  }

  // double calculateProgress(int caloriasRestantes, int caloriasLimite) {
  //   // if (caloriasLimite == 0) return 0.0; // Evitar división por cero

  //   int limite = caloriasRestantes + caloriasLimite;
  //   if (limite == caloriasRestantes) {
  //     return 0.0;
  //   }

  //   double progress = 1 - (caloriasRestantes / limite);

  //   return progress.clamp(0.0, 1.0);
  // }

  Widget image(ruta) {
    return Image.asset(ruta);
  }
}
