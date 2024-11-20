import 'package:fep/models/impuestos_model.dart';
import 'package:fep/models/list_tile_model.dart';
import 'package:fep/screen/impuestos/lista/impuestos_lista_controller.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/list_tile_fep.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ImpuestosListaScreen extends StatelessWidget {
  const ImpuestosListaScreen({super.key});

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
            onPressed: () =>
                Get.find<ImpuestosListaController>().filterChanged(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/impuestos/nuevo'),
        child: const Icon(Icons.add),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Impuestos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListaImpuestos(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaImpuestos extends StatelessWidget {
  const ListaImpuestos({super.key});

  @override
  Widget build(BuildContext context) {
    final ImpuestosListaController controller = Get.find();
    return LiquidPullToRefresh(
      onRefresh: () async => controller.pagingController.refresh(),
      child: PagedListView<int, ImpuestosModel>(
        pagingController: controller.pagingController,
        scrollController: ScrollController(),
        padding: const EdgeInsets.all(0),
        builderDelegate: PagedChildBuilderDelegate<ImpuestosModel>(
          itemBuilder: (context, item, index) => ListTileWidget(
            model: ListTileModel(
              title: item.tipoImpuesto ?? '',
              subtitle: item.tipofactor ?? '',
              text:
                  '${item.clave ?? ''} - ${item.impuesto ?? ''} (${item.tasaocuota ?? ''})',
              onTap: () => Get.toNamed('/impuestos/editar', arguments: item),
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Text('No hay impuestos encontrados',
                  style: TextStyle(fontSize: 20))),
          firstPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          newPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          newPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Error al cargar los impuestos'),
          ),
          firstPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Error al cargar los impuestos'),
          ),
        ),
      ),
    );
  }
}
