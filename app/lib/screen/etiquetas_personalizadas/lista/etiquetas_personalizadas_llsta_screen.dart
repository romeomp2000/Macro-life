import 'package:fep/models/etiqueta.model.dart';
import 'package:fep/models/list_tile_model.dart';
import 'package:fep/screen/etiquetas_personalizadas/lista/etiquetas_personalizadas_lista_controller.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/list_tile_fep.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class EtiquetasPersonalizadasListaScreen extends StatelessWidget {
  const EtiquetasPersonalizadasListaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BackArrow(text: 'Configuraciones '),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Filtros',
            icon: const Icon(Icons.filter_alt),
            onPressed: () => Get.find<EtiquetasPersonalizadasListaController>()
                .filterChanged(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/etiquetas_personalizadas/nuevo'),
        child: const Icon(Icons.add),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Etiquetas personalizadas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListaSeries(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaSeries extends StatelessWidget {
  const ListaSeries({super.key});

  @override
  Widget build(BuildContext context) {
    final EtiquetasPersonalizadasListaController controller =
        Get.put(EtiquetasPersonalizadasListaController());
    return LiquidPullToRefresh(
      onRefresh: () async => controller.pagingController.refresh(),
      child: PagedListView<int, EtiquetasModel>(
        pagingController: controller.pagingController,
        scrollController: ScrollController(),
        padding: const EdgeInsets.all(0),
        builderDelegate: PagedChildBuilderDelegate<EtiquetasModel>(
          itemBuilder: (context, item, index) => ListTileWidget(
            model: ListTileModel(
              title: item.etiqueta ?? '',
              onTap: () => Get.toNamed('/etiquetas_personalizadas/editar',
                  arguments: item),
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Text(
            'No hay unidades etiquetas',
            style: TextStyle(fontSize: 20),
          )),
          firstPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          newPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          newPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Error al cargar las etiquetas'),
          ),
          firstPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Error al cargar las etiquetas'),
          ),
        ),
      ),
    );
  }
}
