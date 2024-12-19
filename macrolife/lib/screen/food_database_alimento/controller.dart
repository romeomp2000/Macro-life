import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/alimento.psd.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:intl/intl.dart';

class FoodDatabaseAlimentoController extends GetxController {
  Rx<AlimentosPSD?>? alimento = Rx<AlimentosPSD?>(null);
  final WeeklyCalendarController controllerCalendario = Get.find();
  final UsuarioController usuarioController = Get.find();
  final reportarComidaController = TextEditingController();

  void reporteAlimento() async {
    // final apiService = ApiService();
    // Get.back();

    // await apiService.fetchData(
    //   'alimentos/reporte',
    //   method: Method.POST,
    //   body: {
    //     'id': alimento.value.id,
    //     "idUsuario": usuarioController.usuario.value.sId,
    //     "reporte": reportarComidaController.text
    //   },
    // );

    // final snackBar = SnackBar(
    //   content: Text(
    //     'Reporte enviado',
    //   ),
    //   duration: Duration(seconds: 2), // Duración del mensaje
    //   backgroundColor: Colors.black, // Color de fondo
    //   behavior:
    //       SnackBarBehavior.fixed, // El SnackBar no se mueve junto al contenido
    // );

    // ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void actualizarComidaAlimento(String id_alimento_psd) async {
    try {
      final apiService = ApiService();
      Get.back();
      Get.back();

      final response = await apiService.fetchData(
        'food-database/nuevo-alimento',
        method: Method.POST,
        body: {
          'idUsuario': usuarioController.usuario.value.sId,
          'idComida': id_alimento_psd,
          'fecha':
              DateFormat('yyyy-MM-dd').format(controllerCalendario.today.value),
        },
      );

      print(response);
      controllerCalendario.cargaAlimentos();
    } catch (e) {
      print(e);
    }
  }
}
