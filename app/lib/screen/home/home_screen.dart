import 'package:fep/config/theme.dart';
import 'package:fep/helpers/Contadores_controller.dart';
import 'package:fep/helpers/modulos_controller.dart';
import 'package:fep/widgets/contadores.dart';
import 'package:fep/widgets/footer_psd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fep/widgets/menu_psd.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModulosController modulosController = Get.put(ModulosController());
    final ContadoresController contadoresController =
        Get.put(ContadoresController());

    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: () async {
          await Future.wait([
            contadoresController.obtenerContadores(),
            modulosController.obtenerModulos(),
          ]);
        },
        showChildOpacityTransition: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                width: Get.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenTheme1_,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    // Acción del botón
                  },
                  child: const Text(
                    'Es mi primera factura',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                width: Get.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    // Acción del botón
                  },
                  child: const Text(
                    'Comprar facturas',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Obx(
                () => Contadores(
                  contadores: contadoresController.contadores.value,
                  loading: contadoresController.loading.value,
                ),
              ),
              Obx(
                () => MenuPsd(
                  menu: modulosController.modulos.value,
                ),
              ),
              HankFooter(dark: false), // Footer siempre en la parte inferior
            ],
          ),
        ),
      ),
    );
  }
}
