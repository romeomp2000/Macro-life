import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/widgets_home_screen/live_activities_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfiguracionesScreController extends GetxController {
  // Variables reactivas
  var appVersion = ''.obs;
  final WeeklyCalendarController calendarController = Get.find();
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController descripcion = TextEditingController();

  final liveController = Get.put(LiveActivitiesController());
  final usuarioController = Get.put(UsuarioController());

  RxInt currentPageIndex = 0.obs;
  RxBool actividadLive = false.obs;
  GetStorage box = GetStorage();

  List<String> images = [
    'assets/icons/imagen_02_mini_tutorial_1060x476_1.png',
    'assets/icons/imagen_03_minitutorial_1060x476_1.png',
    'assets/icons/imagen_04_mini_tutorial_1060x476_1.png',
  ];

  @override
  void onInit() {
    super.onInit();
    bool? activoLive = box.read('liveActivitiesEnable');
    if (activoLive != null) {
      actividadLive.value = activoLive;
    }

    _loadAppVersion();
  }

  void crear(value) {
    bool? activoLive = box.read('liveActivitiesEnable');
    if (activoLive == null) {
      box.write('liveActivitiesEnable', value);
      // box.save();
    }

    if (value == false) {
      box.remove('liveActivitiesEnable');
      liveController.eliminar();
      return;
    }

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
      await apiService.fetchData(
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
      await apiService.fetchData(
        'soporte/',
        method: Method.POST,
        body: body,
      );
      Get.back();
      Get.snackbar('Correo enviado', '', backgroundColor: whiteTheme_);
      correo.clear();
      nombre.clear();
      descripcion.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
