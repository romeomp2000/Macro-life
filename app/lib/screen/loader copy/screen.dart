import 'package:fep/screen/loader/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoaderController controller = Get.put(LoaderController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Estamos configurando todo para usted',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Personalizando el plan de salud.',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.loading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return const SizedBox.shrink();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
