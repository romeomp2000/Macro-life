import 'package:fep/config/api_service.dart';
import 'package:fep/screen/home/controller.dart';
import 'package:get/get.dart';

class NutricionController extends GetxController {
  final nombre = ''.obs;
  final porcion = 0.0.obs;
  final id = ''.obs;
  final WeeklyCalendarController controllerCalendario = Get.find();

  void actualizarComidaAlimento() async {
    final apiService = ApiService();
    Get.back();

    await apiService.fetchData(
      'alimentos/porciones',
      method: Method.PUT,
      body: {
        'id': id.value,
        'porciones': porcion.value,
      },
    );

    controllerCalendario.cargaAlimentos();
  }
}
