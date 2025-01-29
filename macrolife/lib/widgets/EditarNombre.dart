import 'package:macrolife/config/theme.dart';
import 'package:macrolife/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarNombreScreen extends StatelessWidget {
  final String nombre;
  const EditarNombreScreen({
    super.key,
    required this.nombre,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditarNombreController());
    controller.nameController.text = nombre;

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
                  'Cambiar nombre',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 35),
                CustomTextFormField(
                  focus: true,
                  controller: controller.nameController,
                ),
              ],
            ),
            const Spacer(), // Empuja el contenido anterior hacia arriba
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.actualizarNombreAlimento();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blackTheme_,
                  foregroundColor: whiteTheme_,
                  side: const BorderSide(color: blackTheme_, width: 1.5),
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

class EditarNombreController extends GetxController {
  final nameController = TextEditingController();

  void actualizarNombreAlimento() async {
    Get.back(result: nameController.text);
  }
}
