import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class SubscriptionController extends GetxController {
  final UsuarioController usuarioController = Get.find();

  void suscribirseUsuario({
    required double total,
    required String producto,
    required String identificador,
    required String metodoPago,
    String? fechaCompra,
  }) async {
    try {
      final apiService = ApiService();

      final respuesta = await apiService.fetchData(
        'suscripcion/usuario',
        method: Method.POST,
        body: {
          "idUsuario": usuarioController.usuario.value.sId,
          "producto": producto,
          'total': total,
          'identificador': identificador,
          'metodoPago': metodoPago,
          'fechaCompra': fechaCompra,
        },
      );
      if (kDebugMode) {
        print(respuesta);
      }
      Get.offNamed('/pago-exitoso');
      // Get.back();
      // Get.back();

      // escanearAlimentoController.ayudaEscanear();
      usuarioController.usuario.value.vencidoSup = false;
      usuarioController.usuario.refresh();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
