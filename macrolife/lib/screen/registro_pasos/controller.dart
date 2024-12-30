import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/services/auth_service.dart';

class RegistroPasosController extends GetxController {
  final authService = AuthService();
  final UsuarioController usuarioController = Get.find();

  void signWithApple() async {
    try {
      FuncionesGlobales.vibratePress();

      final usuarioAplle = await authService.signWithApple();

      String? correoWithApple = usuarioAplle?.user?.email;
      String? nombreWithApple = usuarioAplle?.user?.displayName;
      String? uuid = usuarioAplle?.user?.uid;
      nextStep();

      // si no proporsiona que lo escriba;
      if (correoWithApple != null) {
        correoController.text = correoWithApple;
        correo.value = correoWithApple;
      }

      if (nombreWithApple != null) {
        nombreController.text = nombreWithApple;
        nombre.value = nombreWithApple;
      }

      if (uuid != null) {
        appleUUID.value = uuid;
      }

      if (uuid != null) {
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'usuario/buscar-auth',
          method: Method.POST,
          body: {
            'googleId': '',
            'appleID': uuid,
          },
        );

        usuarioController.saveUsuarioFromJson(response['usuario']);

        Get.offAndToNamed('/layout');
      }
    } catch (e) {
      print(e);
    }
  }

  void signWithGoogle() async {
    try {
      FuncionesGlobales.vibratePress();

      final usuarioGoogle = await authService.signWithGoogle();

      String? correoWithGoogle = usuarioGoogle?.user?.email;
      String? nombreWithGoogle = usuarioGoogle?.user?.displayName;
      String? uuid = usuarioGoogle?.user?.uid;
      String? phone = usuarioGoogle?.user?.phoneNumber;

      nextStep();

      // si no proporsiona que lo escriba;
      if (correoWithGoogle != null) {
        correoController.text = correoWithGoogle;
        correo.value = correoWithGoogle;
      }

      if (nombreWithGoogle != null) {
        nombreController.text = nombreWithGoogle;
        nombre.value = nombreWithGoogle;
      }

      if (phone != null) {
        telefonoController.text = phone;
        telefono.value = phone;
      }

      if (uuid != null) {
        googleUUID.value = uuid;
      }

      if (uuid != null) {
        final apiService = ApiService();

        final response = await apiService.fetchData(
          'usuario/buscar-auth',
          method: Method.POST,
          body: {
            'googleId': uuid,
            'appleID': '',
          },
        );

        usuarioController.saveUsuarioFromJson(response['usuario']);

        Get.offAndToNamed('/layout');
      }
    } catch (e) {
      print(e);
    }
  }

  var appleUUID = ''.obs;
  var googleUUID = ''.obs;

  var selectedGender = ''.obs;

  var entrenamiento = ''.obs;

  var probado = ''.obs; // has probado otras apps

  var peso = 54.obs;
  var altura = 167.obs;

  var dia = 1.obs;
  var mes = 1.obs;
  var anio = 2024.obs;
  var fechaNacimiento = Rx<DateTime?>(null); // Inicializamos como null

  var pesoDeseado = 54.obs;

  var objetivo = ''.obs;

  var rapidoMeta = 0.1.obs;

  var dieta = ''.obs;

  var lograr = ''.obs;

  var impedimento = ''.obs;

  final nombreController = TextEditingController();
  final nombre = ''.obs;

  final codigoController = TextEditingController();
  var codigo = ''.obs;

  final telefonoController = TextEditingController();
  final telefono = ''.obs;

  final correoController = TextEditingController();
  final correo = ''.obs;

  var progress = 0.1.obs; // Barra de progreso inicial en 10%
  var currentStep = 1.obs; // Paso actual (1 a 10)
  late PageController pageController; // Controlador para PageView

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(); // Inicializa el PageController
  }

  @override
  void onClose() {
    pageController.dispose(); // Libera el PageController
    super.onClose();
  }

  void onRegistrarLoader() {
    FuncionesGlobales.vibratePress();
    Get.toNamed(
      '/loader',
      arguments: {
        "genero": selectedGender.value,
        "entrenamiento": entrenamiento.value, // cuantos días entrena por día
        "aplicacionSimilar": probado.value, // has probado un aplicación similar
        "altura": altura.value,
        "peso": peso.value,
        "fechaNacimiento":
            DateFormat('yyyy-MM-dd').format(fechaNacimiento.value!),
        "objetivo": objetivo.value, // cual es tu objetivo
        "pesoDeseado": pesoDeseado.value, // cual es tu peso deseado
        "dieta": dieta.value, // sigues alguna dieta especifica
        "lograr": lograr.value, // que te gustaría lograr
        "metaVelocidad":
            rapidoMeta.value, // que tán rápido quieres que alcance tu meta
        "metaImpedimento":
            impedimento.value, // qye te impide alcanzar tus metas
        "codigo": codigo.value,
        "appleID": appleUUID.value,
        "googleId": googleUUID.value,
        "correo": correo.value,
        "telefono": telefonoController.text,
        "nombre": nombreController.text,
      },
    );
  }

  bool iaImpedimentoSelected() {
    return impedimento.isNotEmpty;
  }

  // Validación del género seleccionado para habilitar el siguiente paso
  bool isGenderSelected() {
    return selectedGender.isNotEmpty;
  }

  bool isEntrenamientoSelected() {
    return entrenamiento.isNotEmpty;
  }

  bool isProbadoSelected() {
    return probado.isNotEmpty;
  }

  bool isDietadoSelected() {
    return dieta.isNotEmpty;
  }

  bool isLograrSelected() {
    return lograr.isNotEmpty;
  }

  bool isObjetivoSelected() {
    return objetivo.isNotEmpty;
  }

  bool isFechaNacimientoSelected() {
    // Verifica que fechaNacimiento no sea null
    if (fechaNacimiento.value != null) {
      // Obtén el año actual
      int currentYear = DateTime.now().year;

      // Verifica que la fecha seleccionada tenga al menos un año menos que el año actual
      int selectedYear = fechaNacimiento.value!.year;

      // Si el año seleccionado es menor que el año actual y al menos un año menos, devuelve true
      return selectedYear <= currentYear - 1;
    }
    // Si la fechaNacimiento es null, retorna false
    return false;
  }

  // Actualiza el progreso y avanza al siguiente paso
  void nextStep() async {
    FocusScope.of(Get.context!).unfocus();

    FuncionesGlobales.vibratePress();

    if (currentStep.value < 24) {
      currentStep.value++;
      progress.value = currentStep.value /
          24; // Actualiza el progreso en función del paso actual
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      if (currentStep.value == 20) {
        final InAppReview inAppReview = InAppReview.instance;

        await Future.delayed(Duration(seconds: 1));

        if (await inAppReview.isAvailable()) {
          // Solicitar calificación dentro de la app
          inAppReview.requestReview();
        } else {
          // Redirigir a la tienda de aplicaciones
          inAppReview.openStoreListing(
            appStoreId: 'mx.posibilidades.macrolife',
            // microsoftStoreId: 'mx.posibilidades.macrolife',
          );
        }
      }

      if (currentStep.value == 21) {
        FuncionesGlobales.getDeviceToken();
      }
    }
  }

  // Retrocede un paso o vuelve atrás si está en el primer paso
  void back() {
    FocusScope.of(Get.context!).unfocus();

    if (currentStep.value > 1) {
      currentStep.value--;
      progress.value = currentStep.value /
          10; // Actualiza el progreso en función del paso actual
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.back(); // Vuelve a la pantalla anterior si está en el primer paso
    }
  }

  // Reiniciar progreso (opcional, según la lógica de tu app)
  void resetProgress() {
    currentStep.value = 1;
    progress.value = 0.1;
    selectedGender.value = '';
    pageController.jumpToPage(0); // Vuelve al primer paso en el PageView
  }
}
