import 'dart:io';

import 'package:fep/helpers/usuario_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfiguracionesScreen extends StatelessWidget {
  const ConfiguracionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UsuarioController controllerUsuario = Get.find();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://macrolife.app/images/app/home/background_1125x2436_uno.jpg', // URL de tu imagen
          ),
          fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              CupertinoListTile(
                padding: EdgeInsets.zero,
                title: const Text('Altura'),
                trailing: Text(
                  '${controllerUsuario.usuario.value.altura} cm',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              CupertinoListTile(
                padding: EdgeInsets.zero,
                title: const Text('Peso actual'),
                trailing: Text(
                  '${controllerUsuario.usuario.value.pesoActual} Kg',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
              const CupertinoListTile(
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
                    const Text('Calorías, carbohidratos, gras y proteínas'),
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
              const Text(
                'Preferencias',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 15),
              CupertinoListTile(
                padding: EdgeInsets.zero,
                title: const Text('Calorías quemadas'),
                subtitle:
                    const Text('Agregar calorías quemadas a la meta diario'),
                trailing: CupertinoSwitch(
                  value: true,
                  activeColor: Colors.black,
                  onChanged: (e) => {},
                ),
              ),
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
                onTap: () => launchUrl(Uri.parse('https://macrolife.app/'),
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
                onTap: () => launchUrl(Uri.parse('https://macrolife.app/'),
                    mode: LaunchMode.externalApplication),
                padding: EdgeInsets.zero,
                title: const Text('Política de privacidad'),
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
                      'body': '''
ID de usuario: ${controllerUsuario.usuario.value.sId}
Versión: ${packageInfo.version}
Enviado desde mi ${Platform.isIOS ? 'iPhone' : 'Android'}
                      '''
                    },
                  );
                  launchUrl(emailUri);
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
                onTap: () => Get.offAndToNamed('/registro'),
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
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Dar de baja la cuenta'),
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
              const Text('Versión 0.0.1'),
            ],
          ),
        ),
      ),
    );
  }
}
