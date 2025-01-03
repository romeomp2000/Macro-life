import 'dart:io';

import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/configuraciones/controller.dart';
import 'package:macrolife/screen/detalles_personales/screen.dart';
import 'package:macrolife/screen/referidos/screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfiguracionesScreen extends StatelessWidget {
  const ConfiguracionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UsuarioController controllerUsuario = Get.find();
    final controller = Get.put(ConfiguracionesScreController());

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Configuración',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CupertinoListTile(
              padding: EdgeInsets.zero,
              title: const Text('Edad'),
              trailing: Text(
                '${controllerUsuario.usuario.value.edad}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            CupertinoListTile(
              padding: EdgeInsets.zero,
              title: const Text('Altura'),
              trailing: Text(
                '${controllerUsuario.usuario.value.altura} cm',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            CupertinoListTile(
              padding: EdgeInsets.zero,
              title: const Text('Peso actual'),
              trailing: Text(
                '${controllerUsuario.usuario.value.pesoActual} Kg',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.5, color: Colors.black12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Color(0xFFE69938),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Saldo actual',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${controllerUsuario.usuario.value.balance}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      // Acción al presionar el botón
                      Get.to(() => ReferidosScreen());
                    },
                    child: const Center(
                      child: Text(
                        'Recomienda amigos para ganar \$',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
            ),
            const SizedBox(height: 15),
            const Text(
              'Personalización',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 15),
            CupertinoListTile(
              onTap: () {
                Get.to(() => DatallesPersonalesScreen());
              },
              padding: EdgeInsets.zero,
              title: Text('Detalles personales'),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black26,
                size: 20,
              ),
            ),
            const SizedBox(height: 15),
            CupertinoListTile(
              padding: EdgeInsets.zero,
              onTap: () => Get.toNamed('/objetivos'),
              title: const Text('Ajustar objetivos'),
              subtitle:
                  const Text('Calorías, carbohidratos, grasas y proteínas'),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black26,
                size: 20,
              ),
            ),
            // const SizedBox(height: 20),
            // const Divider(
            //   thickness: 0.4,
            //   color: Colors.grey,
            // ),
            // const SizedBox(height: 20),
            // const Text(
            //   'Preferencias',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            // ),
            // const SizedBox(height: 15),
            // CupertinoListTile(
            //   padding: EdgeInsets.zero,
            //   title: const Text('Calorías quemadas'),
            //   subtitle:
            //       const Text('Agregar calorías quemadas a la meta diario'),
            //   trailing: CupertinoSwitch(
            //     value: true,
            //     activeColor: Colors.black,
            //     onChanged: (e) => {},
            //   ),
            // ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'Legal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 15),
            CupertinoListTile(
              onTap: () => launchUrl(
                  Uri.parse('https://macrolife.app/terminos-y-condiciones/'),
                  mode: LaunchMode.externalApplication),
              padding: EdgeInsets.zero,
              title: const Text('Términos y condiciones'),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black26,
                size: 20,
              ),
            ),
            const SizedBox(height: 15),
            CupertinoListTile(
              onTap: () => launchUrl(
                  Uri.parse('https://macrolife.app/aviso-de-privacidad/'),
                  mode: LaunchMode.externalApplication),
              padding: EdgeInsets.zero,
              title: const Text('Aviso de privacidad'),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black26,
                size: 20,
              ),
            ),
            const SizedBox(height: 15),
            CupertinoListTile(
              onTap: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();

                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'soporte@macrolife.com',
                  queryParameters: {
                    'subject': 'Describe tu problema encima de esta línea',
                    'body':
                        'ID de usuario: ${controllerUsuario.usuario.value.sId} Versión: ${packageInfo.version} Enviado desde mi ${Platform.isIOS ? 'iPhone' : 'Android'}'
                  },
                );
                // launchUrl(emailUri);

                Get.bottomSheet(Container(
                  width: Get.width,
                  height: Get.height * 0.7,
                  decoration: BoxDecoration(
                      color: whiteTheme_,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(10),
                  child: formCorreo(),
                ));
              },
              padding: EdgeInsets.zero,
              title: const Text('Correo de soporte'),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black26,
                size: 20,
              ),
            ),
            const SizedBox(height: 15),
            CupertinoListTile(
              onTap: () {
                Get.dialog(
                  CupertinoAlertDialog(
                    title: const Text('Confirmación'),
                    content: const Text(
                        '¿Estás seguro de que deseas eliminar tu cuenta? Esta acción no se puede deshacer.'),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Get.back(); // Cerrar el cuadro de diálogo
                        },
                        isDefaultAction: true,
                        child: const Text('Cancelar'),
                      ),
                      CupertinoDialogAction(
                        onPressed: () async {
                          controllerUsuario.logout();
                        },
                        isDestructiveAction: true,
                        child: const Text('Eliminar'),
                      ),
                    ],
                  ),
                );
              },
              padding: EdgeInsets.zero,
              title: const Text('Eliminar cuenta'),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black26,
                size: 20,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            CupertinoListTile(
              onTap: () {
                Get.dialog(
                  CupertinoAlertDialog(
                    title: const Text('Confirmación'),
                    content: const Text(
                        '¿Estás seguro de que deseas darte de baja del boletín?'),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Get.back(); // Cerrar el cuadro de diálogo
                        },
                        isDefaultAction: true,
                        child: const Text('Cancelar'),
                      ),
                      CupertinoDialogAction(
                        onPressed: () async {
                          await controller.bajaBoletin();
                          Get.back(); // Cerrar el cuadro de diálogo
                          // Get.offAndToNamed('/registro'); // Realizar la acción
                        },
                        isDestructiveAction: true,
                        child: const Text('Eliminar'),
                      ),
                    ],
                  ),
                );
              },
              padding: EdgeInsets.zero,
              title: Text('Dar de baja la cuenta del boletín'),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black26,
                size: 20,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Obx(() => Text('Versión ${controller.appVersion}')),
          ],
        ),
      ),
    );
  }
}

Widget formCorreo() {
  final controller = Get.put(ConfiguracionesScreController());
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextField(
            keyboardType: TextInputType.text,
            controller: controller.nombre,
            onTap: () => {},
            onEditingComplete: () => {},
            decoration: InputDecoration(
              label: Text('Nombre'),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: controller.nombre,
            onTap: () => {},
            onEditingComplete: () => {},
            decoration: InputDecoration(
              label: Text('Correo electrónico'),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: TextField(
            keyboardType: TextInputType.text,
            controller: controller.nombre,
            onTap: () => {},
            onEditingComplete: () => {},
            maxLines: 4,
            decoration: InputDecoration(
              label: Text('Descripción del problema'),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: whiteTheme_,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: blackTheme2_)),
              child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(' Cerrar ')),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: blackTheme2_,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Enviar correo',
                  style: TextStyle(
                      color: whiteTheme_,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
