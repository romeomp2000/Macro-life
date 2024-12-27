import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';

class CounterController extends GetxController {
  var count = 0.obs; // Este es el estado reactivo

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }
}

class HomeWidgetExample {
  // Método para actualizar el widget en la pantalla de inicio
  static Future<void> updateWidget(int count) async {
    await HomeWidget.saveWidgetData<String>('count', count.toString());
    HomeWidget.updateWidget(
      name: 'counter_widget',
      iOSName: 'counter_widget',
    );
  }

  // Este método se usa para mostrar el widget cuando la app se inicia o cuando se activa el widget
  static Future<void> init() async {
    final count =
        int.tryParse(await HomeWidget.getWidgetData('count') ?? '0') ?? 0;
    print("Widget count: $count");
  }
}
