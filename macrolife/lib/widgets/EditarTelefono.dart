import 'package:macrolife/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarTelefonoScreen extends StatelessWidget {
  final String telefono;
  const EditarTelefonoScreen({
    super.key,
    required this.telefono,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditarTelefonoController());
    controller.telefonoController.text = telefono;

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
                  'Cambiar Teléfono',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 35),
                CustomTextFormField(
                  keyboardType: TextInputType.phone,
                  focus: true,
                  controller: controller.telefonoController,
                ),
              ],
            ),
            const Spacer(), // Empuja el contenido anterior hacia arriba
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.telefonoController.text.length == 10
                    ? () {
                        controller.actualizarTelefono();
                      }
                    : null,
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

class EditarTelefonoController extends GetxController {
  final telefonoController = TextEditingController();

  void actualizarTelefono() async {
    Get.back(result: telefonoController.text);
  }
}
