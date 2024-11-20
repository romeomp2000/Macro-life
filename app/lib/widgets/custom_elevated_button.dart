import 'package:flutter/material.dart';
import 'dart:async';

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
          const EdgeInsets.symmetric(vertical: 20),
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
                  fontFamily: "Urbanist-SemiBold",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
