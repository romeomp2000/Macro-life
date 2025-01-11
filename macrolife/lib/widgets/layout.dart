import 'package:camera/camera.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/analitica/screen.dart';
import 'package:macrolife/screen/configuraciones/screen.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/screen/home/screen.dart';
import 'package:macrolife/widgets/BoderCamera.dart';
import 'package:macrolife/widgets/CustomFloatingActionButtonLocation.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

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
            child: Image.asset(
              'assets/icons/icono_agregar_180x180_line.png',
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
              activeIcon: Image.asset(
                  'assets/icons/icono_menu_principal_65x65_nuevo_inicio_activo.png',
                  width: 20),
              icon: Image.asset(
                  'assets/icons/icono_menu_principal_65x65_nuevo_inicio.png',
                  width: 20),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                  'assets/icons/icono_menu_principal_65x65_nuevo_analisis_activo.png',
                  width: 20),
              icon: Image.asset(
                  'assets/icons/icono_menu_principal_65x65_nuevo_analisis.png',
                  width: 20),
              label: 'Analítica',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                  'assets/icons/icono_menu_principal_65x65_nuevo_ajustes_activo.png',
                  width: 20),
              icon: Image.asset(
                  'assets/icons/icono_menu_principal_65x65_nuevo_ajustes.png',
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

  RxDouble width = 0.0.obs;
  RxDouble height = 0.0.obs;
  RxInt isSeleccionado = 1.obs;

  // Asegurarse de que la cámara se inicialice correctamente
  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        print('No hay cámaras disponibles.');
        return;
      }
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.ultraHigh,
        enableAudio: false,
        fps: 30,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      print('Inicializando la cámara...');
      await cameraController?.initialize();
      print('Cámara inicializada');
      isCameraInitialized.value = true;
    } catch (e) {
      print('Error al inicializar la cámara: $e');
    }
  }

  // Capturar y procesar la imagen
  // Future<void> captureAndProcessImage() async {
  //   try {
  //     final WeeklyCalendarController cargaMacro = Get.find();

  //     cargaMacro.loader.value = true;
  //     final image = await cameraController!.takePicture();
  //     final imagenCompress = await FuncionesGlobales.compressImage(image);
  //     cameraController!.stopImageStream();
  //     Get.back();

  //     DateTime today = DateTime.now();

  //     final images = [
  //       ImageData(
  //         fileKey: 'comida',
  //         filePath: imagenCompress.path,
  //       ),
  //     ];

  //     final apiService = ApiService();

  //     final response = await apiService.uploadImages(
  //       'analizar-comida/escanear',
  //       images,
  //       extraFields: {
  //         'idUsuario': usuarioController.usuario.value.sId ?? '',
  //         'fecha': today.toUtc().toIso8601String(),
  //       },
  //     );

  //     usuarioController.saveUsuarioFromJson(response['usuario']);
  //     cargaMacro.cargaAlimentos();

  //     usuarioController.macronutrientes.refresh();
  //     usuarioController.usuario.value.macronutrientesDiario?.refresh();

  //     cargaMacro.refresh();
  //     cargaMacro.loader.refresh();

  //     cargaMacro.cargaAlimentos();
  //   } catch (e) {
  //     print("Error al capturar o procesar imagen: $e");
  //   }
  // }

  Future<void> captureAndProcessImage() async {
    try {
      Get.back();
      final image = await cameraController!.takePicture();

      final WeeklyCalendarController cargaMacro = Get.find();
      cargaMacro.loader.value = true;
      String? barocde = null;

      // Captura la imagen
      final imagenCompress = await FuncionesGlobales.compressImage(image);

      // Procesa la imagen para detectar códigos de barras
      final inputImage = InputImage.fromFilePath(imagenCompress.path);
      final barcodeScanner = BarcodeScanner();

      // Detectar códigos de barras en la imagen
      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      // Verifica si se detectó algún código de barras
      if (barcodes.isNotEmpty) {
        for (final barcode in barcodes) {
          barocde = barcode.displayValue;
        }
      } else {
        barocde = null;
      }

      // Cierra el escáner de códigos de barras
      barcodeScanner.close();

      // Realiza las operaciones habituales con la imagen
      cameraController!.stopImageStream();

      DateTime today = DateTime.now();

      final images = [
        ImageData(
          fileKey: 'comida',
          filePath: imagenCompress.path,
        ),
      ];

      final apiService = ApiService();

      final response = await apiService.uploadImages(
        'analizar-comida',
        images,
        extraFields: {
          'idUsuario': usuarioController.usuario.value.sId ?? '',
          'fecha': today.toUtc().toIso8601String(),
          'barcode': barocde ?? ''
        },
      );

      usuarioController.saveUsuarioFromJson(response['usuario']);
      cargaMacro.cargaAlimentos();

      usuarioController.macronutrientes.refresh();
      usuarioController.usuario.value.macronutrientesDiario?.refresh();

      cargaMacro.refresh();
      cargaMacro.loader.refresh();

      cargaMacro.cargaAlimentos();
      cameraController?.dispose();
    } catch (e) {
      print("Error al capturar o procesar imagen: $e");
      cameraController?.dispose();
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
    // cameraController?.dispose();
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
                child: SingleChildScrollView(
                  // Envuelve el Column en un SingleChildScrollView
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Mejores practicas de escaneo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      Image.asset(
                        'assets/icons/pantalla_proceso_1125x2436_corto.png',
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
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
                                    child: Text(
                                      'Manténgase los alimentos dentro de las lineas de escaneo.',
                                      softWrap: true,
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
                                    child: Text(
                                      'Mantén tu teléfono fijo para que la imagen no salga borrosa.',
                                      softWrap: true,
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
                                    child: Text(
                                      'No tomes la fotografía desde ángulos oscuros.',
                                      softWrap: true,
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
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ClipOval(
              child: IconButton(
                icon: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: Image.asset(
                      'assets/icons/icono_cancelar_275x275_blanco.png',
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

  final ImagePicker _picker = ImagePicker();

  Future<void> abrirGaleria() async {
    try {
      String? barocde = null;

      final WeeklyCalendarController cargaMacro = Get.find();
      cargaMacro.loader.value = true;

      final XFile? imagen =
          await _picker.pickImage(source: ImageSource.gallery);

      if (imagen == null) {
        return print("Ninguna imagen seleccionada");
      }

      cameraController?.stopImageStream();
      Get.back();

      DateTime today = DateTime.now();

      final imagenCompress = await FuncionesGlobales.compressImage(imagen);

      // Procesa la imagen para detectar códigos de barras
      final inputImage = InputImage.fromFilePath(imagenCompress.path);
      final barcodeScanner = BarcodeScanner();

      // Detectar códigos de barras en la imagen
      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      // Verifica si se detectó algún código de barras
      if (barcodes.isNotEmpty) {
        for (final barcode in barcodes) {
          barocde = barcode.displayValue;
        }
      } else {
        barocde = null;
      }

      final images = [
        ImageData(
          fileKey: 'comida',
          filePath: imagenCompress.path,
        ),
      ];

      final apiService = ApiService();

      final response = await apiService.uploadImages(
        'analizar-comida',
        images,
        extraFields: {
          'idUsuario': usuarioController.usuario.value.sId ?? '',
          'fecha': today.toUtc().toIso8601String(),
          'barcode': barocde ?? ''
        },
      );

      usuarioController.saveUsuarioFromJson(response['usuario']);
      cargaMacro.cargaAlimentos();

      usuarioController.macronutrientes.refresh();
      usuarioController.usuario.value.macronutrientesDiario?.refresh();

      cargaMacro.refresh();
      cargaMacro.loader.refresh();

      cargaMacro.cargaAlimentos();
    } catch (e) {
      print("Error al capturar o procesar imagen: $e");
    }
  }

  void escanearAlimentos() async {
    Get.back();
    // Esperar la inicialización de la cámara
    await initializeCamera(); // Asegúrate de que se haya completado la inicialización

    if (!isCameraInitialized.value) {
      // print("La cámara no se ha inicializado correctamente.");
      return; // Si no se ha inicializado correctamente, salimos del método
    }

    width.value = Get.width * 0.75;
    height.value = Get.height * 0.5;
    // Mostrar el bottom sheet solo después de que la cámara esté inicializada
    Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: false,
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ClipRRect(
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: cameraController == null
                  ? const SizedBox.shrink()
                  : CameraPreview(
                      cameraController!,
                    ),
            ),
          ),

          Positioned(
            child: Obx(
              () => BorderCamera(
                width: width.value,
                height: height.value,
              ),
            ),
          ),

          Positioned(
            top: 60,
            left: 0,
            child: IconButton(
              icon: ClipOval(
                child: Container(
                  color: Colors.grey.withOpacity(0.3),
                  child: Image.asset(
                    'assets/icons/icono_cerrarcamara_130x130_nuevo.png',
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
                icon: Image.asset(
                  'assets/icons/icono_pregunta_130x130_nuevo.png',
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
                child: Image.asset(
                  'assets/icons/ciculo-camera.png',
                  width: 60,
                ),
              ),
              onPressed: () {
                captureAndProcessImage();
              },
            ),
          ),

          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // print('escanear comida');
                    isSeleccionado.value = 1;
                    width.value = Get.width * 0.75;
                    height.value = Get.height * 0.5;
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Obx(
                      () => Container(
                        width: 80,
                        height: 70,
                        color: isSeleccionado.value == 1
                            ? Colors.white
                            : Colors.grey.shade300,
                        padding: const EdgeInsets.all(3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/icono_escanear_alimento_60x60_nuevo_scan.png',
                              width: 20,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Escanear comida',
                              style: TextStyle(fontSize: 8),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    isSeleccionado.value = 2;
                    width.value = Get.width * 0.8;
                    height.value = Get.height * 0.3;
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Obx(
                      () => Container(
                        width: 80,
                        height: 70,
                        color: isSeleccionado.value == 2
                            ? Colors.white
                            : Colors.grey.shade300,
                        padding: const EdgeInsets.all(3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/icono_escanear_alimento_60x60_nuevo_barras.png',
                              width: 20,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Código de barras',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 8),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    isSeleccionado.value = 3;
                    width.value = Get.width * 0.6;
                    height.value = Get.height * 0.65;
                    // width.value = Get.width - 160;
                    // height.value = Get.height - 450;
                    // captureAndProcessImage();
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Obx(
                      () => Container(
                        width: 80,
                        height: 70,
                        color: isSeleccionado.value == 3
                            ? Colors.white
                            : Colors.grey.shade300,
                        padding: const EdgeInsets.all(3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/icono_57x57_camara_para_nivel_alimento.png',
                              width: 20,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Etiqueta de alimentos',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 8),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    abrirGaleria();
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: 80,
                      height: 70,
                      color: Colors.grey.shade300,
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icono_escanear_alimento_60x60_nuevo_galeria.png',
                            width: 20,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Galería',
                            style: TextStyle(fontSize: 8),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).whenComplete(() {
      // cameraController?.dispose();
      linterna.value = false;
      isCameraInitialized.value = false;
    }).whenComplete(() {
      Future.delayed(Duration(seconds: 5), () {
        cameraController?.dispose();
      });
    });
  }

  void onPressPlus() {
    if (usuarioController.usuario.value.vencidoSup == false) {
      Get.toNamed('/suscripcion');
    } else {
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
                    onTap: () {
                      Get.back();
                      Get.toNamed('/ejercicio');
                    },
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
                          Image.asset(
                            'assets/icons/icono_menu_secundario_90x90_nuevo_registrar_ejercicio.png',
                            width: 35,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Registrar ejercicio',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {Get.back(), Get.toNamed('favoritos')},
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
                          Image.asset(
                            'assets/icons/icono_menu_secundario_90x90_nuevo_alimentos_guardados.png',
                            width: 35,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Alimentos guardados',
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
                    onTap: () {
                      Get.back();
                      Get.toNamed('/food_database');
                    },
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
                          Image.asset(
                            'assets/icons/icono_inteligencia_artificial_120x120_negro.png',
                            width: 35,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Describe tu comida',
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
                            Image.asset(
                              'assets/icons/icono_menu_secundario_90x90_nuevo_escanear_alimento.png',
                              width: 35,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Escanear alimentos',
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
