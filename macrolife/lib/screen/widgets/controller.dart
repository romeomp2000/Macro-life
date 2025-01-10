import 'package:get/get.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/widgets_home_screen/live_activities_controller.dart';

class WidgetPreferenciasController extends GetxController {
  final liveController = Get.put(LiveActivitiesController());

  final usuarioController = Get.put(UsuarioController());

  // int carbohidratos = 0;
  // int calorias = 0;
  // int protein = 0;
  // int grasas = 0;

  void crear() {
    int carbohidratos =
        usuarioController.macronutrientes.value.carbohidratosRestante!;
    int calorias = usuarioController.macronutrientes.value.caloriasRestantes!;
    int protein = usuarioController.macronutrientes.value.proteinaRestantes!;
    int grasas = usuarioController.macronutrientes.value.grasasRestantes!;

    int limiteCal = usuarioController.macronutrientes.value.calorias!;
    int limiteCarbs = usuarioController.macronutrientes.value.carbohidratos!;
    int limiteProtein = usuarioController.macronutrientes.value.proteina!;
    int limiteFats = usuarioController.macronutrientes.value.grasas!;

    liveController.createLiveActivities(calorias, carbohidratos, grasas,
        protein, limiteProtein, limiteCal, limiteCarbs, limiteFats);
  }
}
