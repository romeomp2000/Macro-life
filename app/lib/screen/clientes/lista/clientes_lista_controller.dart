import 'package:fep/config/api_service.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/cliente_model.dart';
import 'package:fep/models/selected_model.dart';
import 'package:fep/widgets/custom_elevated_button.dart';
import 'package:fep/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ClientesListaController extends GetxController {
  final UsuarioController usuarioController = Get.find();
  TextEditingController buscarController = TextEditingController();

  final List<SelectedModel> tipos = [
    SelectedModel(value: '', text: 'Tipo (Todos)'),
    SelectedModel(value: 'Retenido', text: 'Retenidos'),
    SelectedModel(value: 'Trasladado', text: 'Trasladados'),
  ];

  static const int _pageSize = 10;
  final PagingController<int, ClienteModel> pagingController =
      PagingController(firstPageKey: 0);

  ClientesListaController() {
    pagingController.addPageRequestListener((pageKey) {
      fetchItems(pageKey);
    });
  }

  void filterChanged() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Filtros',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: buscarController,
                label: 'Cliente',
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                message: 'Aplicar',
                function: () {
                  pagingController.refresh();
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchItems(int pageKey) async {
    try {
      // Aquí puedes definir los parámetros que necesitas enviar en el body.
      final body = {
        'buscar': buscarController.text,
        'pag': (pageKey ~/ _pageSize) +
            1, // Calcular la página en función del pageKey.
        'id_usuario': usuarioController.usuario.value.idUsuario
      };

      final apiService = ApiService();

      final response = await apiService.fetchData('clientes/obtener',
          method: Method.POST, body: body);

      final impuestosList = (response['clientes'] as List)
          .map((item) => ClienteModel.fromJson(item))
          .toList();

      final isLastPage = impuestosList.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(impuestosList);
      } else {
        final nextPageKey = pageKey + impuestosList.length;
        pagingController.appendPage(impuestosList, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
