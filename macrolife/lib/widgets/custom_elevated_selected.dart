import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

class CustomElevatedSelected extends StatelessWidget {
  final String message;
  final FutureOr<void> Function() function;
  final bool? activo;
  final Icon? icon;
  final Widget? widget;
  final String? subtitle;

  const CustomElevatedSelected({
    super.key,
    required this.message,
    required this.function,
    this.activo = true,
    this.icon,
    this.subtitle,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
          side: WidgetStatePropertyAll(
              BorderSide(color: activo! ? Colors.black : Colors.transparent)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          fixedSize: const WidgetStatePropertyAll(Size.fromWidth(370)),
          padding: (icon == null && subtitle == null && widget == null)
              ? const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 17),
                )
              : null,
          backgroundColor:
              WidgetStatePropertyAll(activo! ? Colors.black : Colors.grey[200]),
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
        child: (icon != null || subtitle != null || widget != null)
            ? Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      icon ??
                          widget!, // Esto es el ícono o el widget que defines
                      const SizedBox(
                          width: 15), // Espaciado entre el ícono y el texto
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    activo! ? Colors.white : Colors.grey[800],
                              ),
                            ),
                            if (subtitle != null)
                              Text(
                                subtitle!,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: activo!
                                      ? Colors.white70
                                      : Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: activo! ? Colors.white : Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: activo! ? Colors.white : Colors.grey[700],
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
