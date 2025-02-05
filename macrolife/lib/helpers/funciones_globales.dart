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

    // print('aqui entro');
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

  Future permisos() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    await messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    await requestNotificationPermissions(settings);
  }

  Future<void> requestNotificationPermissions(
      NotificationSettings settings) async {
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {}
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

  Map<String, String> activityTranslationMap = {
    // Both
    'ARCHERY': 'Tiro con arco',
    'BADMINTON': 'Bádminton',
    'BASEBALL': 'Béisbol',
    'BASKETBALL': 'Baloncesto',
    'BIKING': 'Ciclismo',
    'BOXING': 'Boxeo',
    'CRICKET': 'Cricket',
    'CURLING': 'Curling',
    'ELLIPTICAL': 'Elíptica',
    'FENCING': 'Esgrima',
    'AMERICAN_FOOTBALL': 'Fútbol americano',
    'AUSTRALIAN_FOOTBALL': 'Fútbol australiano',
    'SOCCER': 'Fútbol',
    'GOLF': 'Golf',
    'GYMNASTICS': 'Gimnasia',
    'HANDBALL': 'Balonmano',
    'HIGH_INTENSITY_INTERVAL_TRAINING':
        'Entrenamiento en intervalos de alta intensidad',
    'HIKING': 'Senderismo',
    'HOCKEY': 'Hockey',
    'SKATING': 'Patinaje',
    'JUMP_ROPE': 'Saltar la cuerda',
    'KICKBOXING': 'Kickboxing',
    'MARTIAL_ARTS': 'Artes marciales',
    'PILATES': 'Pilates',
    'RACQUETBALL': 'Raquetbol',
    'ROWING': 'Remo',
    'RUGBY': 'Rugby',
    'RUNNING': 'Correr',
    'SAILING': 'Navegación',
    'CROSS_COUNTRY_SKIING': 'Esquí de fondo',
    'DOWNHILL_SKIING': 'Esquí alpino',
    'SNOWBOARDING': 'Snowboard',
    'SOFTBALL': 'Softbol',
    'SQUASH': 'Squash',
    'STAIR_CLIMBING': 'Subir escaleras',
    'SWIMMING': 'Natación',
    'TABLE_TENNIS': 'Tenis de mesa',
    'TENNIS': 'Tenis',
    'VOLLEYBALL': 'Voleibol',
    'WALKING': 'Caminata',
    'WATER_POLO': 'Polo acuático',
    'YOGA': 'Yoga',

    // iOS only
    'BOWLING': 'Bolos',
    'CROSS_TRAINING': 'Entrenamiento cruzado',
    'TRACK_AND_FIELD': 'Atletismo',
    'DISC_SPORTS': 'Deportes con disco',
    'LACROSSE': 'Lacrosse',
    'PREPARATION_AND_RECOVERY': 'Preparación y recuperación',
    'FLEXIBILITY': 'Flexibilidad',
    'COOLDOWN': 'Enfriamiento',
    'WHEELCHAIR_WALK_PACE': 'Ritmo de caminata en silla de ruedas',
    'WHEELCHAIR_RUN_PACE': 'Ritmo de carrera en silla de ruedas',
    'HAND_CYCLING': 'Ciclismo manual',
    'CORE_TRAINING': 'Entrenamiento de core',
    'FUNCTIONAL_STRENGTH_TRAINING': 'Entrenamiento funcional de fuerza',
    'TRADITIONAL_STRENGTH_TRAINING': 'Entrenamiento de fuerza tradicional',
    'MIXED_CARDIO': 'Cardio mixto',
    'STAIRS': 'Escaleras',
    'STEP_TRAINING': 'Entrenamiento de pasos',
    'FITNESS_GAMING': 'Juegos de fitness',
    'BARRE': 'Barra',
    'CARDIO_DANCE': 'Baile cardio',
    'SOCIAL_DANCE': 'Baile social',
    'MIND_AND_BODY': 'Mente y cuerpo',
    'PICKLEBALL': 'Pickleball',
    'CLIMBING': 'Escalada',
    'EQUESTRIAN_SPORTS': 'Deportes ecuestres',
    'FISHING': 'Pesca',
    'HUNTING': 'Caza',
    'PLAY': 'Juego',
    'SNOW_SPORTS': 'Deportes de nieve',
    'PADDLE_SPORTS': 'Deportes de remo',
    'SURFING_SPORTS': 'Deportes de surf',
    'WATER_FITNESS': 'Fitness acuático',
    'WATER_SPORTS': 'Deportes acuáticos',
    'TAI_CHI': 'Tai Chi',
    'WRESTLING': 'Lucha',

    // Android only
    'AEROBICS': 'Aeróbicos',
    'BIATHLON': 'Biatlón',
    'BIKING_HAND': 'Ciclismo manual',
    'BIKING_MOUNTAIN': 'Ciclismo de montaña',
    'BIKING_ROAD': 'Ciclismo de carretera',
    'BIKING_SPINNING': 'Spinning',
    'BIKING_STATIONARY': 'Ciclismo estacionario',
    'BIKING_UTILITY': 'Ciclismo utilitario',
    'CALISTHENICS': 'Calistenia',
    'CIRCUIT_TRAINING': 'Entrenamiento en circuito',
    'CROSS_FIT': 'CrossFit',
    'DANCING': 'Bailar',
    'DIVING': 'Buceo',
    'ELEVATOR': 'Ascensor',
    'ERGOMETER': 'Ergómetro',
    'ESCALATOR': 'Escalera eléctrica',
    'FRISBEE_DISC': 'Frisbee',
    'GARDENING': 'Jardinería',
    'GUIDED_BREATHING': 'Respiración guiada',
    'HORSEBACK_RIDING': 'Equitación',
    'HOUSEWORK': 'Trabajo doméstico',
    'INTERVAL_TRAINING': 'Entrenamiento en intervalos',
    'IN_VEHICLE': 'En vehículo',
    'ICE_SKATING': 'Patinaje sobre hielo',
    'KAYAKING': 'Kayak',
    'KETTLEBELL_TRAINING': 'Entrenamiento con kettlebell',
    'KICK_SCOOTER': 'Patinete',
    'KITE_SURFING': 'Kitesurf',
    'MEDITATION': 'Meditación',
    'MIXED_MARTIAL_ARTS': 'Artes marciales mixtas',
    'P90X': 'P90X',
    'PARAGLIDING': 'Parapente',
    'POLO': 'Polo',
    'ROCK_CLIMBING': 'Escalada en roca',
    'ROWING_MACHINE': 'Máquina de remo',
    'RUNNING_JOGGING': 'Correr',
    'RUNNING_SAND': 'Correr en arena',
    'RUNNING_TREADMILL': 'Correr en cinta',
    'SCUBA_DIVING': 'Buceo',
    'SKATING_CROSS': 'Patinaje en cross',
    'SKATING_INDOOR': 'Patinaje en interior',
    'SKATING_INLINE': 'Patinaje en línea',
    'SKIING': 'Esquí',
    'SKIING_BACK_COUNTRY': 'Esquí de fondo',
    'SKIING_KITE': 'Esquí con cometa',
    'SKIING_ROLLER': 'Esquí sobre ruedas',
    'SLEDDING': 'Trineo',
    'SNOWMOBILE': 'Motonieve',
    'SNOWSHOEING': 'Raquetas de nieve',
    'STAIR_CLIMBING_MACHINE': 'Máquina de subir escaleras',
    'STANDUP_PADDLEBOARDING': 'Paddleboard',
    'STILL': 'Reposo',
    'STRENGTH_TRAINING': 'Entrenamiento de fuerza',
    'SURFING': 'Surf',
    'SWIMMING_OPEN_WATER': 'Natación en agua abierta',
    'SWIMMING_POOL': 'Natación en piscina',
    'TEAM_SPORTS': 'Deportes en equipo',
    'TILTING': 'Inclinación',
    'VOLLEYBALL_BEACH': 'Voleibol playa',
    'VOLLEYBALL_INDOOR': 'Voleibol sala',
    'WAKEBOARDING': 'Wakeboard',
    'WALKING_FITNESS': 'Caminata fitness',
    'WALKING_NORDIC': 'Caminata nórdica',
    'WALKING_STROLLER': 'Caminata con carrito',
    'WALKING_TREADMILL': 'Caminata en cinta',
    'WEIGHTLIFTING': 'Levantamiento de pesas',
    'WHEELCHAIR': 'Silla de ruedas',
    'WINDSURFING': 'Windsurf',
    'ZUMBA': 'Zumba',

    // Other
    'OTHER': 'Otro'
  };

  String translateActivity(String activityType) {
    return activityTranslationMap[activityType] ?? activityType;
  }
}
