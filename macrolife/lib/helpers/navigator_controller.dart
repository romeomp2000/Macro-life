// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:macrolife/screen/home/home_screen.dart';
// import 'package:macrolife/screen/notificaciones/notificaciones_screen.dart';
// import 'package:macrolife/screen/pefil/perfil_screen.dart';

// class NavigationController extends GetxController {
//   var currentIndex = 2.obs;

//   void changePage(int index) {
//     currentIndex.value = index;
//   }

//   List<BottomNavigationBarItem> items = [
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.qr_code),
//       label: 'QR',
//       tooltip: 'QR',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.qr_code_scanner),
//       label: 'Lector QR',
//       tooltip: 'Lector QR',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.home),
//       label: 'Home',
//       tooltip: 'Home',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.notifications),
//       label: 'Notificaciones',
//       tooltip: 'Notificaciones',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.person),
//       label: 'Perfil',
//       tooltip: 'Perfil',
//     ),
//   ];

//   List<Widget> pages = [
//     const HomeScreen(),
//     const NotificacionesScreen(),
//     const PerfilScreen(),
//   ];
// }
