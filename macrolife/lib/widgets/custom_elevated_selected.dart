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
  final bool? check;
  final Widget? trailing;

  const CustomElevatedSelected({
    super.key,
    required this.message,
    required this.function,
    this.activo = true,
    this.icon,
    this.subtitle,
    this.widget,
    this.check,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
          side: WidgetStatePropertyAll(
            BorderSide(
              color: activo! ? Colors.black : Colors.black12,
              width: 1,
            ),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          fixedSize: const WidgetStatePropertyAll(
            Size.fromWidth(370),
          ),
          padding: (icon == null && subtitle == null && widget == null)
              ? const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 17),
                )
              : null,
          backgroundColor: WidgetStatePropertyAll(
              activo! ? Colors.white : Colors.transparent),
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
        child: (icon != null || subtitle != null || widget != null)
            ? Column(
                children: [
                  const SizedBox(height: 25),
                  Row(
                    spacing: 10,
                    children: [
                      icon ??
                          widget ??
                          SizedBox
                              .shrink(), // Esto es el ícono o el widget que defines
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (subtitle != null)
                              Text(
                                subtitle!,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  // fontSize: 12,
                                  // color: activo!
                                  //     ? Colors.white70
                                  //     : Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (activo == true && check == true)
                        Image.asset(
                          'assets/icons/icono_check_genero_115x115_2025_negro.png',
                          width: 40,
                        ),

                      if (trailing != null) trailing!
                    ],
                  ),
                  const SizedBox(height: 25),
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
