import 'package:flutter/material.dart';

class AppBar2 extends StatelessWidget {
  final String title;
  final bool isHome;
  const AppBar2({super.key, required this.title, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isHome ? Colors.transparent : Colors.white,
      leading: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(1),
        // decoration: BoxDecoration(
        //   color: Colors.blueGrey.withOpacity(0.2),
        //   borderRadius: BorderRadius.circular(50),
        // ),
        child: Image.asset(
          'assets/icons_2/icono_regalo_44x44_negro.png',
          color: isHome ? Colors.white : Colors.black,
          width: 17,
          height: 17,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isHome ? Colors.white : Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          // alignment: Alignment.center,
          // padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(right: 20),
          // decoration: BoxDecoration(
          //   color: Colors.blueGrey.withOpacity(0.2),
          //   borderRadius: BorderRadius.circular(50),
          // ),
          child: Image.asset(
            'assets/icons_2/icono_bandera_44x44_negro.png',
            color: isHome ? Colors.white : Colors.black,
            width: 17,
            height: 17,
          ),
        ),
        Container(
          // alignment: Alignment.center,
          // padding: const EdgeInsets.all(1),
          margin: const EdgeInsets.only(right: 20),
          // decoration: BoxDecoration(
          //   color: Colors.blueGrey.withOpacity(0.2),
          //   borderRadius: BorderRadius.circular(50),
          // ),
          child: Image.asset(
            'assets/icons_2/icono_configuracion_44x44_negro.png',
            color: isHome ? Colors.white : Colors.black,
            width: 17,
            height: 17,
          ),
        )
      ],
    );
  }
}
