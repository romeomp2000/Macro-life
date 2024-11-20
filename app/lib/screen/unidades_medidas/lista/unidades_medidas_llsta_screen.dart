import 'package:fep/models/list_tile_model.dart';
import 'package:fep/models/serie_model.dart';
import 'package:fep/models/unidades_medida.model.dart';
import 'package:fep/screen/unidades_medidas/lista/unidades_medidas_lista_controller.dart';
import 'package:fep/widgets/back_arrow.dart';
import 'package:fep/widgets/list_tile_fep.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class UnidadesMedidasListaScreen extends StatelessWidget {
  const UnidadesMedidasListaScreen({super.key});

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
                Get.find<UnidadesMedidasListaController>().filterChanged(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/unidades_medida/nuevo'),
        child: const Icon(Icons.add),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Unidades de medida',
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
    final UnidadesMedidasListaController controller =
        Get.put(UnidadesMedidasListaController());
    return LiquidPullToRefresh(
      onRefresh: () async => controller.pagingController.refresh(),
      child: PagedListView<int, UnidadesMedidaModel>(
        pagingController: controller.pagingController,
        scrollController: ScrollController(),
        padding: const EdgeInsets.all(0),
        builderDelegate: PagedChildBuilderDelegate<UnidadesMedidaModel>(
          itemBuilder: (context, item, index) => ListTileWidget(
            model: ListTileModel(
              title: item.unidad ?? '',
              subtitle: item.descripcion ?? '',
              onTap: () =>
                  Get.toNamed('/unidades_medida/editar', arguments: item),
              trailing: Text(
                item.estatus ?? '',
                style: TextStyle(
                    color:
                        item.estatus == 'activo' ? Colors.green : Colors.red),
              ),
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Text(
            'No hay unidades medidas',
            style: TextStyle(fontSize: 20),
          )),
          firstPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          newPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          newPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Error al cargar las unidades medida'),
          ),
          firstPageErrorIndicatorBuilder: (context) => const Center(
            child: Text('Error al cargar las unidades medida'),
          ),
        ),
      ),
    );
  }
}
