import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/screen/home/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FuncionesGlobales {
  static Future actualizarMacronutrientes() async {
    try {
      final UsuarioController controllerUsuario = Get.find();

      final apiService = ApiService();

      final response = await apiService.fetchData(
        'macronutrientes',
        method: Method.PUT,
        body: {
          "calorias": controllerUsuario
                  .usuario.value.macronutrientesDiario?.value.calorias ??
              0,
          "carbohidratos": controllerUsuario
                  .usuario.value.macronutrientesDiario?.value.carbohidratos ??
              0,
          "proteina": controllerUsuario
                  .usuario.value.macronutrientesDiario?.value.proteina ??
              0,
          "grasas": controllerUsuario
                  .usuario.value.macronutrientesDiario?.value.grasas ??
              0,
          "idUsuario": controllerUsuario.usuario.value.sId ?? 0,
        },
      );

      controllerUsuario.saveUsuarioFromJson(response['usuario']);
    } catch (e) {
      Get.snackbar(
        'Macronutrientes',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  // static Future getAlimentos(DateTime today) async {
  
  // }

  static Future<List<SelectedModel>> getEstados() async {
    List<SelectedModel> estados = <SelectedModel>[];
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'estados',
        method: Method.GET,
      );

      response.forEach((estado) {
        estados.add(SelectedModel(
          text: estado['text'],
          value: estado['value'],
        ));
      });
    } catch (e) {
      Get.snackbar(
        'Estados',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return estados;
  }

  static Future<List<SelectedModel>> getRegimen(String persona) async {
    List<SelectedModel> regimens = <SelectedModel>[];
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'regimen/obtener',
        method: Method.POST,
        body: {
          'personalidad': persona,
        },
      );

      response.forEach((estado) {
        regimens.add(SelectedModel(
          text: estado['text'],
          value: estado['value'],
        ));
      });
    } catch (e) {
      Get.snackbar(
        'Regimen',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return regimens;
  }

  static Future<List<SelectedModel>> getUso(String persona) async {
    List<SelectedModel> usoCfdis = <SelectedModel>[];
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'usocfdi/obtener',
        method: Method.POST,
        body: {
          'personalidad': persona,
        },
      );

      response.forEach((estado) {
        usoCfdis.add(SelectedModel(
          text: estado['text'],
          value: estado['value'],
        ));
      });
    } catch (e) {
      Get.snackbar(
        'Uso CFDI',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return usoCfdis;
  }

  static Future<List<SelectedModel>> getMetodosPago() async {
    List<SelectedModel> metodosPagos = <SelectedModel>[];
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'metodospagos',
        method: Method.GET,
      );

      response.forEach((estado) {
        metodosPagos.add(SelectedModel(
          text: estado['text'],
          value: estado['value'],
        ));
      });

      // //SELECCIONAR LA PRIMERA
      // if (metodosPagos.isNotEmpty) {
      //   metodoPagoSelected.value = metodosPagos.first;
      // }
    } catch (e) {
      Get.snackbar(
        'Metodos de Pago',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return metodosPagos;
  }

  static Future<List<SelectedModel>> getFormasPago() async {
    List<SelectedModel> formasPagos = <SelectedModel>[];
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'formaspago',
        method: Method.GET,
      );

      response.forEach((estado) {
        formasPagos.add(SelectedModel(
          text: estado['text'],
          value: estado['value'],
        ));
      });

      // //SELECCIONAR LA PRIMERA
      // if (formasPagos.isNotEmpty) {
      //   formaPagoSelected.value = formasPagos.first;
      // }
    } catch (e) {
      Get.snackbar(
        'Formas de Pago',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return formasPagos;
  }

  static Future<List<SelectedModel>> getResidenciasFiscales() async {
    List<SelectedModel> resideniasFiscales = <SelectedModel>[];
    try {
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'paises',
        method: Method.GET,
      );

      response.forEach((estado) {
        resideniasFiscales.add(SelectedModel(
          text: estado['text'],
          value: estado['value'],
        ));
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Residencias Fiscales',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return resideniasFiscales;
  }

  static Future<bool> deleteConfirmacion(String title) async {
    // Mostrar un diálogo de confirmación basado en la plataforma
    bool? confirm = await Get.dialog<bool>(
      GetPlatform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Confirmación'),
              content: Text(title),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Get.back(result: false),
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.black)),
                ),
                CupertinoDialogAction(
                  onPressed: () => Get.back(result: true),
                  isDestructiveAction: true, // Destacar el botón de eliminar
                  child: const Text('Eliminar',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            )
          : AlertDialog(
              title: const Text('Confirmación'),
              content: Text(title),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () => Get.back(result: true),
                  child: const Text('Eliminar',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
    );

    // Si el usuario confirma, proceder con la eliminación

    return confirm ?? false;
  }
}
