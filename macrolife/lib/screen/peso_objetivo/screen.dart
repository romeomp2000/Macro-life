import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/widgets/Cinta_metrica.dart';
import 'controller.dart';

class PesoObjetivosScreen extends StatelessWidget {
  const PesoObjetivosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PesoObjetivoController controller = Get.put(PesoObjetivoController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/iconografia_navegacion_120x120_regresar.png',
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(' Objetivo de peso'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Peso objetivo',
                    style: TextStyle(fontSize: 20),
                  ),
                  Obx(
                    () => Text(
                      '${controller.pesoObjetivo.toInt()} kg',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 120,
                      width: Get.width,
                      child: Obx(
                        () => CintaMetrica(
                          min: 10,
                          max: 300,
                          step: 1,
                          start: controller.pesoActual.value.toDouble(),
                          value: controller.pesoObjetivo.value.toDouble(),
                          onChanged: (e) {
                            controller.pesoObjetivo.value = e.toInt();
                            FuncionesGlobales.vibratePress();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: Get.width - 20,
            margin: EdgeInsets.only(bottom: GetPlatform.isIOS ? 30 : 0),
            child: ElevatedButton(
              onPressed: () => {controller.guardaObjetivoPeso()},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Hecho'),
            ),
          ),
        ],
      ),
    );
  }
}
