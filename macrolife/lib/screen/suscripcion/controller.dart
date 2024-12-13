import 'package:get/get.dart';
import 'package:macrolife/helpers/configuraciones.dart';

class SuscripcionController extends GetxController {
  final configuraiones = Get.put(ConfiguracionesController());

  final sucripcion = 'Mensual'.obs;

  RxString imagenUrl =
      'https://macrolife.app/images/app/home/pantalla_escaneo_alimentos_1125x2436_6.jpg'
          .obs;
}
