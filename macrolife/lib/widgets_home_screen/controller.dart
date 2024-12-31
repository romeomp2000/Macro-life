import 'package:home_widget/home_widget.dart';
import 'package:get/get.dart';

class WidgetController extends GetxController {
  RxInt counter = 0.obs;
  RxString title = ''.obs;
  RxString content = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    updateHomeWidget();
    super.onInit();
  }

  void incrementCounter() {
    counter++;
    updateHomeWidget();
  }

  void updateHomeWidget() async {
    // Actualizar datos del widget
    await HomeWidget.saveWidgetData<int>('counter', counter.value);
    await HomeWidget.saveWidgetData<String>('title', title.value);
    await HomeWidget.saveWidgetData<String>('content', content.value);
    await HomeWidget.updateWidget(
        name: 'HomeWidgetProvider', iOSName: 'HomeWidget');
  }
}
