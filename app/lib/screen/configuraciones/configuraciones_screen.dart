import 'package:fep/config/theme.dart';
import 'package:fep/helpers/Contadores_controller.dart';
import 'package:fep/helpers/modulos_controller.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/contadores.dart';
import 'package:fep/widgets/footer_psd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fep/widgets/menu_psd.dart';

class ConfiguracionesScreen extends StatelessWidget {
  const ConfiguracionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModulosController modulosController = Get.put(ModulosController());
    final ContadoresController contadoresController =
        Get.put(ContadoresController());

    return Scaffold(
      appBar: AppBar(
        title: const BackArrow(text: 'Regresar'),
        //quitar el boton de regresar
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => MenuPsd(
                  menu: modulosController.modulos.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
