import 'package:macrolife/widgets/back_arrow.dart';
import 'package:macrolife/widgets/footer_psd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/models/menu_model.dart';

class MenuPsd extends StatelessWidget {
  final List<MenuModel> menu;
  final String? enlace;
  const MenuPsd({super.key, required this.menu, this.enlace});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final itemWidth = screenWidth / 5; // 4 items per row

    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: screenWidth,
        child: Wrap(
          spacing: 12,
          runSpacing: 20,
          alignment: WrapAlignment.spaceBetween,
          children: menu.asMap().entries.map((entry) {
            final e = entry.value;
            return SizedBox(
              width: itemWidth,
              child: HankButtonMenu(
                title: e.nombre ?? '',
                imagen: e.imagen ?? '',
                enlace: e.enlace ?? '',
                subModulos: e.modulos,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HankButtonMenu extends StatelessWidget {
  final String title;
  final String imagen;
  final String? enlace;
  final List<MenuModel>? subModulos; // Agregar submódulos

  const HankButtonMenu({
    super.key,
    required this.title,
    required this.imagen,
    this.enlace,
    this.subModulos,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (subModulos != null && subModulos!.isNotEmpty) {
          Get.to(
            SubModulosScreen(
              subModulos: subModulos!,
              titulo: title,
            ),
          );
        } else {
          Get.toNamed(enlace!);
        }
      },
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: greenTheme1_,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black12,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/modulos/$imagen',
                    width: 38,
                    height: 38,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 9.5,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class DetalleModuloScreen extends StatelessWidget {
  final String? enlace;

  const DetalleModuloScreen({super.key, required this.enlace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Módulo"),
      ),
      body: Center(
        child: Text("Detalle del módulo con enlace: $enlace"),
      ),
    );
  }
}

class SubModulosScreen extends StatelessWidget {
  final List<MenuModel> subModulos;
  final String titulo;

  const SubModulosScreen({
    super.key,
    required this.subModulos,
    this.titulo = 'Inicio',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BackArrow(text: titulo),
        //quitar el boton de regresar
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MenuPsd(
                menu: subModulos,
              ),
              HankFooter(dark: false), // Footer al final
            ],
          ),
        ),
      ),
    );
  }
}
