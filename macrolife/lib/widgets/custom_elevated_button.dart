import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

class CustomElevatedButton extends StatefulWidget {
  final String message;
  final FutureOr<void> Function()? function;
  const CustomElevatedButton({
    super.key,
    required this.message,
    this.function,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (loading || widget.function == null)
          ? null // Deshabilita el botón si está cargando o no hay función
          : () async {
              setState(() {
                loading = true;
              });

              await widget.function!();

              setState(() {
                loading = false;
              });
            },
      style: ButtonStyle(
        side: WidgetStateProperty.all(
            const BorderSide(color: Colors.transparent)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        fixedSize: WidgetStateProperty.all(const Size.fromWidth(370)),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 17),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey; // Color gris cuando está deshabilitado
          }
          return Colors.black; // Color normal cuando está habilitado
        }),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: loading
          ? const CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
            )
          : FittedBox(
              child: Text(
                widget.message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}

Widget buttonTest(
  String message,
  FutureOr<void> Function()? function,
  bool isActivo,
) {
  final loadingController = Get.put(LoadingController());

  return Container(
    width: Get.width,
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: isActivo ? null : const Color.fromARGB(255, 246, 246, 246),
      gradient: isActivo
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(48, 45, 64, 1),
                Color.fromRGBO(1, 1, 1, 1),
              ],
            )
          : null,
    ),
    child: TextButton(
      onPressed: isActivo ? function : () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => loadingController.isLoading.value
                ? const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  )
                : Text(
                    message,
                    style: TextStyle(
                      color: isActivo
                          ? Colors.white
                          : const Color.fromARGB(255, 193, 193, 193),
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/icons/right-arrow.png',
              width: 26,
              color: isActivo
                  ? Colors.white
                  : const Color.fromARGB(255, 193, 193, 193),
            ),
          )
        ],
      ),
    ),
  );
}

class LoadingController extends GetxController {
  // Inicializa isLoading con false por defecto
  RxBool isLoading = false.obs;

  // Puedes agregar métodos para cambiar el estado de isLoading si es necesario
  void startLoading() {
    isLoading.value = true;
  }

  void stopLoading() {
    isLoading.value = false;
  }
}
