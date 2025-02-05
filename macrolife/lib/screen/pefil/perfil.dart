import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/detalles_personales/screen.dart';
import 'package:macrolife/screen/peso/screen.dart';
import 'package:macrolife/screen/peso_objetivo/screen.dart';

class PerfilVista extends StatelessWidget {
  const PerfilVista({super.key});

  @override
  Widget build(BuildContext context) {
    final UsuarioController controllerUsuario = Get.find();
    return Container(
      decoration: BoxDecoration(color: backGround),
      height: Get.height,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Perfil',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: blackTheme_,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Peso objetivo',
                            style:
                                TextStyle(fontSize: 16, color: blackThemeText),
                          ),
                          SizedBox(height: 4),
                          Obx(
                            () => Text(
                              '${controllerUsuario.usuario.value.pesoObjetivo} Kg',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: blackTheme_),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => PesoObjetivosScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blackTheme_,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Cambiar meta',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await actualizarNombre(controllerUsuario);
                        },
                        child: Obx(
                          () => buildDetailRow('Nombre',
                              controllerUsuario.usuario.value.nombre ?? ''),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () async {
                          await actualizarTelefono(controllerUsuario);
                        },
                        child: Obx(
                          () => buildDetailRow('Teléfono',
                              controllerUsuario.usuario.value.telefono ?? ''),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () async {
                          await actualizarCorreo(controllerUsuario);
                        },
                        child: Obx(
                          () => buildDetailRow('Correo',
                              controllerUsuario.usuario.value.correo ?? ''),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () => Get.to(() => PesoActualizarScreen()),
                        child: Obx(
                          () => buildDetailRow('Peso actual',
                              '${controllerUsuario.usuario.value.pesoActual} Kg'),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () async {
                          await actualizarAltura(controllerUsuario);
                        },
                        child: Obx(
                          () => buildDetailRow('Altura',
                              '${controllerUsuario.usuario.value.altura} cm'),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () async {
                          await actualizarFechaNacimiento(controllerUsuario);
                        },
                        child: Obx(
                          () => buildDetailRow('Fecha de nacimiento',
                              '${controllerUsuario.usuario.value.fechaNacimientoFormato}'),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () async {
                          await actualizarGenero(controllerUsuario);
                        },
                        child: Obx(
                          () => buildDetailRow('Género',
                              controllerUsuario.usuario.value.genero ?? ''),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
