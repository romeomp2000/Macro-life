import 'package:carousel_slider/carousel_slider.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/configuraciones/controller.dart';
import 'package:macrolife/screen/detalles_personales/screen.dart';
import 'package:macrolife/screen/referidos/screen.dart';
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
            const SizedBox(height: 20),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
            ),
            GetPlatform.isIOS
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Preferencias',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 15),
                      // CupertinoListTile(
                      //   padding: EdgeInsets.zero,
                      //   title: const Text('Calorías quemadas'),
                      //   subtitle:
                      //       const Text('Agregar calorías quemadas a la meta diario'),
                      //   trailing: CupertinoSwitch(
                      //     value: true,
                      //     activeTrackColor: Colors.black,
                      //     onChanged: (e) => {},
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      CupertinoListTile(
                        padding: EdgeInsets.zero,
                        title: const Text('Actividad en vivo'),
                        subtitle: const Text(
                          'Te muestra las calorías y macros diarias en la pantalla de bloqueo y en la dinámica.',
                          maxLines: 2,
                        ),
                        trailing: Obx(
                          () => CupertinoSwitch(
                            value: controller.actividadLive.value,
                            activeTrackColor: Colors.black,
                            onChanged: (e) => {
                              controller.actividadLive.toggle(),
                              controller.crear(e),
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        thickness: 0.4,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(widgetMenu(),
                                  isScrollControlled: true)
                              .whenComplete(() {
                            controller.currentPageIndex.value = 0;
                          });
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Widgets',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text('¿Cómo agregar?'),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Image.asset(
                                  'assets/icons/imagen_01_mini_tutorial_1060x476_1.png'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                : SizedBox(),

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
                // PackageInfo packageInfo = await PackageInfo.fromPlatform();

                // final Uri emailUri = Uri(
                //   scheme: 'mailto',
                //   path: 'soporte@macrolife.com',
                //   queryParameters: {
                //     'subject': 'Describe tu problema encima de esta línea',
                //     'body':
                //         'ID de usuario: ${controllerUsuario.usuario.value.sId} Versión: ${packageInfo.version} Enviado desde mi ${Platform.isIOS ? 'iPhone' : 'Android'}'
                //   },
                // );
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
            // CupertinoListTile(
            //   onTap: () {
            //     Get.to(() => WidgetsView());
            //   },
            //   padding: EdgeInsets.zero,
            //   title: Text('Preferencias'),
            //   trailing: Icon(
            //     Icons.arrow_forward_ios_outlined,
            //     color: Colors.black26,
            //     size: 20,
            //   ),
            // ),
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
                onPressed: () async {
                  await controller.enviarCorreo();
                },
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

Widget widgetMenu() {
  final controller = Get.put(ConfiguracionesScreController());
  return Container(
    width: Get.width,
    height: Get.height * 0.6,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: whiteTheme_,
    ),
    padding: const EdgeInsets.only(
      left: 10,
      right: 10,
    ),
    child: SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: controller.images.map((e) {
              return Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Image.asset(e),
              );
            }).toList(),
            options: CarouselOptions(
              aspectRatio: 4 / 3,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              autoPlayCurve: Curves.linear,
              enlargeCenterPage: true,
              enlargeFactor: 0,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                controller.currentPageIndex.value = index;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.images.asMap().entries.map((entry) {
              return Obx(() => Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (Theme.of(Get.context!).brightness == Brightness.dark
                                  ? whiteTheme_
                                  : Colors.black)
                              .withOpacity(
                                  controller.currentPageIndex.value == entry.key
                                      ? 0.9
                                      : 0.4),
                    ),
                  ));
            }).toList(),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              'Añadir el widget de descripción general...',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'Siga los pasos anteriores para agregar el widget de descripción general',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.only(
              top: 5,
            ),
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Hecho',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
