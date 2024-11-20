import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fep/config/theme.dart';
import 'package:fep/widgets/footer_psd.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var iconColor = textColor ?? Theme.of(context).textTheme.bodyLarge?.color;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title,
          style: TextStyle(
              color:
                  textColor ?? Theme.of(context).textTheme.bodyLarge?.color)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  size: 16.0, color: Colors.grey))
          : null,
    );
  }
}

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            /// -- IMAGE
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                          'https://media.istockphoto.com/id/1386479313/es/foto/feliz-mujer-de-negocios-afroamericana-millennial-posando-aislada-en-blanco.jpg?s=612x612&w=0&k=20&c=JP0NBxlxG2-bdpTRPlTXBbX13zkNj0mR5g1KoOdbtO4=',
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Jesùs Antonio',
                style: Theme.of(context).textTheme.headlineMedium),
            Text('Mena De la rosa',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),

            /// -- BUTTON
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                label: const Text('Editar Perfil',
                    style: TextStyle(color: whiteTheme_, fontSize: 15.0)),
                onPressed: () => print('Edit Profile'),
                style: ElevatedButton.styleFrom(
                    side: BorderSide.none, shape: const StadiumBorder()),
                icon: const Icon(Icons.edit_note_sharp, color: whiteTheme_),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),

            /// -- MENU
            ProfileMenuWidget(
                title: "Ajustes", icon: Icons.settings, onPress: () {}),
            ProfileMenuWidget(
                title: "Automoviles",
                icon: Icons.car_repair_rounded,
                onPress: () {}),
            ProfileMenuWidget(
                title: "Mascotas", icon: Icons.pets, onPress: () {}),
            const Divider(),
            const SizedBox(height: 10),
            ProfileMenuWidget(title: "Ayuda", icon: Icons.help, onPress: () {}),
            ProfileMenuWidget(
              title: "Cerrar Sesiòn",
              icon: Icons.logout,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                Get.defaultDialog(
                  title: "Cerrar Sesiòn",
                  titleStyle: const TextStyle(fontSize: 20),
                  content: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("¿Estas seguro de cerrar sesiòn?"),
                  ),
                  confirm: Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.offAllNamed('/login'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          side: BorderSide.none),
                      child: const Text("Si"),
                    ),
                  ),
                  cancel: OutlinedButton(
                      onPressed: () => Get.back(), child: const Text("No")),
                );
              },
            ),
            const SizedBox(height: 45),
            HankFooter(dark: false)
          ],
        ),
      ),
    );
  }
}
