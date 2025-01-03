import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarAlturaScreen extends StatelessWidget {
  final int altura;
  const EditarAlturaScreen({
    super.key,
    required this.altura,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditarAlturaController());
    final List<int> alturas = List<int>.generate(184, (i) => 60 + i);

    int defaultAlturaIndex = alturas.indexOf(altura);

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Text(
                  'Cambiar Altura',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 35),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Altura",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // Texto en negritas
                    ),
                    SizedBox(
                      height: 300,
                      child: CupertinoPicker(
                        itemExtent: 32.0,
                        scrollController: FixedExtentScrollController(
                            initialItem:
                                defaultAlturaIndex), // Índice correspondiente
                        onSelectedItemChanged: (int index) {
                          // // Llama a la función callback con el valor seleccionado
                          controller.altura.value = alturas[index];
                        },
                        children: alturas.map((altura) {
                          return Center(child: Text('$altura cm'));
                        }).toList(),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.actualizarNombreAlimento();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                ),
                child: const Text(
                  'Actualizar',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditarAlturaController extends GetxController {
  // final nameController = TextEditingController();
  final altura = 0.obs;

  void actualizarNombreAlimento() async {
    Get.back(result: altura.value);
  }
}
