import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/peso/screen.dart';
import 'package:macrolife/screen/peso_objetivo/screen.dart';

class DatallesPersonalesScreen extends StatelessWidget {
  const DatallesPersonalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UsuarioController controllerUsuario = Get.find();

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
        title: const Text('Detalles personales'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Obx(
                          () => Text(
                            '${controllerUsuario.usuario.value.pesoObjetivo} Kg',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => PesoObjetivosScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
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
                      onTap: () {
                        Get.to(() => PesoActualizarScreen());
                      },
                      child: Obx(
                        () => _buildDetailRow('Peso actual',
                            '${controllerUsuario.usuario.value.pesoActual} Kg'),
                      ),
                    ),
                    Divider(),
                    _buildDetailRow('Altura',
                        '${controllerUsuario.usuario.value.altura} cm'),
                    Divider(),
                    _buildDetailRow('Fecha de nacimiento',
                        '${controllerUsuario.usuario.value.fechaNacimientoFormato}'),
                    Divider(),
                    _buildDetailRow(
                        'Género', '${controllerUsuario.usuario.value.genero}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              // SizedBox(width: 8),
              // Icon(Icons.edit, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
