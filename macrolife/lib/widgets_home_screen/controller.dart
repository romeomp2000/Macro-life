import 'package:home_widget/home_widget.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class WidgetController extends GetxController {
  final usuarioController = Get.put(UsuarioController());
  RxInt counter = 0.obs;
  RxInt caloriasRestantes = 0.obs;
  RxString title = ''.obs;
  RxString content = ''.obs;

  @override
  void onInit() {
    // caloriasRestantes.value =
    //     usuarioController.macronutrientes.value.caloriasRestantes!;

    // if (usuarioController.macronutrientes.value.caloriasRestantes == null) {
    //   title.value = 'Sin datos';
    // }
    if (usuarioController.usuario.value != null) {
      title.value =
          usuarioController.macronutrientes.value.caloriasRestantes.toString();
    }
    updateHomeWidget(title.value);

    super.onInit();
  }

  void updateHomeWidget(String cal) async {
    content.value = 'Calorías restantes';
    title.value = cal;
    await HomeWidget.saveWidgetData<String>('title', title.value);
    await HomeWidget.saveWidgetData<String>('content', content.value);
    await HomeWidget.updateWidget(
        name: 'HomeWidgetProvider', iOSName: 'HomeWidget');
  }
}
