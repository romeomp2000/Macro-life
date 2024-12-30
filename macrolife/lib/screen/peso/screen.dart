import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class PesoActualizarScreen extends StatelessWidget {
  const PesoActualizarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> pesos = List<int>.generate(341, (i) => 20 + i);

    PesoObjetivoController controller = Get.put(PesoObjetivoController());

    // Obtener el índice inicial correspondiente al peso actual del usuario
    final initialIndex = pesos.indexOf(controller.peso.value);

    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: initialIndex);

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
        title: const Text('Establecer pesos'),
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
                  Obx(
                    () => Text(
                      '${controller.peso.toInt()} kg',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Peso',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ), // Texto en negritas
                                    ),
                                    SizedBox(
                                      height: 180,
                                      child: CupertinoPicker(
                                        itemExtent: 32.0,
                                        scrollController: scrollController,
                                        onSelectedItemChanged: (int index) {
                                          controller.peso.value = pesos[index];
                                        },
                                        children: pesos.map((peso) {
                                          return Center(
                                              child: Text('$peso kg'));
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: Get.width - 20,
            child: ElevatedButton(
              onPressed: () => {controller.guardaPeso()},
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
