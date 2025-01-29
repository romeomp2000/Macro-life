import 'package:flutter/services.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ReferidosScreen extends StatelessWidget {
  const ReferidosScreen({super.key});

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
        title: const Text('Recomienda a tu amigos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Recomienda a tu amigos",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: blackTheme_),
              ),
              SizedBox(height: 16),
              Image.asset('assets/images/imagen_referido_1125x480_.png'),
              SizedBox(height: 16),
              Text(
                "Empoderar a tus amigos",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: blackTheme_),
              ),
              Text(
                "y perder peso juntos",
                style: TextStyle(fontSize: 16, color: blackThemeText),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${controllerUsuario.usuario.value.codigo}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: blackTheme_,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: '${controllerUsuario.usuario.value.codigo}'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Código copiado'),
                            backgroundColor: blackTheme_,
                          ),
                        );
                      },
                      icon: Icon(Icons.copy, color: blackTheme_),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Share.share(
                      '¡Únete a Macro Life! Mi código de referencia es: ${controllerUsuario.usuario.value.codigo} \n https://macrolife.app');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blackTheme_,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Compartir",
                  style: TextStyle(fontSize: 16, color: whiteTheme_),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: Colors.orange),
                        SizedBox(width: 8),
                        Text(
                          "Cómo ganar",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: blackTheme_),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "* Comparte tu código promocional a tus amigos",
                      style: TextStyle(fontSize: 14, color: blackThemeText),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Gana un 5% cada vez que tu amigo adquiera una membresía usando tu código.",
                      style: TextStyle(fontSize: 14, color: blackThemeText),
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
