import 'package:fep/models/list_tile_model.dart';
import 'package:fep/models/producto_model.dart';
import 'package:fep/screen/productos/lista/productos_lista_controller.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/list_tile_fep.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ProductosListaScreen extends StatelessWidget {
  const ProductosListaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BackArrow(text: 'Home '),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Filtros',
            icon: const Icon(Icons.filter_alt),
            onPressed: () =>
                Get.find<ProductosListaController>().filterChanged(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/productos/nuevo'),
        child: const Icon(Icons.add),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Productos',
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
    final ProductosListaController controller =
        Get.put(ProductosListaController());
    return LiquidPullToRefresh(
      onRefresh: () async => controller.pagingController.refresh(),
      child: PagedListView<int, ProductoModel>(
        pagingController: controller.pagingController,
        scrollController: ScrollController(),
        padding: const EdgeInsets.all(0),
        builderDelegate: PagedChildBuilderDelegate<ProductoModel>(
          itemBuilder: (context, item, index) => ListTileWidget(
            model: ListTileModel(
              title: item.producto ?? '',
              subtitle: 'Clave: ${item.clave ?? ''}',
              text:
                  'Unidad: ${item.objetoimp ?? ''}\nObjeto de impuestos:${item.objetoimp ?? ''}',
              onTap: () => Get.toNamed('/productos/editar', arguments: item),
              trailing: Text(
                item.estatus ?? '',
                style: TextStyle(
                  color: item.estatus == 'activo' ? Colors.green : Colors.red,
                ),
              ),
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Text(
            'No hay productos encontrados',
            style: TextStyle(fontSize: 20),
          )),
          firstPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          newPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          newPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Error al cargar los productos'),
          ),
          firstPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Error al cargar los productos'),
          ),
        ),
      ),
    );
  }
}
