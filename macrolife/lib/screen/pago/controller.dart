import 'package:get/get.dart';
import 'package:macrolife/helpers/configuraciones.dart';

class PagoController extends GetxController {
  final ConfiguracionesController configuraciones =
      Get.put(ConfiguracionesController());

  RxDouble anualPrice = 0.0.obs;
  @override
  void onInit() {
    anualPrice.value =
        configuraciones.configuraciones.value.suscripcion?.anual ?? 0.0;
    super.onInit();
  }
}
