import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LayoutScreen extends StatelessWidget {
  final LayoutController controller = Get.put(LayoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return const Center(child: HomeScreen());
          case 1:
            return const Center(child: AnaliticaScreen());
          case 2:
            return Center(child: Text('Settings Screen'));
          default:
            return Center(child: Text('Home Screen'));
        }
      }),
      bottomNavigationBar: Stack(
        clipBehavior: Clip
            .none, // Esto permite que el botón se muestre fuera del contenedor
        children: [
          Obx(() => BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: controller.selectedIndex.value,
                onTap: (index) {
                  if (index != 3) {
                    controller.onItemTapped(index);
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Inicio',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.analytics_outlined),
                    label: 'Analítica',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined),
                    label: 'Ajustes',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox.shrink(), // Espacio vacío para el botón de +
                    label: '',
                  ),
                ],
                type: BottomNavigationBarType.fixed,
              )),
          Positioned(
            right: 25,
            bottom: 55, // Sube el botón para que sobresalga más
            child: GestureDetector(
              onTap: () {
                print("Botón + presionado");
              },
              child: Container(
                width: 63,
                height: 63,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LayoutController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LayoutController());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeeklyCalendarController controller =
        Get.put(WeeklyCalendarController());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://macrolife.app/images/app/logo/logo_macro_life.png',
                  width: 155,
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(20.0), // Borde redondeado
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 7),
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.redAccent,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '0',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(width: 7),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: PageView.builder(
                controller: controller.pageController,
                reverse: true,
                itemBuilder: (context, index) {
                  DateTime weekStart = controller.getWeekStartDate(index);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (dayIndex) {
                      DateTime day = weekStart.add(Duration(days: dayIndex));
                      bool isToday = controller.isToday(day);
                      bool isBeforeToday = day.isBefore(DateTime.now());

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          children: [
                            // Letras iniciales con borde punteado solo para días hasta hoy
                            if (!day
                                .isAfter(DateTime.now())) // Solo días hasta hoy
                              DottedBorder(
                                color: isToday ? Colors.black : Colors.black26,
                                borderType: BorderType.Circle,
                                dashPattern: const [3, 3],
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  alignment: Alignment.center,
                                  child: Text(
                                    DateFormat.E('es')
                                        .format(day)
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: isToday
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )
                            else // Días después de hoy (sin borde punteado)
                              Container(
                                width: 36,
                                height: 36,
                                alignment: Alignment.center,
                                child: Text(
                                  DateFormat.E('es')
                                      .format(day)
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            SizedBox(height: 4),
                            // Número del día sin borde ni fondo
                            Text(
                              day.day.toString(),
                              style: TextStyle(
                                color: isToday
                                    ? Colors.black
                                    : (isBeforeToday
                                        ? Colors.grey[800]
                                        : Colors.grey[600]),
                                fontWeight: isToday
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                width: Get.width - 40,
                // height: 170,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Texto de las calorías restantes
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1744',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Calorías restantes',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      // Círculo con icono de fuego
                      CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 8.0,
                        percent: 0.2, // Ajusta el valor de progreso
                        center: const Icon(
                          Icons.local_fire_department,
                        ),
                        progressColor: Colors.black, // Color del progreso
                        backgroundColor:
                            Colors.black12, // Color del fondo del círculo
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Indicador de Proteína
                NutrientIndicator(
                  amount: 122,
                  nutrient: "Proteína",
                  percent: 0.2,
                  color: Colors.red,
                  icon: Icons.local_fire_department,
                ),
                // Indicador de Carbohidratos
                NutrientIndicator(
                  amount: 178,
                  nutrient: "Carbohidratos",
                  percent: 0.4,
                  color: Colors.orange,
                  icon: Icons.grain,
                ),
                // Indicador de Grasa
                NutrientIndicator(
                  amount: 24,
                  nutrient: "Grasa",
                  percent: 0.8,
                  color: Colors.blue,
                  icon: Icons.opacity,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No has subido ninguna comida',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Comienza a registrar las comidas de hoy tomando una foto rápido',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeeklyCalendarController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  Rx<DateTime> today = DateTime.now().obs;

  DateTime getWeekStartDate(int weekOffset) {
    DateTime current = today.value;
    return current
        .subtract(Duration(days: current.weekday - 1 + weekOffset * 7));
  }

  bool isToday(DateTime date) {
    DateTime current = DateTime.now();
    return date.day == current.day &&
        date.month == current.month &&
        date.year == current.year;
  }
}

class NutrientIndicator extends StatelessWidget {
  final int amount;
  final String nutrient;
  final double percent;
  final Color color;
  final IconData icon;

  NutrientIndicator({
    required this.amount,
    required this.nutrient,
    required this.percent,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 170,
      // color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black12, // Color del borde
          width: 2.0, // Ancho del borde
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${amount}g',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '$nutrient restante',
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 7.0,
            percent: percent,
            center: Icon(
              icon,
              color: color,
              size: 20,
            ),
            progressColor: color,
            backgroundColor: Colors.black12,
          ),
        ],
      ),
    );
  }
}

class AnaliticaScreen extends StatelessWidget {
  const AnaliticaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final WeeklyCalendarController controller =
    //     Get.put(WeeklyCalendarController());
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
        child: Column(
          children: [
            const Text(
              'Vista general',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.circle_outlined, color: Colors.orange),
                    SizedBox(width: 5),
                    Text('Peso objetivo: 54 Kg'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black, // Letras blancas
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  ),
                  child: const Text('Actualizar'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
