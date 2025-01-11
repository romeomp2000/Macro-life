import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/alimento.model.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:get/get.dart';

class NutricionController extends GetxController {
  final Rx<AlimentoModel> alimento = AlimentoModel().obs;

  final reportarComidaController = TextEditingController();
  final WeeklyCalendarController controllerCalendario = Get.find();
  final UsuarioController usuarioController = Get.put(UsuarioController());

  // void actualizarComidaAlimento() async {
  //   final apiService = ApiService();
  //   Get.back();

  //   await apiService.fetchData(
  //     'alimentos/porciones',
  //     method: Method.PUT,
  //     body: {
  //       'id': alimento.value.id,
  //       'porciones': alimento.value.porcion,
  //     },
  //   );

  //   controllerCalendario.cargaAlimentos();
  // }

  void actualizarFavoritoAlimento() async {
    final apiService = ApiService();

    alimento.value.favorito = !(alimento.value.favorito ?? false);
    alimento.refresh();

    await apiService.fetchData(
      'alimentos/favorito',
      method: Method.PUT,
      body: {
        'id': alimento.value.id,
        'favorito': alimento.value.favorito,
      },
    );

    controllerCalendario.cargaAlimentos();
  }

  void deleteAlimento() async {
    final apiService = ApiService();

    Get.back();

    await apiService.fetchData(
      'alimentos/eliminar-alimento/${alimento.value.id}',
      method: Method.DELETE,
    );

    controllerCalendario.cargaAlimentos();
  }

  void reporteAlimento() async {
    final apiService = ApiService();
    Get.back();

    await apiService.fetchData(
      'alimentos/reporte',
      method: Method.POST,
      body: {
        'id': alimento.value.id,
        "idUsuario": usuarioController.usuario.value.sId,
        "reporte": reportarComidaController.text
      },
    );

    final snackBar = SnackBar(
      content: Text(
        'Reporte enviado',
      ),
      duration: Duration(seconds: 2), // Duración del mensaje
      backgroundColor: Colors.black, // Color de fondo
      behavior:
          SnackBarBehavior.fixed, // El SnackBar no se mueve junto al contenido
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  Future editarAlimento() async {
    try {
      Get.back();

      final apiService = ApiService();

      await apiService.fetchData(
        'alimentos/alimento',
        method: Method.PUT,
        body: {
          'id': alimento.value.id,
          'calorias': alimento.value.calories,
          'proteina': alimento.value.protein,
          'carbohidratos': alimento.value.carbs,
          'grasas': alimento.value.fats,
          'porciones': alimento.value.porcion
        },
      );

      // Get.back(result: {
      //   'alimento': alimentoResponse,
      //   'ingrediente': ingredienteResponse,
      // });

      controllerCalendario.cargaAlimentos();
    } catch (e) {
      print(e);
    }
  }
}
