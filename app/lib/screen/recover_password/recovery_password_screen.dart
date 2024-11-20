import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:fep/config/theme.dart';
import 'package:fep/screen/recover_password/recovery_password_controller.dart';
import 'package:fep/widgets/footer_psd.dart';

class RecoveryPasswordScreen extends StatelessWidget {
  const RecoveryPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecoveryPasswordController>(builder: ((controller) {
      return Scaffold(
        // backgroundColor: purpleTheme2_,
        appBar: AppBar(
          title: const Text('Recuperar contraseña'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => controller.send.value
                      ? Column(key: UniqueKey(), children: enviada())
                      : Form(
                          key: controller.formKeyRecoveryPassword,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  height: 100.0,
                                  width: 227.0,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              const Center(
                                child: Text(
                                  'Recuperar contraseña',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              const Text(
                                'Escribe tu correo electronico o tu WhatsApp para recuperar tu contraseña',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10.0),
                              AutofillGroup(
                                child: TextFormField(
                                  autofillHints: const [AutofillHints.username],
                                  controller: controller.correo,
                                  autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    labelStyle: TextStyle(color: Colors.black),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingrese su correo electrónico o número de celular';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/icon_chatbot.png',
                                    height: 32,
                                    width: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  const Flexible(
                                    child: Text(
                                      'Nuestro Bot te hará llegar un mensaje de WhatsApp con tu usuario y contraseña',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/icon_email.png',
                                    height: 32,
                                    width: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  const Flexible(
                                    child: Text(
                                      'Busca en tu buzón de entrada, en correos no deseados o Spam tus accesos',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              Obx(
                                () => GestureDetector(
                                  onTap: controller.loading.value
                                      ? null
                                      : () {
                                          if (controller.formKeyRecoveryPassword
                                              .currentState!
                                              .validate()) {
                                            controller.sendRecoveryPassword();
                                          }
                                        },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: blackTheme1_,
                                    ),
                                    child: controller.loading.value
                                        ? const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Cargando...',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CircularProgressIndicator
                                                  .adaptive(),
                                            ],
                                          )
                                        : const Text(
                                            'Enviar',
                                            style:
                                                TextStyle(color: clearTheme5_),
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 100.0),
                              // const HankFooter(
                              //   color3: Colors.white,
                              // ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }

  List<Widget> enviada() {
    return <Widget>[
      Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/icon_check.png',
              width: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              '¡LISTO!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Se ha enviado un mensaje a tu correo electrónico o número de teléfono',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/icon_chatbot.png',
                  width: 32,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/images/icon_email.png',
                  width: 32,
                ),
              ],
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: blackTheme1_,
          ),
          child: const Text(
            'Aceptar',
            style: TextStyle(color: clearTheme5_),
          ),
        ),
      ),
      const SizedBox(height: 20.0),
      HankFooter(
        dark: true,
      ),
    ];
  }
}
