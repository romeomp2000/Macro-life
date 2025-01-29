import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:skeleton_text/skeleton_text.dart';

class AnimatedFood extends StatelessWidget {
  // Constructor con un solo parámetro
  const AnimatedFood({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimatedFoodController controller =
        Get.put(AnimatedFoodController(), permanent: true);

    return Obx(() {
      if (controller.loading.value == false) {
        return const SizedBox
            .shrink(); // Retorna un widget vacío si no hay imagen
      } else {
        return Container(
          height: 120,
          decoration: BoxDecoration(
            color: whiteTheme_,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => imagenLoader(
                  controller: controller,
                  imagen: controller.imagen.value,
                  progress: controller.progress.value,
                ),
              ),
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox.shrink(),
                      SizedBox(
                        width: Get.width - 175,
                        child: Obx(
                          () => Text(
                            controller.texto.value,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: blackTheme_,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Muestra tres puntos cuando el texto no cabe
                            maxLines: 1, // Limita a una línea
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width / 3.5, child: loaderBard()),
                      SizedBox(
                        width: Get.width - 172,
                        child: Row(
                          spacing: 7,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: Get.width / 6, child: loaderBard()),
                            SizedBox(width: Get.width / 6, child: loaderBard()),
                            SizedBox(width: Get.width / 6, child: loaderBard()),
                          ],
                        ),
                      ),
                      Text(
                        'Te notificaremos cuando esté listo',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: blackThemeText,
                          fontWeight: FontWeight.w300,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Muestra tres puntos cuando el texto no cabe
                        maxLines: 1, // Limita a una línea
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}

// Widget para mostrar la imagen
Widget imagenLoader({
  required AnimatedFoodController controller,
  required XFile? imagen,
  required double progress,
}) {
  if (imagen == null) {
    return const SizedBox.shrink(); // Retorna un widget vacío si no hay imagen
  }

  return Stack(
    alignment: Alignment.center,
    children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
          topLeft: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
        ),
        child: Image.file(
          File(imagen.path),
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      Positioned.fill(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
            topLeft: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.6), // Fondo semitransparente
          ),
        ),
      ),
      CircularPercentIndicator(
        radius: 35.0,
        lineWidth: 5.0,
        percent: progress, // Ajusta el valor de progreso
        center: Text(
          "${(progress * 100).toInt()}%",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        progressColor: Colors.white, // Color del progreso
        backgroundColor: Colors.white12, // Color del fondo del círculo
      ),
    ],
  );
}

Widget loaderBard() {
  return SkeletonAnimation(
    shimmerColor: Colors.white60,
    gradientColor: const Color.fromARGB(0, 238, 229, 229),
    curve: Curves.fastOutSlowIn,
    borderRadius: const BorderRadius.all(Radius.circular(0)),
    shimmerDuration: 1000,
    child: Container(
      // width: Get.width / 2.5,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.1),
      ),
    ),
  );
}

class AnimatedFoodController extends GetxController {
  Rx<XFile?> imagen = Rx<XFile?>(null);
  RxString texto = ''.obs;
  RxDouble progress = 0.0.obs;
  RxBool loading = false.obs;

  List<String> mensajes = [
    "Separando ingredientes...",
    "Buscando en la base de datos de nutrición...",
    "Procesando los datos...",
    "Comprobando la validez de los ingredientes...",
    "Recuperando la información nutricional...",
    "Cargando los resultados...",
    "Finalizando la verificación de valores nutricionales..."
  ];

  int _index = 0; // Índice para controlar los mensajes
  Timer? _timer; // Timer para cambiar el texto

  @override
  void onInit() {
    super.onInit();

    // Ejecutar startProgress cuando loading cambie de false a true
    ever(loading, (bool isLoading) {
      if (isLoading) {
        startProgress();
      } else {
        // poner 100% al progress
        progress.value = 1.0;
      }
    });
  }

  void startProgress() {
    // Reiniciar variables
    progress.value = 0.0;
    _index = 0;
    texto.value = mensajes[_index];

    // Reiniciar el progreso
    Future.delayed(const Duration(milliseconds: 100), _incrementProgress);

    // Reiniciar o iniciar el Timer
    _timer?.cancel(); // Cancelar el timer si ya existe
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      texto.value = mensajes[_index]; // Cambiamos el texto actual
      _index = (_index + 1) %
          mensajes.length; // Incrementamos y reseteamos el índice
    });
  }

  void _incrementProgress() {
    if (progress.value < 0.99) {
      progress.value += 0.01;
      Future.delayed(const Duration(milliseconds: 80), _incrementProgress);
    } else {
      progress.value = 0.99; // Detener en 99%
    }
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancelamos el timer al cerrar el controlador
    super.onClose();
  }
}
