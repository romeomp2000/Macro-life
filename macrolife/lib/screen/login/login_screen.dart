import 'package:macrolife/helpers/common.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:macrolife/widgets/custom_text_form_field.dart';
import 'package:macrolife/widgets/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener la instancia del LoginController
    Get.put(LoginController());

    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    // Center(
                    //   child: Image.network(
                    //     'assets/images/logo_fep_256x100_original.png',
                    //     width: 200,
                    //     fit: BoxFit.contain,
                    //   ),
                    // ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInAnimation(
                            delay: 1.3,
                            child: Text(
                              "¡Bienvenido a FEP!",
                              style: Common().titelTheme,
                            ),
                          ),
                          FadeInAnimation(
                            delay: 1.6,
                            child: Text(
                              "Inicia sesión para continuar",
                              style: Common().titelTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: controller
                            .loginFormKey, // Conectar la clave del formulario
                        child: Column(
                          children: [
                            FadeInAnimation(
                              delay: 1.9,
                              child: CustomTextFormField(
                                obsecuretext: false,
                                label: 'Ingresa tu usuario',
                                controller: controller.emailController,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInAnimation(
                              delay: 2.2,
                              child: Obx(
                                () => CustomTextFormField(
                                  obsecuretext: true,
                                  label: 'Ingresa tu contraseña',
                                  controller: controller
                                      .passwordController, // Conectar el controlador
                                  // validator: controller
                                  // .validatorPassword, // Conectar la función de validación
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInAnimation(
                              delay: 2.5,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () => controller
                                      .sendToRecoveyPassword(), // Conectar con la función de recuperación
                                  child: const Text(
                                    "¿Olvidaste tu contraseña?",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInAnimation(
                              delay: 2.8,
                              child: CustomElevatedButton(
                                message: "Login",
                                function: () => controller
                                    .login(), // Conectar con la función de inicio de sesión
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    FadeInAnimation(
                      delay: 2.8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "¿No tienes una cuenta?",
                              style: Common().hinttext,
                            ),
                            TextButton(
                              onPressed: () {
                                controller
                                    .sendToRegister(); // Conectar con la función de registro
                              },
                              child: Text(
                                "Regístrate ahora",
                                style: Common().mediumTheme,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
