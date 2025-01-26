import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:health/health.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/selected_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class FuncionesGlobales {
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static Future<void> getHealthData() async {
    final health = HealthFactory();

    // Solicitar permisos para acceder a los datos de pasos y frecuencia cardíaca
    bool isAuthorized = await health.requestAuthorization([
      HealthDataType.STEPS,
      HealthDataType.HEART_RATE,
    ]);

    if (isAuthorized) {
      // Definir el rango de fechas (por ejemplo, los últimos 7 días)
      DateTime now = DateTime.now();
      DateTime startDate = now.subtract(Duration(days: 7));

      // Obtener datos de pasos durante los últimos 7 días
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          startDate, now, [
        HealthDataType.STEPS
      ] // Puedes agregar más tipos de datos aquí, por ejemplo, HEARTRATE
          );

      // Procesar los datos
      for (HealthDataPoint data in healthData) {
        print(
            "Fecha: ${data.dateFrom}, Tipo: ${data.type}, Valor: ${data.value}");
      }
    } else {
      print("No se otorgaron permisos para acceder a los datos de salud.");
    }
  }

  static void appleHealth() async {
// define the types to get
    List<HealthDataType> types = [
      HealthDataType.STEPS,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.WORKOUT,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.HEART_RATE,
      HealthDataType.WEIGHT,
    ];

// Filter types depending on platform
    if (Platform.isIOS) {
      types = [
        HealthDataType.STEPS,
        HealthDataType.HEART_RATE,
        HealthDataType.WORKOUT,
        HealthDataType.WEIGHT,
        HealthDataType.SLEEP_IN_BED,
      ];
    }

    HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

    // Request authorization for the filtered types
    bool requested = await health.requestAuthorization(types);

    if (requested) {
      var now = DateTime.now();
      try {
        // Fetch health data
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          now.subtract(Duration(days: 1)),
          now,
          types,
        );

        // Process fetched data
        for (var point in healthData) {
          print('${point.type}: ${point.value}');
        }
      } catch (error) {
        print('Error fetching health data: $error');
      }
    } else {
      print('Authorization not granted');
    }
  }

  static void vibratePress() {
    if (Platform.isIOS) {
      HapticFeedback.mediumImpact();
    }
  }

  static void vibratePressLow() {
    if (Platform.isIOS) {
      HapticFeedback.lightImpact();
    }
  }

  static Future<String> getDeviceToken() async {
    try {
      // Request user permission for push notifications (iOS)
      await FirebaseMessaging.instance.requestPermission();

      // Get the FirebaseMessaging instance
      FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;

      // Listen to token refresh events (e.g., after the app is installed or the token changes)

      String? deviceToken = await _firebaseMessage.getToken();

      // If the token is not null, return it, otherwise return an empty string
      return (deviceToken == null) ? '' : deviceToken;
    } catch (e) {
      print("Error getting device token: $e");
      return '';
    }
  }

  static Future<XFile> compressImage(XFile imageFile) async {
    // Lee la imagen como bytes
    final bytes = await imageFile.readAsBytes();

    // Decodifica la imagen a formato Image (del paquete 'image')
    img.Image? image = img.decodeImage(Uint8List.fromList(bytes));

    if (image != null) {
      // Redimensiona la imagen si es necesario (opcional)
      image =
          img.copyResize(image, width: 800); // Ajusta el ancho automáticamente

      // Comprime la imagen en formato JPEG y ajusta la calidad
      final compressedBytes =
          img.encodeJpg(image, quality: 85); // Ajusta la calidad a 85

      // Crea un archivo temporal con la imagen comprimida
      final compressedImageFile = File('${imageFile.path}_compressed.jpg');
      await compressedImageFile.writeAsBytes(compressedBytes);

      // Retorna un nuevo XFile con el archivo comprimido
      return XFile(compressedImageFile.path);
    } else {
      throw Exception('Error al decodificar la imagen');
    }
  }

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

  static String formatedCantidad(int value) {
    String valor = value.toString();
    String result = valor.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (match) => '${match[1]},',
    );
    return result;
  }
}
