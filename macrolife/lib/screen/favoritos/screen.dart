import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/screen/favoritos/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/nutricion/screen.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritosController());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Image.asset(
                'assets/icons/iconografia_navegacion_120x120_regresar.png'),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Favoritos',
            style: TextStyle(fontWeight: FontWeight.bold, color: blackTheme_),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    'Lista guardados',
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: blackTheme_),
                  ),
                  Obx(() {
                    if (controller.alimentosList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 300),
                            const Text('Para guardar un alimento, presiona el'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.bookmark_border,
                                    color: blackTheme_),
                                const SizedBox(width: 14),
                                const Text(
                                  'botón mientras editas un registro de comida',
                                  style: TextStyle(color: blackTheme_),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          const SizedBox(height: 25),
                          for (var alimento in controller.alimentosList)
                            Column(
                              children: [
                                CupertinoListTile(
                                  padding: EdgeInsets.all(0),
                                  leadingSize: 55,
                                  title: Text('${alimento.name}'),
                                  subtitle: Text('${alimento.time}'),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: CachedNetworkImage(
                                      imageUrl: '${alimento.imageUrl}',
                                      fit: BoxFit.cover,
                                      width: 55,
                                      height: 55,
                                    ),
                                  ),
                                  trailing: Row(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            controller
                                                .favoritoHaciaComida(alimento);
                                          },
                                          iconSize: 15,
                                          icon: Icon(Icons.add),
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            Get.to(() => NutricionScreen(
                                                alimento: alimento));
                                          },
                                          iconSize: 10,
                                          icon: Icon(Icons.edit),
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    controller.favoritoHaciaComida(alimento);
                                  },
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ],
          ),
        ));
  }
}
