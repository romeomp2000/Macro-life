// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:macrolife/config/theme.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SoporteHank extends StatelessWidget {
//   const SoporteHank({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 15,
//       right: 0,
//       child: GestureDetector(
//           onTap: () {
//             launchUrl(Uri.parse(
//                 'whatsapp://send?phone=+522211717341&text=Hola,%20necesito%20ayuda%20con%20mi%20cuenta%20de%20Hank.'));
//           },
//           child: Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   topLeft: Radius.circular(30)),
//               color: whiteTheme_,
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             margin: const EdgeInsets.only(bottom: 10),
//             child: Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: const Color(0xFF25D366),
//                   ),
//                   child: const Icon(
//                     FontAwesomeIcons.whatsapp,
//                     color: whiteTheme_,
//                     size: 23.0,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 const Text(
//                   'Soporte Técnico',
//                   style: TextStyle(
//                     color: blackTheme1_,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }
