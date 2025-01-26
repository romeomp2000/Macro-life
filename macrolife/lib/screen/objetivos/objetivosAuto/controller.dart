import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

class ObjetivosAutoController extends GetxController {
  final PageController pageController = PageController();
  UsuarioController usuarioController = Get.put(UsuarioController());

  RxBool isNivelActividad = false.obs;
  RxBool isObjetivoPeso = false.obs;

  RxString entrenamiento = ''.obs;
  RxString objetivo = ''.obs;
  RxString pesoDeseadoLabel = 'Mantener peso'.obs;
  RxString pesoDeseadoValue = ''.obs;

  RxInt pesoDeseado = 54.obs;
  RxInt activePage = 0.obs;
  RxInt peso = 70.obs;
  RxInt altura = 150.obs;

  RxDouble rapidoMeta = 0.1.obs;
  RxDouble lastValorRapidoMeta = 0.1.obs;
  RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    altura.value = usuarioController.usuario.value.altura!;
    peso.value = usuarioController.usuario.value.pesoActual!;
  }

  void nextStep() async {
    FocusScope.of(Get.context!).unfocus();

    FuncionesGlobales.vibratePress();

    if (activePage.value < 24) {
      activePage.value++;
      progress.value = activePage.value / 6;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool isEntrenamientoSelected() {
    return entrenamiento.isNotEmpty;
  }

  bool isObjetivoSelected() {
    return objetivo.isNotEmpty;
  }

  void back() {
    FocusScope.of(Get.context!).unfocus();

    if (activePage.value > 1) {
      activePage.value--;
      progress.value = activePage.value / 6;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Get.offAndToNamed('/layout');
      Get.back();
    }
  }

  void ajustarLabelPeso() {
    if (peso.value < pesoDeseado.value) {
      pesoDeseadoLabel.value = 'Subir de peso';
      pesoDeseadoValue.value = '${pesoDeseado.value - peso.value}';
      // labelGraficaDoble.value = 'Gana el doble de peso con Macro Life';

      // mostrarGrafica.value = true;
    }

    if (peso.value == pesoDeseado.value) {
      pesoDeseadoLabel.value = 'Mantener de peso';
      pesoDeseadoValue.value = '';
      // labelGraficaDoble.value = '';
      // mostrarGrafica.value = false;
    }

    if (peso.value > pesoDeseado.value) {
      pesoDeseadoLabel.value = 'Bajar de peso';
      pesoDeseadoValue.value = '${peso.value - pesoDeseado.value}';
      // labelGraficaDoble.value = 'Baja el doble de peso con Macro Life';
      // mostrarGrafica.value = true;
    }
  }

  Future actualizarDatos() async {
    final loadingController = Get.put(LoadingController());

    try {
      Map<String, dynamic> body = {
        "entrenamiento": entrenamiento.value,
        "objetivo": objetivo.value,
        "pesoDeseado": pesoDeseado.value,
        "rapidoMeta": rapidoMeta.value,
        "altura": altura.value,
        "peso": peso.value,
        "idUsuario": usuarioController.usuario.value.sId,
      };

      loadingController.startLoading();
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'registro/objetivos',
        method: Method.POST,
        body: body,
      );

      usuarioController.saveUsuarioFromJson(response['usuario']);
      usuarioController.refresh();

      Get.back();
      Get.back();
      final WeeklyCalendarController controllerCalendar = Get.find();

      controllerCalendar.cargaAlimentos();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    } finally {
      loadingController.stopLoading();
    }
  }
}
