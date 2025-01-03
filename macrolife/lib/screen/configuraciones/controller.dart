import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfiguracionesScreController extends GetxController {
  // Variables reactivas
  var appVersion = ''.obs;

  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController descripcion = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadAppVersion();
  }

  // Método para cargar la versión de la aplicación
  Future<void> _loadAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appVersion.value =
        packageInfo.version; // Asignar versión a la variable reactiva
  }

  Future bajaBoletin() async {
    try {
      ApiService apiService = ApiService();
      final UsuarioController controllerUsuario = Get.find();
      Map<String, dynamic> body = {
        'usuario': controllerUsuario.usuario.value.sId
      };
      final response = await apiService.fetchData(
        'blog-baja',
        method: Method.POST,
        body: body,
      );

      Get.snackbar('Cuenta eliminada del boletín', '',
          backgroundColor: whiteTheme_);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future enviarCorreo() async {
    try {
      ApiService apiService = ApiService();
      final UsuarioController controllerUsuario = Get.find();
      Map<String, dynamic> body = {
        'usuario': controllerUsuario.usuario.value.sId,
        'correo': correo.text,
        'nombre': nombre.text,
        'descripcion': descripcion.text
      };
      final response = await apiService.fetchData(
        'soporte/enviar-correo',
        method: Method.POST,
        body: body,
      );

      Get.snackbar('Correo enviado', '', backgroundColor: whiteTheme_);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
