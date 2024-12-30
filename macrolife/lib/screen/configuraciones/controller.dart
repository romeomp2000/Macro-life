import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfiguracionesScreController extends GetxController {
  // Variables reactivas
  var appVersion = ''.obs;

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
}
