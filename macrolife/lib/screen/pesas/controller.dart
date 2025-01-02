import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/models/alimento.psd.dart';

class PesasController extends GetxController {
  final buscadorController = TextEditingController();

  RxList<AlimentosPSD> alimentos = <AlimentosPSD>[].obs;
  RxBool loading = false.obs;

  void buscarAlimento(String alimento) async {
    try {
      if (alimento.isEmpty) {
        return;
      }
      loading.value = true;
      final apiService = ApiService();

      final response = await apiService.fetchData(
        'food-database',
        method: Method.POST,
        body: {'search': alimento.trim()},
      );

      alimentos.value = AlimentosPSD.fromJsonList(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      loading.value = false;
    }
  }
  
}
