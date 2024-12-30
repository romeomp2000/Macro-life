import 'package:home_widget/home_widget.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var counter = 0.obs;

  void incrementCounter() {
    counter++;
    updateHomeWidget();
  }

  void updateHomeWidget() async {
    // Actualizar datos del widget
    await HomeWidget.saveWidgetData<int>('counter', counter.value);
    await HomeWidget.updateWidget(name: 'WidgetHomeExtension');
  }
}
