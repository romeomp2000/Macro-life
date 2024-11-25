import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            return const Center(child: ConfiguracionesScreen());
          default:
            return Center(child: Text('Home Screen'));
        }
      }),
      bottomNavigationBar: Stack(
        clipBehavior: Clip
            .none, // Esto permite que el botón se muestre fuera del contenedor
        children: [
          Obx(
            () => BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: controller.selectedIndex.value,
              onTap: (index) {
                if (index != 3) {
                  controller.onItemTapped(index);
                }
              },
              items: [
                BottomNavigationBarItem(
                  activeIcon: Image.network(
                      'https://macrolife.app/images/app/home/menu_inferior_195x195_inicio_activo.png',
                      width: 20),
                  icon: Image.network(
                      'https://macrolife.app/images/app/home/menu_inferior_195x195_inicio_inactivo.png',
                      width: 20),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.network(
                      'https://macrolife.app/images/app/home/menu_inferior_195x195_analytics_activo.png',
                      width: 20),
                  icon: Image.network(
                      'https://macrolife.app/images/app/home/menu_inferior_195x195_analytics_inactivo.png',
                      width: 20),
                  label: 'Analítica',
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.network(
                      'https://macrolife.app/images/app/home/menu_inferior_195x195_configuracion_activo.png',
                      width: 20),
                  icon: Image.network(
                      'https://macrolife.app/images/app/home/menu_inferior_195x195_configuracion_inactivo.png',
                      width: 20),
                  label: 'Ajustes',
                ),
                const BottomNavigationBarItem(
                  icon: SizedBox.shrink(), // Espacio vacío para el botón de +
                  label: '',
                ),
              ],
              type: BottomNavigationBarType.fixed,
            ),
          ),
          Positioned(
            right: 25,
            bottom: 55, // Sube el botón para que sobresalga más
            child: IconButton(
              onPressed: () => controller.onPressPlus(),
              icon: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://macrolife.app/images/app/home/icono_agregar_180x180_line.png',
                  width: 20,
                ),
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

  void onPressPlus() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(30.0),
        decoration: const BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: (Get.width / 2) - 50,
                    height: 140,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.network(
                          'https://macrolife.app/images/app/home/icono_cajon_ejercicio_88x88_registrar.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Registrar\nejercicio',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: (Get.width / 2) - 50,
                    height: 140,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.network(
                          'https://macrolife.app/images/app/home/icono_cajon_ejercicio_88x88_alimentos_guardados.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Alimentos\nguardados',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: (Get.width / 2) - 50,
                    height: 140,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.network(
                          'https://macrolife.app/images/app/home/icono_cajon_ejercicio_88x88_buscar_alimentos.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Base de datos de alimentos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: (Get.width / 2) - 50,
                    height: 140,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.network(
                          'https://macrolife.app/images/app/home/icono_57x57_camara_para_escanear_comida.png',
                          width: 35,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Escanear\nalimentos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 90)
          ],
        ),
      ),
      isScrollControlled: true,
    );
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://macrolife.app/images/app/home/background_1125x2436_uno.jpg', // URL de tu imagen
          ),
          fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      'https://macrolife.app/images/app/logo/logo_macro_life.png',
                      width: 155,
                    ),
                    GestureDetector(
                      onTap: () => controller.onRachaDias(),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 7),
                            Image.network(
                              'https://macrolife.app/images/app/home/icono_flama_chica_52x52_original.png',
                              width: 20,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              '1',
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                              if (!day.isAfter(
                                  DateTime.now())) // Solo días hasta hoy
                                DottedBorder(
                                  color:
                                      isToday ? Colors.black : Colors.black26,
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
              GestureDetector(
                onTap: () => Get.toNamed('/objetivos'),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: Get.width - 40,
                  height: 160,
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
                          radius: 55.0,
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
                  GestureDetector(
                    onTap: () => Get.toNamed('/objetivos'),
                    child: NutrientIndicator(
                      amount: 122,
                      nutrient: "Proteína",
                      percent: 0.2,
                      color: Colors.red,
                      icon:
                          'https://macrolife.app/images/app/home/iconografia_metas_28x28_proteinas.png',
                    ),
                  ),
                  // Indicador de Carbohidratos
                  GestureDetector(
                    onTap: () => Get.toNamed('/objetivos'),
                    child: NutrientIndicator(
                      amount: 178,
                      nutrient: "Carbohidratos",
                      percent: 0.4,
                      color: Colors.orange,
                      icon:
                          'https://macrolife.app/images/app/home/iconografia_metas_28x28_carbohidratos.png',
                    ),
                  ),
                  // Indicador de Grasa
                  GestureDetector(
                    onTap: () => Get.toNamed('/objetivos'),
                    child: NutrientIndicator(
                      amount: 24,
                      nutrient: "Grasa",
                      percent: 0.8,
                      color: Colors.blueAccent,
                      icon:
                          'https://macrolife.app/images/app/home/iconografia_metas_28x28_grasas.png',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                  Positioned(
                    right: 70,
                    bottom: -30,
                    child: Image.network(
                      'https://macrolife.app/images/app/home/flecha_comida_113x149_negro.png',
                      width: 40,
                    ),
                  )
                ],
              ),
            ],
          ),
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

  void onRachaDias() {
    Get.bottomSheet(
      isDismissible: true, // Permite cerrar al presionar fuera
      enableDrag: true, // Permite deslizar para cerrar
      persistent: true,
      isScrollControlled: true,
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Logo e ícono de fuego
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon(Icons.apple, size: 24, color: Colors.black),
                      Image.network(
                        'https://macrolife.app/images/app/logo/logo_macro_life.png',
                        height: 20,
                      ),

                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 7),
                            Image.network(
                              'https://macrolife.app/images/app/home/icono_flama_chica_52x52_original.png',
                              width: 20,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              '1',
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 7),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Ícono de fuego grande
                  Stack(
                    alignment: Alignment
                        .center, // Centrar los widgets dentro del Stack
                    clipBehavior: Clip
                        .none, // Permite que los widgets se desborden fuera del Stack
                    children: [
                      Image.network(
                        'https://macrolife.app/images/app/home/imagen_flama_num_378x462_no_sn.png',
                        width: 130,
                        height: 140,
                      ),
                      const Positioned(
                        bottom:
                            -25, // Ajusta este valor para mover el texto donde desees
                        child: NumberWithBorder(number: '1'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Texto principal
                  const Text(
                    "Racha de días",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE69938),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Indicador de días
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(7, (index) {
                        return Column(
                          children: [
                            Text(
                              ["L", "M", "M", "J", "V", "S", "D"][index],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Icon(
                              index == 4
                                  ? Icons.check_circle
                                  : Icons.circle_rounded,
                              color: index == 4
                                  ? const Color(0xFFE69938)
                                  : Colors.grey[200],
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Mensaje
                  const Text(
                    "¡Estás que ardes! Cada día cuenta para alcanzar tu meta",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Botón continuar
                  SizedBox(
                    width: double.infinity, // Ocupa todo el ancho disponible
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      child: const Text(
                        "Continuar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
  final String icon;

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
          color: Colors.white, // Color del borde
          width: 1.0, // Ancho del borde
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 0.1,
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
            center: Image.network(
              icon,
              width: 15,
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://macrolife.app/images/app/home/background_1125x2436_uno.jpg', // URL de tu imagen
          ),
          fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vista general',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        'https://macrolife.app/images/app/home/icono_check_53x53_naranja.png',
                        width: 27,
                      ),
                      const SizedBox(width: 10),
                      const Text.rich(
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        TextSpan(
                          text: 'Peso objetivo: ',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: '54 Kg',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => {},
                    // st: ElevatedButton.styleFrom(
                    //   foregroundColor: Colors.white,
                    //   backgroundColor: Colors.black, // Letras blancas
                    //   padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    // ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Actualizar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  backgroundBlendMode: BlendMode.clear,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://macrolife.app/images/app/home/icono_cajon_ejercicio_88x88_registrar.png',
                                  width: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text.rich(
                                TextSpan(
                                  text: 'Peso actual',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' 70 kg',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Recuerda actualizar esto al menos una vez a la semana para que podamos ajustar tu plan y alcanzar tu objetivo',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Acción del botón
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Actualiza tu peso',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Tu IMC',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título y categoría
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Tu peso es',
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Saludable',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.help_outline,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Peso
                    const Text(
                      '24.2',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Indicador de rango
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.green,
                                Colors.yellow,
                                Colors.orange,
                                Colors.red,
                              ],
                              stops: [0.0, 0.33, 0.66, 0.85, 1.0],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 100, // Ajustar la posición según el peso
                          top: -10,
                          child: Container(
                            width: 1.5,
                            height: 25,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Etiquetas de rango
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LegendItem(color: Colors.blue, text: 'Bajo peso'),
                        LegendItem(color: Colors.green, text: 'Saludable'),
                        LegendItem(color: Colors.yellow, text: 'Sobrepeso'),
                        LegendItem(color: Colors.red, text: 'Obeso'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.black),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class NumberWithBorder extends StatelessWidget {
  final String number;

  const NumberWithBorder({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Texto con borde (más grande)
        Text(
          number,
          style: TextStyle(
            fontSize: 55,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 14 // Grosor del borde
              ..color = const Color(0xFFE69938), // Color del borde
          ),
        ),
        // Texto interior
        Text(
          number,
          style: const TextStyle(
            fontSize: 55,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del texto interno
          ),
        ),
      ],
    );
  }
}

class ConfiguracionesScreen extends StatelessWidget {
  const ConfiguracionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://macrolife.app/images/app/home/background_1125x2436_uno.jpg', // URL de tu imagen
          ),
          fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Edad'),
                trailing: Text(
                  '24',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Altura'),
                trailing: Text(
                  '170 cm',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Peso actual'),
                trailing: Text(
                  '70 Kg',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Color(0xFFE69938),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Saldo actual',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '\$0',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        // Acción al presionar el botón
                      },
                      child: const Center(
                        child: Text(
                          'Recomienda amigos para ganar \$',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Divider(
                thickness: 0.4,
                color: Colors.grey,
              ),
              const SizedBox(height: 15),
              const Text(
                'Personalización',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 15),
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Detalles personales'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black26,
                  size: 20,
                ),
              ),
              const SizedBox(height: 15),
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Ajustar objetivos'),
                subtitle: Text('Calorías, carbohidratos, gras y proteínas'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black26,
                  size: 20,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 0.4,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text(
                'Preferencias',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 15),
              CupertinoListTile(
                padding: EdgeInsets.zero,
                title: const Text('Calorías quemadas'),
                subtitle:
                    const Text('Agregar calorías quemadas a la meta diario'),
                trailing: CupertinoSwitch(
                  value: true,
                  activeColor: Colors.black,
                  onChanged: (e) => {},
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 0.4,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text(
                'Legal',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 15),
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Términos y condiciones'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black26,
                  size: 20,
                ),
              ),
              const SizedBox(height: 15),
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Política de privacidad'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black26,
                  size: 20,
                ),
              ),
              const SizedBox(height: 15),
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Correo de soporte'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black26,
                  size: 20,
                ),
              ),
              CupertinoListTile(
                onTap: () => Get.offAndToNamed('/registro'),
                padding: EdgeInsets.zero,
                title: const Text('Eliminar cuenta'),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black26,
                  size: 20,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 0.4,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              const CupertinoListTile(
                padding: EdgeInsets.zero,
                title: Text('Dar de baja la cuenta'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black26,
                  size: 20,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 0.4,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text('Versión 0.0.1'),
            ],
          ),
        ),
      ),
    );
  }
}

class PrefixWidget extends StatelessWidget {
  const PrefixWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Icon(icon, color: CupertinoColors.white),
        ),
        const SizedBox(width: 15),
        Text(title)
      ],
    );
  }
}
