import 'package:macrolife/config/theme.dart';
import 'package:macrolife/models/list_tile_model.dart';
import 'package:macrolife/widgets/custom_elevated_selected.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarGeneroScreen extends StatelessWidget {
  final String genero;
  const EditarGeneroScreen({
    super.key,
    required this.genero,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditarGeneroController());
    controller.genero.value = genero;

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
                  'Cambiar Genero',
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: blackTheme_),
                ),
                const SizedBox(height: 35),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ...[
                          ListTileModel(title: 'Masculino'),
                          ListTileModel(title: 'Femenino'),
                          ListTileModel(title: 'Otro'),
                        ].map(
                          (option) => Column(
                            children: [
                              Obx(
                                () => CustomElevatedSelected2(
                                  message: option.title ?? '',
                                  icon: option.icon,
                                  widget: option.leading,
                                  subtitle: option.subtitle,
                                  function: () {
                                    controller.genero.value =
                                        option.title ?? '';
                                  },
                                  activo:
                                      controller.genero.value == option.title,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(), // Empuja el contenido anterior hacia arriba
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.actualizarGeneroAlimento();
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

class EditarGeneroController extends GetxController {
  final genero = ''.obs;

  void actualizarGeneroAlimento() async {
    Get.back(result: genero.value);
  }
}
