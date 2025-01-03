import 'dart:ffi';

import 'package:home_widget/home_widget.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class WidgetController extends GetxController {
  final usuarioController = Get.put(UsuarioController());
  RxInt counter = 0.obs;
  RxInt caloriasRestantes = 0.obs;
  RxInt caloriasLimite = 0.obs;
  RxString title = ''.obs;
  RxString content = ''.obs;

  @override
  void onInit() {
    if (usuarioController.usuario.value.sId != null) {
      title.value =
          usuarioController.macronutrientes.value.caloriasRestantes.toString();

      if (usuarioController.macronutrientes.value.calorias != null) {
        caloriasLimite.value =
            usuarioController.macronutrientes.value.calorias!.toInt();
      }
    }
    updateHomeWidget(title.value, caloriasLimite.value);

    super.onInit();
  }

  void updateHomeWidget(String? cal, int limit) async {
    content.value = 'Calorías restantes';
    title.value = cal ?? '0';
    double progress = calculateProgress(int.parse(cal ?? '0'), limit);
    await HomeWidget.saveWidgetData<String>('title', title.value);
    await HomeWidget.saveWidgetData<String>('content', content.value);
    await HomeWidget.saveWidgetData<double>('progress', progress);
    await HomeWidget.updateWidget(
        name: 'HomeWidgetProvider', iOSName: 'HomeWidget');
  }

  double calculateProgress(int caloriasRestantes, int caloriasLimite) {
    // if (caloriasLimite == 0) return 0.0; // Evitar división por cero

    int limite = caloriasRestantes + caloriasLimite;
    if (limite == caloriasRestantes) {
      return 0.0;
    }

    double progress = caloriasRestantes / limite;

    return progress.clamp(0.0, 1.0); // Asegurar que esté entre 0.0 y 1.0
  }
}
