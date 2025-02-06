import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/pago/billingService.dart';

class PrincipalController extends GetxController {
  UsuarioController usuarioController = Get.put(UsuarioController());
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    asegurarUsuario();
  }

  void asegurarUsuario() async {
    try {
      if (usuarioController.usuario.value.sId == null) {
        await Future.delayed(const Duration(milliseconds: 100));
        Get.offNamed('/registro');
      } else {
        await usuarioController.buscarUsuarioEntrada();
        await Future.delayed(const Duration(milliseconds: 100));
        if (usuarioController.usuario.value.fechaVencimiento == null) {
          if (GetPlatform.isIOS) {
            Get.offNamed('/pago');
          } else {
            Get.offNamed('/pago-vencido');
          }
        } else {
          if (usuarioController.usuario.value.vencidoSup! == false) {
            Get.offNamed('/layout');
          } else {
            if (GetPlatform.isIOS) {
              final InAppPurchaseUtils inAppPurchaseUtils =
                  InAppPurchaseUtils.inAppPurchaseUtilsInstance;
              Get.put<InAppPurchaseUtils>(inAppPurchaseUtils);
              await inAppPurchaseUtils.restorePurchases();
              Get.offNamed('/pago');
              return;
            }
            Get.offNamed('/pago-vencido');
          }
        }
      }
    } catch (e) {
      Get.offNamed('/registro');
    }
  }
}
