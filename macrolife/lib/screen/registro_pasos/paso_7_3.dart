import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';
import 'package:video_player/video_player.dart';

Widget paso_7_3(RegistroPasosController controller) {
  return SizedBox(
    child: Obx(() {
      GifController controllerGif = GifController();
      controller.controllerVideo = VideoPlayerController.asset(
        'assets/videos/animacion_barras_test_1125x1214_cols.mp4',
      )
        ..initialize().then((_) {
          controller.controllerVideo.setPlaybackSpeed(0.0000000000001);
        })
        ..setLooping(false)
        ..play();
      return Steep(
        enableScroll: true,
        enablePadding: true,
        isDiet: false,
        isActivo: controller.isGrafica2,
        body: Column(
          spacing: 10,
          children: [
            GifView.asset(
              'assets/gifs/animacion_barras_test_1125x1214_cols.gif',
              // height: Get.height * 0.7,
              width: Get.width - 80,
              loop: false,
              filterQuality: FilterQuality.high,
              frameRate: 25,
              imageRepeat: ImageRepeat.noRepeat,
              fadeDuration: Duration(seconds: 0),
              controller: controllerGif,
              onFrame: (frame) {
                if (frame == 30) {
                  controllerGif.pause();
                  controller.isGrafica2.value = true;
                }
                return;
                // print(frame);
              },
            ),
            // SizedBox(
            //   width: Get.width * 0.65,
            //   height: Get.height * 0.4,
            //   child: VideoPlayer(controller.controllerVideo),
            // ),
            Text(
              'Macro Life lo hace fácil y te hace responsable',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        title: controller.labelGraficaDoble.value,
        options: const [],
        onOptionSelected: (probado) => controller.probado.value = probado,
        selectedOption: controller.probado.value,
        onNext: controller.nextStep,
      );
    }),
  );
}
