import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:macrolife/helpers/usuario_controller.dart';

class PrincipalController extends GetxController {
  UsuarioController usuarioController = Get.put(UsuarioController());
  final box = GetStorage();

  late VideoPlayerController videoController;
  bool videoInitialized = false;

  @override
  void onInit() {
    super.onInit();
    initVideo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }

  void initVideo() {
    // Configura el video de introducción
    videoController = VideoPlayerController.asset(
        'assets/videos/video_intro_macrolife_2160x4096_original_HD_5_segs.mp4')
      ..initialize().then((_) {
        videoInitialized = true;
        update(); // Actualiza la UI para reflejar que el video está listo
        playVideo(); // Reproduce el video solo cuando está inicializado

        // Configura el temporizador para navegar después de 3 segundos
        Timer(const Duration(seconds: 6), () {
          asegurarUsuario();
        });
      })
      ..setLooping(false); // Solo reproduce una vez
  }

  void playVideo() {
    if (videoInitialized) {
      videoController.play();
    }
  }

  void asegurarUsuario() async {
    try {
      if (usuarioController.usuario.value.sId == null) {
        await Future.delayed(const Duration(milliseconds: 100));
        Get.offNamed('/registro');
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
        Get.offNamed('/layout');
      }
    } catch (e) {
      Get.offNamed('/registro');
    }
  }
}
