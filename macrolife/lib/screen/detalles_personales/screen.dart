import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/peso/screen.dart';
import 'package:macrolife/screen/peso_objetivo/screen.dart';
import 'package:macrolife/widgets/EditarAltura.dart';
import 'package:macrolife/widgets/EditarCorreo.dart';
import 'package:macrolife/widgets/EditarFechaNacimiento.dart';
import 'package:macrolife/widgets/EditarGenero.dart';
import 'package:macrolife/widgets/EditarNombre.dart';
import 'package:macrolife/widgets/EditarTelefono.dart';
import 'package:intl/intl.dart';

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
                          style: TextStyle(fontSize: 16, color: blackThemeText),
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
    );
  }
}

Future<void> actualizarNombre(UsuarioController controllerUsuario) async {
  final nombreRaname = await Get.to(
    () => EditarNombreScreen(
      nombre: controllerUsuario.usuario.value.nombre ?? '',
    ),
  );

  if (nombreRaname != null && nombreRaname != '') {
    controllerUsuario.usuario.value.nombre = nombreRaname;
    controllerUsuario.usuario.refresh();
    final apiService = ApiService();

    await apiService.fetchData(
      'usuario/nombre',
      method: Method.PUT,
      body: {
        'idUsuario': controllerUsuario.usuario.value.sId,
        'nombre': nombreRaname
      },
    );
  }
}

Future<void> actualizarTelefono(UsuarioController controllerUsuario) async {
  final telefonoRename = await Get.to(
    () => EditarTelefonoScreen(
      telefono: controllerUsuario.usuario.value.telefono ?? '',
    ),
  );

  if (telefonoRename != null && telefonoRename != '') {
    controllerUsuario.usuario.value.telefono = telefonoRename;
    controllerUsuario.usuario.refresh();
    final apiService = ApiService();

    await apiService.fetchData(
      'usuario/telefono',
      method: Method.PUT,
      body: {
        'idUsuario': controllerUsuario.usuario.value.sId,
        'telefono': telefonoRename
      },
    );
  }
}

Future<void> actualizarCorreo(UsuarioController controllerUsuario) async {
  final correoRename = await Get.to(
    () => EditarCorreoScreen(
      correo: controllerUsuario.usuario.value.correo ?? '',
    ),
  );

  if (correoRename != null && correoRename != '') {
    controllerUsuario.usuario.value.correo = correoRename;
    controllerUsuario.usuario.refresh();
    final apiService = ApiService();

    await apiService.fetchData(
      'usuario/correo',
      method: Method.PUT,
      body: {
        'idUsuario': controllerUsuario.usuario.value.sId,
        'correo': correoRename
      },
    );
  }
}

Future<void> actualizarAltura(UsuarioController controllerUsuario) async {
  final alturaRename = await Get.to(
    () => EditarAlturaScreen(
      altura: controllerUsuario.usuario.value.altura ?? 0,
    ),
  );

  if (alturaRename != null && alturaRename != '') {
    controllerUsuario.usuario.value.altura = alturaRename;
    controllerUsuario.usuario.refresh();
    final apiService = ApiService();

    await apiService.fetchData(
      'usuario/altura',
      method: Method.PUT,
      body: {
        'idUsuario': controllerUsuario.usuario.value.sId,
        'altura': alturaRename
      },
    );
  }
}

Future<void> actualizarGenero(UsuarioController controllerUsuario) async {
  final generoRename = await Get.to(
    () => EditarGeneroScreen(
      genero: controllerUsuario.usuario.value.genero ?? '',
    ),
  );

  if (generoRename != null && generoRename != '') {
    controllerUsuario.usuario.value.genero = generoRename;
    controllerUsuario.usuario.refresh();
    final apiService = ApiService();

    await apiService.fetchData(
      'usuario/genero',
      method: Method.PUT,
      body: {
        'idUsuario': controllerUsuario.usuario.value.sId,
        'genero': generoRename
      },
    );
  }
}

Future<void> actualizarFechaNacimiento(
    UsuarioController controllerUsuario) async {
  DateTime fechaNac =
      DateTime.parse(controllerUsuario.usuario.value.fechaNacimiento ?? '');

  final fechaNacimientoRename = await Get.to(
      () => EditarFechaNacimientoScreen(fechaNacimiento: fechaNac));

  if (fechaNacimientoRename != null && fechaNacimientoRename != '') {
    DateTime fechaParse = DateTime.parse(fechaNacimientoRename);

    controllerUsuario.usuario.value.fechaNacimiento =
        fechaParse.toIso8601String();
    controllerUsuario.usuario.value.fechaNacimientoFormato =
        DateFormat('dd/MM/yyyy').format(fechaParse);

    controllerUsuario.usuario.refresh();

    final apiService = ApiService();

    await apiService.fetchData(
      'usuario/nacimiento',
      method: Method.PUT,
      body: {
        'idUsuario': controllerUsuario.usuario.value.sId,
        'fechaNacimiento': fechaNacimientoRename
      },
    );
  }
}

Widget buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: blackThemeText),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: blackTheme_),
            ),
            SizedBox(width: 6),
            Icon(Icons.edit, color: Colors.grey, size: 18),
          ],
        ),
      ],
    ),
  );
}
