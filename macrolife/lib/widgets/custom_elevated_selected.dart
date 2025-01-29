import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';

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
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.01, -0.01),
            blurRadius: 1.5,
          ),
        ],
        color: Colors.white,
      ),
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
          side: WidgetStatePropertyAll(
            BorderSide(
              color: activo! ? Colors.black : Colors.white,
              width: activo! ? 2 : 1.5,
            ),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
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
                      icon ?? widget ?? SizedBox.shrink(),
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

class CustomElevatedSelected2 extends StatelessWidget {
  final String message;
  final FutureOr<void> Function() function;
  final bool? activo;
  final Icon? icon;
  final Widget? widget;
  final String? subtitle;
  final bool? check;
  final Widget? trailing;

  const CustomElevatedSelected2({
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
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.01, -0.01),
            blurRadius: 4.0,
          ),
        ],
        color: whiteTheme_,
      ),
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
          side: WidgetStatePropertyAll(
            BorderSide(
              color: activo! ? blackTheme_ : whiteTheme_,
              width: activo! ? 2 : 1.5,
            ),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
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
                      icon ?? widget ?? SizedBox.shrink(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: blackTheme_),
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
                          color: activo! ? blackTheme_ : blackThemeText,
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
                        color: activo! ? blackTheme_ : blackThemeText,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
