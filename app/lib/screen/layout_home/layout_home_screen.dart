import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/screen/home/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:fep/helpers/drawer_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LayoutHomeScreen extends StatelessWidget {
  const LayoutHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DrawerPSDController drawerController = Get.put(DrawerPSDController());
    final UsuarioController usuarioController = Get.put(UsuarioController());

    return Scaffold(
      key: drawerController.key,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo_fep_256x100_original.png',
              height: 30,
              // width: 100,
            ),
            const SizedBox(width: 10),
            Obx(
              () => Expanded(
                child: Text(
                  usuarioController.usuario.value.sId ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              usuarioController.logout();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.network(
              'https://www.plataforma.fep.mx/images/icons/red/icon_seccion_60x60_01.svg',
              width: 20,
              colorFilter:
                  const ColorFilter.mode(Color(0xFFCC3300), BlendMode.srcIn),
            ),
          ),
          DrawerButton(
            onPressed: () {
              drawerController.key.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: SafeArea(
        child: Drawer(
          width: 280,
          child: ListView(
            children: [
              DrawerHeader(
                child: Stack(
                  children: [
                    Center(
                      heightFactor: 1,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            usuarioController.usuario.value.sId ??
                                'https://via.placeholder.com/150'),
                        radius: 40,
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Text(
                        'Jesús Antonio\nMena de la rosa',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse('whatsapp://send?phone=+522211717341'));
                },
                leading: const Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Color(0xFF25D366),
                ),
                title: const Text(
                  'Soporte por WhatsApp',
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse('mailto:contacto@hank.mx'));
                },
                leading: const Icon(
                  FontAwesomeIcons.envelope,
                  color: Colors.redAccent,
                ),
                title: const Text(
                  'Soporte por Correo',
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(
                    Uri.parse('https://www.facebook.com/Hank-108199197722114'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                leading: const Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blueAccent,
                ),
                title: const Text(
                  'Únete a nuestra página de Facebook',
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://www.instagram.com/posibilidades_software_/'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                leading: const Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.pinkAccent,
                ),
                title: const Text(
                  'Síguenos en Instagram',
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse('https://hank.mx'),
                      mode: LaunchMode.externalApplication);
                },
                leading: const Icon(
                  FontAwesomeIcons.earthAmericas,
                  color: Colors.blueAccent,
                ),
                title: const Text(
                  'Visita nuestro sitio web',
                ),
              ),
            ],
          ),
        ),
      ),
      body: const SafeArea(
        child: HomeScreen(),
      ),
    );
  }
}
