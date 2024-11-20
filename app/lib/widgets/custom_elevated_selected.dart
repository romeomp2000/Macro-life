import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

class CustomElevatedSelected extends StatelessWidget {
  final String message;
  final FutureOr<void> Function() function;
  final bool? activo;
  final Icon? icon;
  final String? subtitle;

  const CustomElevatedSelected({
    super.key,
    required this.message,
    required this.function,
    this.activo = true,
    this.icon,
    this.subtitle,
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
          padding: (icon == null && subtitle == null)
              ? const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 17),
                )
              : null,
          backgroundColor:
              WidgetStatePropertyAll(activo! ? Colors.black : Colors.grey[200]),
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
        child: (icon != null || subtitle != null)
            ? ListTile(
                minLeadingWidth: 20,
                leading: icon,
                title: Text(
                  message,
                  style: TextStyle(
                    fontFamily: "Urbanist-SemiBold",
                    fontWeight: FontWeight.bold,
                    color: activo! ? Colors.white : Colors.grey[800],
                  ),
                ),
                subtitle: subtitle != null
                    ? Text(
                        subtitle!,
                        style: TextStyle(
                          fontFamily: "Urbanist-SemiBold",
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: activo! ? Colors.white70 : Colors.grey[600],
                        ),
                      )
                    : null,
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
                          fontFamily: "Urbanist-SemiBold",
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
                        fontFamily: "Urbanist-SemiBold",
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
