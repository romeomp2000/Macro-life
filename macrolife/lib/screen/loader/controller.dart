import 'dart:async';

import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoaderController extends GetxController {
  RxBool loading = true.obs;
  final argumentos = Get.arguments;

  List<String> frases = [
    'Preparando recomendaciones exclusivas para ti...',
    'Analizando tus preferencias para ofrecerte lo mejor...',
    'Cuidando cada detalle de tu bienestar...',
    'Ajustando las opciones para que se adapten a ti...',
    'Creando una experiencia única para tu salud...',
    'Diseñando soluciones hechas a tu medida...',
    'Buscando las mejores alternativas para tu tranquilidad...',
    'Optimizando tu plan para garantizar lo esencial...',
    'Preparando todo para un mejor cuidado de tu salud...'
  ];

  final texto = 'Personalizando tu plan de salud ideal...'.obs;
  final box = GetStorage();
  late Timer _timer;
  int _fraseIndex = 0;
  int _frasesMostradas = 0; // Nuevo contador

  @override
  void onInit() async {
    super.onInit();
    print(argumentos);
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      FuncionesGlobales.vibratePress();
      texto.value = frases[_fraseIndex];
      _fraseIndex = (_fraseIndex + 1) % frases.length;
      _frasesMostradas++;

      if (_frasesMostradas >= frases.length) {
        _timer.cancel();
        _proseguirConRegistro();
      }
    });
  }

  Future<void> _proseguirConRegistro() async {
    try {
      var args = Get.arguments;

      var genero = args["genero"];
      var entrenamiento = args["entrenamiento"];
      var aplicacionSimilar = args["aplicacionSimilar"];
      var altura = args["altura"];
      var peso = args["peso"];
      var fechaNacimiento = args["fechaNacimiento"];
      var objetivo = args["objetivo"];
      var pesoDeseado = args["pesoDeseado"];
      var dieta = args["dieta"];
      var lograr = args["lograr"];
      var metaVelocidad = args["metaVelocidad"];
      var codigo = args["codigo"];
      var appleID = args["appleID"];
      var googleId = args["googleId"];
      var correo = args["correo"];
      var telefono = args["telefono"];
      var nombre = args["nombre"];
      var alarmaDesayuno = args["alarmaDesayuno"];
      var alarmaComida = args["alarmaComida"];
      var alarmaCena = args["alarmaCena"];

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'registro',
        method: Method.POST,
        body: {
          'genero': genero,
          'entrenamiento': entrenamiento,
          'aplicacionSimilar': aplicacionSimilar,
          'altura': altura,
          'peso': peso,
          'fechaNacimiento': fechaNacimiento,
          'objetivo': objetivo,
          'pesoDeseado': pesoDeseado,
          'dieta': dieta,
          'lograr': lograr,
          'metaVelocidad': metaVelocidad,
          // 'metaImpedimento': metaImpedimento||,
          'referidoCodigo': codigo,
          'appleID': appleID,
          'googleId': googleId,
          'correo': correo,
          'telefono': telefono,
          'nombre': nombre,
          'alarmaDesayuno': alarmaDesayuno,
          'alarmaComida': alarmaComida,
          'alarmaCena': alarmaCena
        },
      );

      UsuarioController usuarioController = Get.put(UsuarioController());

      usuarioController.saveUsuarioFromJson(response['usuario']);

      RegistroPasosController registroPasosController = Get.find();
      loading.value = false;

      registroPasosController.nextStep();
      registroPasosController.currentStep++;
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Registro',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void onClose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.onClose();
  }
}
