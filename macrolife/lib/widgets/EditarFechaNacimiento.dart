import 'package:macrolife/widgets/FechaNacimientoPicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditarFechaNacimientoScreen extends StatelessWidget {
  final DateTime fechaNacimiento;
  const EditarFechaNacimientoScreen({
    super.key,
    required this.fechaNacimiento,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditarFechaNacimientoController());
    controller.fechaNacimiento.value = fechaNacimiento;

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
                  'Cambiar Fecha de nacimiento',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 35),
                FechaNacimientoPicker(
                  defaultDia: controller.fechaNacimiento.value.day,
                  defaultAnio: controller.fechaNacimiento.value.year,
                  defaultMes: controller.fechaNacimiento.value.month,
                  onFechaSeleccionada: (value) {
                    controller.fechaNacimiento.value = value;
                  },
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

class EditarFechaNacimientoController extends GetxController {
  Rx<DateTime> fechaNacimiento = DateTime.now().obs;

  void actualizarNombreAlimento() async {
    Get.back(
      result: DateFormat('yyyy-MM-dd').format(fechaNacimiento.value),
    );
  }
}
