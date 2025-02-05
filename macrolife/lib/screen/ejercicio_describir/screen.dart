import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/models/Entrenamiento.dart';
import 'package:macrolife/screen/ejercicio_describir/controller.dart';
import 'package:macrolife/widgets/custom_text_form_field.dart';

class EjercicioDescribirScreen extends StatelessWidget {
  final Entrenamiento? entrenamiento;
  final String? id;

  const EjercicioDescribirScreen({super.key, this.entrenamiento, this.id});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EjercicioDescribirController());

    if (id != null) {
      controller.id.value = id ?? '';
      controller.describirController.text = entrenamiento?.descripcion ?? '';
    }

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
        title: const Text(
          'Describe tu ejercicio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            CustomTextFormField(
              label: 'Describe le duración del entrenamiento',
              focus: true,
              controller: controller.describirController,
            ),
            const SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: blackTheme_),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/icono_inteligencia_artificial_120x120_negro.png',
                    width: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Creado por IA',
                    style: TextStyle(color: blackTheme_),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Ejemplo:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: blackTheme_),
                  ),
                  SizedBox(width: 8), // Espacio entre el título y el contenido
                  Flexible(
                    child: Text(
                      controller.obtenerActividadAleatoria(),
                      style: TextStyle(color: blackThemeText),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // const Spacer(), // Empuja el contenido anterior hacia arriba
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.registrarEntrenamiento();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blackTheme_,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: blackTheme_, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                ),
                child: Text(
                  id == null ? 'Añadir ejercicio' : 'Actualizar ejercicio',
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
