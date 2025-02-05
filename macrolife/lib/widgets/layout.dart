import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/analitica/screen.dart';
import 'package:macrolife/screen/configuraciones/screen.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/screen/home/screen.dart';
import 'package:macrolife/screen/pefil/perfil.dart';
import 'package:macrolife/widgets/AnimatedFood.dart';
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
          case 3:
            return const Center(child: ConfiguracionesScreen());
          case 4:
            return PerfilVista();
          default:
            return const Center(child: Text('Home Screen'));
        }
      }),
      // floatingActionButton: ClipOval(
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       escanearController.onPressPlus();
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: Image.asset(
      //         'assets/icons/icono_agregar_180x180_line.png',
      //         width: 40,
      //         height: 40,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            if (index != 2) {
              controller.onItemTapped(index);
            }
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                  'assets/icons/icono_22x22_menu_principal_home_activo.png',
                  width: 20),
              icon: Image.asset(
                  'assets/icons/icono_22x22_menu_principal_home_inactivo.png',
                  width: 20),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                  'assets/icons/icono_22x22_menu_principal_analisis_activo.png',
                  width: 20),
              icon: Image.asset(
                  'assets/icons/icono_22x22_menu_principal_analisis_inactivo.png',
                  width: 20),
              label: 'Analítica',
            ),
            // const BottomNavigationBarItem(
            //   icon: SizedBox.shrink(), // Espacio vacío para el botón de +
            //   label: '',
            // ),
            BottomNavigationBarItem(
              label: '',
              icon: GestureDetector(
                onTap: () {
                  escanearController.onPressPlus();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: blackTheme_,
                      borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'assets/icons/icono_agregar_180x180_line.png',
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                  'assets/icons/icono_22x22_menu_principal_configuracion_activo.png',
                  width: 20),
              icon: Image.asset(
                  'assets/icons/icono_22x22_menu_principal_configuracion_inactivo.png',
                  width: 20),
              label: 'Ajustes',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                  'assets/icons/icono_22x22_menu_principal_perfil_activo.png',
                  width: 20),
              icon: Image.asset(
                  'assets/icons/icono_22x22_menu_principal_perfil_inactivo.png',
                  width: 20),
              label: 'Perfil',
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
  final AnimatedFoodController controllerAnimatedFood =
      Get.put(AnimatedFoodController(), permanent: false);

  final WeeklyCalendarController cargaMacro =
      Get.put(WeeklyCalendarController(), permanent: false);
  RxDouble widthCamera = 300.0.obs;
  RxDouble heightCamera = 300.0.obs;
  RxBool oscureCamera = false.obs;

  RxInt isSeleccionado = 1.obs;

  // Asegurarse de que la cámara se inicialice correctamente
  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (kDebugMode) {
          print('No hay cámaras disponibles.');
        }
        return;
      }
      cameraController = CameraController(
        cameras.first,
        ResolutionPreset.veryHigh,
        enableAudio: false,
        fps: 120,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await cameraController?.initialize();

      isCameraInitialized.value = true;
    } catch (e) {
      print('Error al inicializar la cámara: $e');
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  Future<void> captureAndProcessImage() async {
    try {
      final barcodeScanner = BarcodeScanner();
      Get.back();
      controllerAnimatedFood.loading.value = true;
      XFile image = await cameraController!.takePicture();
      controllerAnimatedFood.imagen.value = image;
      String? barocde;

      // Captura la imagen
      final imagenCompress = await FuncionesGlobales.compressImage(image);

      // Procesa la imagen para detectar códigos de barras
      final inputImage = InputImage.fromFilePath(imagenCompress.path);

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

      // // Realiza las operaciones habituales con la imagen
      // cameraController!.stopImageStream();

      final images = [
        ImageData(
          fileKey: 'comida',
          filePath: imagenCompress.path,
        ),
      ];

      final apiService = ApiService();
      String fecha = cargaMacro.today.value.toIso8601String();

      final response = await apiService.uploadImages(
        'analizar-comida',
        images,
        extraFields: {
          'idUsuario': usuarioController.usuario.value.sId ?? '',
          'fecha': fecha,
          'barcode': barocde ?? ''
        },
      );

      usuarioController.saveUsuarioFromJson(response['usuario']);
      cargaMacro.cargaAlimentos();

      usuarioController.macronutrientes.refresh();
      usuarioController.usuario.value.macronutrientesDiario?.refresh();

      cargaMacro.refresh();
      // cargaMacro.loader.refresh();

      cargaMacro.cargaAlimentos();
    } catch (e) {
      print("Error al capturar o procesar imagen: $e");
      // cameraController?.dispose();
    } finally {
      cameraController?.dispose();
      cargaMacro.refresh();
      controllerAnimatedFood.loading.value = false;
      controllerAnimatedFood.imagen.value = null;
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

  void ayudaEscanear() {
    Get.bottomSheet(
      isScrollControlled: true,
      Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft:
                  Radius.circular(20), // Redondea la esquina superior izquierda
              topRight:
                  Radius.circular(20), // Redondea la esquina superior derecha
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              height: Get.height - 95,
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
                      width: 380,
                      height: 240,
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
                        function: () => {escanearAlimentos()},
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

  Future<void> abrirGaleria() async {
    try {
      FuncionesGlobales.vibratePress();

      Get.back();

      String? barocde;

      // cargaMacro.loader.value = true;
      // final ImagePicker picker = ImagePicker();

      final XFile? imagen = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        // imageQuality: 50,
        // maxWidth: 800,
        // maxHeight: 800,
      );

      controllerAnimatedFood.loading.value = true;
      controllerAnimatedFood.imagen.value = imagen;

      if (imagen == null) {
        return;
      }

      // cameraController?.stopImageStream();

      // DateTime today = DateTime.now();

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

      String fecha = cargaMacro.today.value.toString();

      final response = await apiService.uploadImages(
        'analizar-comida',
        images,
        extraFields: {
          'idUsuario': usuarioController.usuario.value.sId ?? '',
          'fecha': fecha,
          'barcode': barocde ?? ''
        },
      );

      usuarioController.saveUsuarioFromJson(response['usuario']);
      cargaMacro.cargaAlimentos();

      usuarioController.macronutrientes.refresh();
      usuarioController.usuario.value.macronutrientesDiario?.refresh();

      cargaMacro.refresh();
      // cargaMacro.loader.refresh();

      cargaMacro.cargaAlimentos();
    } catch (e) {
      print("Error al capturar o procesar imagen: $e");
      // mostrarDialogoParaPermiso();
    } finally {
      // cargaMacro.loader.value = false;
      controllerAnimatedFood.loading.value = false;
      controllerAnimatedFood.imagen.value = null;
    }
  }

  void escanearAlimentos() async {
    Get.back();
    Get.back();

    // Esperar la inicialización de la cámara
    await initializeCamera(); // Asegúrate de que se haya completado la inicialización
    Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: false,
      // ignoreSafeArea: false,
      Obx(
        () {
          if (isCameraInitialized.value == false) {
            return SizedBox.shrink();
          }
          return Container(
            margin: EdgeInsets.only(top: 65),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            // height: Get.height,
            // width: Get.width,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: CameraPreview(
                    cameraController!,
                  ),
                ),
                Obx(
                  () => BorderCamera(
                    width: widthCamera.value,
                    height: heightCamera.value - 20,
                    isOscure: oscureCamera.value,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  child: IconButton(
                    icon: ClipOval(
                      child: Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: Image.asset(
                          'assets/icons/icono_cerrarcamara_130x130_nuevo.png',
                          width: 45,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      cameraController?.dispose();
                    },
                  ),
                ),

                Positioned(
                  top: 20,
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
                  bottom: 20,
                  left: Get.width / 2 - 35, // Centrado horizontalmente
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
                  bottom: 25,
                  left: 30,
                  child: Obx(
                    () => IconButton(
                      iconSize: 30,
                      color: whiteTheme_,
                      icon: linterna.value == true
                          ? Icon(Icons.flash_on)
                          : Icon(Icons.flash_off),
                      onPressed: () {
                        if (linterna.value == true) {
                          cameraController?.setFlashMode(FlashMode.off);
                          linterna.value = false;
                        } else {
                          cameraController?.setFlashMode(FlashMode.torch);
                          linterna.value = true;
                        }
                      },
                    ),
                  ),
                ),

                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          FuncionesGlobales.vibratePress();
                          isSeleccionado.value = 1;
                          widthCamera.value = 300;
                          heightCamera.value = 300;
                          oscureCamera.value = false;
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
                          FuncionesGlobales.vibratePress();

                          isSeleccionado.value = 2;
                          widthCamera.value = Get.width * 0.8;
                          heightCamera.value = 150;
                          oscureCamera.value = true;
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
                          FuncionesGlobales.vibratePress();

                          isSeleccionado.value = 3;
                          widthCamera.value = Get.width * 0.65;
                          heightCamera.value = Get.height * 0.55;
                          oscureCamera.value = true;
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
          );
        },
      ),
    ).whenComplete(() {
      isCameraInitialized.value = false;
      Future.delayed(Duration(seconds: 2), () {
        if (isCameraInitialized.value == false) {
          linterna.value = false;
          cameraController?.dispose();
        }
      });
    });
  }

  void onPressPlus() {
    // if (usuarioController.usuario.value.vencidoSup == true) {
    //   Get.toNamed('/suscripcion');
    // } else {
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
                SizedBox(
                  width: (Get.width / 2) - 50,
                  height: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // cols: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Radio del borde
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.toNamed('/ejercicio');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/icons/icono_menu_34x34_brazo.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Registrar ejercicio',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: blackThemeText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: (Get.width / 2) - 50,
                  height: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // cols: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Radio del borde
                      ),
                    ),
                    onPressed: () => {Get.back(), Get.toNamed('favoritos')},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/icons/icono_menu_34x34_guardar.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Alimentos guardados',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: blackThemeText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
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
                SizedBox(
                  width: (Get.width / 2) - 50,
                  height: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // cols: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Radio del borde
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.toNamed('/food_database');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/icons/icono_menu_34x34_inteligencia_artificial.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Describe tu comida',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: blackThemeText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: (Get.width / 2) - 50,
                  height: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      escanearAlimentos();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/icons/icono_menu_34x34_escanear_alimento.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Escanear alimentos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: blackThemeText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
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
    // }
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
