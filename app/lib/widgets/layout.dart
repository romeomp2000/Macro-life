import 'package:camera/camera.dart';
import 'package:fep/config/api_service.dart';
import 'package:fep/config/theme.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/screen/analitica/screen.dart';
import 'package:fep/screen/configuraciones/screen.dart';
import 'package:fep/screen/home/controller.dart';
import 'package:fep/screen/home/screen.dart';
import 'package:fep/widgets/BoderCamera.dart';
import 'package:fep/widgets/CustomFloatingActionButtonLocation.dart';
import 'package:fep/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class LayoutScreen extends StatelessWidget {
  final LayoutController controller = Get.put(LayoutController());
  final EscanearAlimentosController escanearController =
      Get.put(EscanearAlimentosController());

  final UsuarioController controllerUsuario = Get.put(UsuarioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return const HomeScreen();
          case 1:
            return AnaliticaScreen();
          case 2:
            return const Center(child: ConfiguracionesScreen());
          default:
            return const Center(child: Text('Home Screen'));
        }
      }),
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          onPressed: () {
            escanearController.onPressPlus();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.network(
              'https://macrolife.app/images/app/home/icono_agregar_180x180_line.png',
              width: 40, // Tamaño fijo para la imagen
              height: 40, // Igual que el ancho
              fit: BoxFit.cover, // Ajusta la imagen dentro del círculo
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
        xOffset: -12, // Mueve el botón 20px hacia la izquierda
        yOffset: 10, // Mantén el eje vertical sin cambios
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            if (index != 3) {
              controller.onItemTapped(index);
            }
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.network(
                  'https://macrolife.app/images/app/home/menu_inferior_195x195_inicio_activo.png',
                  width: 20),
              icon: Image.network(
                  'https://macrolife.app/images/app/home/menu_inferior_195x195_inicio_inactivo.png',
                  width: 20),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.network(
                  'https://macrolife.app/images/app/home/menu_inferior_195x195_analytics_activo.png',
                  width: 20),
              icon: Image.network(
                  'https://macrolife.app/images/app/home/menu_inferior_195x195_analytics_inactivo.png',
                  width: 20),
              label: 'Analítica',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.network(
                  'https://macrolife.app/images/app/home/menu_inferior_195x195_configuracion_activo.png',
                  width: 20),
              icon: Image.network(
                  'https://macrolife.app/images/app/home/menu_inferior_195x195_configuracion_inactivo.png',
                  width: 20),
              label: 'Ajustes',
            ),
            const BottomNavigationBarItem(
              icon: SizedBox.shrink(), // Espacio vacío para el botón de +
              label: '',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class EscanearAlimentosController extends GetxController {
  CameraController? cameraController; // Ahora puede ser null
  RxBool linterna = false.obs;
  late List<CameraDescription> cameras;
  RxBool isCameraInitialized = false.obs;
  RxList<ImageLabel> labels = <ImageLabel>[].obs;
  final UsuarioController usuarioController = Get.put(UsuarioController());

  // Asegurarse de que la cámara se inicialice correctamente
  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        print('No hay cámaras disponibles.');
        return;
      }
      cameraController = CameraController(
          cameras[0], ResolutionPreset.ultraHigh,
          enableAudio: false, fps: 30, imageFormatGroup: ImageFormatGroup.jpeg);
      print('Inicializando la cámara...');
      await cameraController?.initialize();
      print('Cámara inicializada');
      isCameraInitialized.value = true;
    } catch (e) {
      print('Error al inicializar la cámara: $e');
    }
  }

  // Capturar y procesar la imagen
  Future<void> captureAndProcessImage() async {
    try {
      final WeeklyCalendarController cargaMacro = Get.find();

      cargaMacro.loader.value = true;
      final image = await cameraController!.takePicture();
      cameraController!.stopImageStream();
      Get.back();

      DateTime today = DateTime.now();

      final images = [
        ImageData(
          fileKey: 'comida',
          filePath: image.path,
        ),
      ];

      final apiService = ApiService();

      final response = await apiService.uploadImages(
        'analizar-comida',
        images,
        extraFields: {
          'idUsuario': usuarioController.usuario.value.sId ?? '',
          'fecha': today.toUtc().toIso8601String(),
        },
      );

      usuarioController.saveUsuarioFromJson(response['usuario']);

      cargaMacro.refresh();
      cargaMacro.loader.refresh();

      cargaMacro.cargaAlimentos();
    } catch (e) {
      print("Error al capturar o procesar imagen: $e");
    }
  }

// Procesar la imagen con el etiquetador de ML
  Future<void> processImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final imageLabeler = GoogleMlKit.vision.imageLabeler();
    final results = await imageLabeler.processImage(inputImage);

    labels.clear();
    labels.addAll(results);
    imageLabeler.close();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  void ayudaEscanear() {
    Get.bottomSheet(
      isScrollControlled: true,
      Stack(
        children: [
          SafeArea(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                    20), // Redondea la esquina superior izquierda
                topRight:
                    Radius.circular(20), // Redondea la esquina superior derecha
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                height: Get.height - 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Mejor practicas de escaneo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Image.network(
                      'https://macrolife.app/images/app/home/pantalla_proceso_1125x2436_corto.png',
                      width: Get.width,
                      height: 250,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Consejos generales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.grey[50],
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 5, color: Colors.black45),
                                SizedBox(width: 8),
                                Expanded(
                                  // Esto permitirá que el texto se ajuste y se envuelva
                                  child: Text(
                                    'Manténgase los alimentos dentro de las lineas de escaneo.',
                                    softWrap:
                                        true, // Esto asegura que el texto se envuelva
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 5, color: Colors.black45),
                                SizedBox(width: 8),
                                Expanded(
                                  // Esto permitirá que el texto se ajuste y se envuelva
                                  child: Text(
                                    'Mantén tu teléfono fijo para que la imagen no salga borrosa.',
                                    softWrap:
                                        true, // Esto asegura que el texto se envuelva
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 5, color: Colors.black45),
                                SizedBox(width: 8),
                                Expanded(
                                  // Esto permitirá que el texto se ajuste y se envuelva
                                  child: Text(
                                    'No tomes la fotografía desde ángulos oscuros.',
                                    softWrap:
                                        true, // Esto asegura que el texto se envuelva
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: Get.width,
                      child: CustomElevatedButton(
                        message: 'Escanear ahora',
                        function: () => Get.back(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ClipOval(
              child: IconButton(
                icon: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: Image.network(
                      'https://macrolife.app/images/app/home/icono_cancelar_275x275_blanco.png',
                      color: Colors.black26,
                      width: 40,
                    ),
                  ),
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void escanearAlimentos() async {
    Get.back();
    // Esperar la inicialización de la cámara
    await initializeCamera(); // Asegúrate de que se haya completado la inicialización

    if (!isCameraInitialized.value) {
      print("La cámara no se ha inicializado correctamente.");
      return; // Si no se ha inicializado correctamente, salimos del método
    }

    // Mostrar el bottom sheet solo después de que la cámara esté inicializada
    Get.bottomSheet(
      isScrollControlled: true,
      SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            // Cámara ocupa todo el espacio
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                    20), // Redondea la esquina superior izquierda
                topRight:
                    Radius.circular(20), // Redondea la esquina superior derecha
              ),
              child: SizedBox(
                height: Get.height - 60,
                child: cameraController == null
                    ? const SizedBox.shrink()
                    : CameraPreview(cameraController!),
              ),
            ),

            Positioned(
              top: 60,
              left: 0,
              child: IconButton(
                icon: ClipOval(
                  child: Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: Image.network(
                      'https://macrolife.app/images/app/home/icono_cancelar_275x275_blanco.png',
                      width: 40,
                    ),
                  ),
                ),
                onPressed: () => {Get.back(), cameraController?.dispose()},
              ),
            ),

            Positioned(
              top: 60,
              right: 0,
              child: ClipOval(
                child: IconButton(
                  icon: Image.network(
                    'https://macrolife.app/images/app/home/icono_pregunta_275x275_blanco.png',
                    width: 45,
                  ),
                  onPressed: () => ayudaEscanear(),
                ),
              ),
            ),

            // Botón de captura centrado
            Positioned(
              bottom: 16,
              left: Get.width / 2 - 30, // Centrado horizontalmente
              child: IconButton(
                iconSize: 30,
                color: whiteTheme_,
                icon: ClipOval(
                  child: Image.network(
                    'https://macrolife.app/images/app/home/ciculo-camera.png',
                    width: 60,
                  ),
                ),
                onPressed: () {
                  captureAndProcessImage();
                },
              ),
            ),

            Positioned(
              child: BorderCamera(
                width: Get.width - 120,
                height: Get.width - 120,
              ),
            ),

            Positioned(
              bottom: 16,
              left: 20, // Centrado horizontalmente
              child: IconButton(
                icon: ClipOval(
                  child: Obx(
                    () => Image.network(
                      'https://macrolife.app/images/app/home/icono_rayo_circulo_130x130_blanco.png',
                      width: 30,
                      color: linterna.value ? Colors.amber : Colors.white,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                ),
                onPressed: () async {
                  if (linterna.value == true) {
                    linterna.value = false;
                    cameraController?.setFlashMode(FlashMode.torch);
                  } else {
                    linterna.value = true;
                    cameraController?.setFlashMode(FlashMode.off);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(() {
      cameraController?.dispose();
      linterna.value = false;
      isCameraInitialized.value = false;
    });
  }

  void onPressPlus() {
    Get.dialog(
      Dialog(
        elevation: 0,
        alignment: Alignment.bottomCenter,
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: (Get.width / 2) - 50,
                    height: 140,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.network(
                          'https://macrolife.app/images/app/home/icono_cajon_ejercicio_88x88_registrar.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Registrar\nejercicio',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: (Get.width / 2) - 50,
                    height: 140,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.network(
                          'https://macrolife.app/images/app/home/icono_cajon_ejercicio_88x88_alimentos_guardados.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Alimentos\nguardados',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: (Get.width / 2) - 50,
                    height: 140,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.network(
                          'https://macrolife.app/images/app/home/icono_cajon_ejercicio_88x88_buscar_alimentos.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Base de datos de alimentos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: (Get.width / 2) - 50,
                    height: 140,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GestureDetector(
                      onTap: () => {escanearAlimentos()},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.network(
                            'https://macrolife.app/images/app/home/icono_57x57_camara_para_escanear_comida.png',
                            width: 35,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Escanear\nalimentos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}

class LayoutController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LayoutController());
  }
}
