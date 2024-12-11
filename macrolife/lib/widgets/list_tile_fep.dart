// import 'package:macrolife/models/list_tile_model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ListTileWidget extends StatelessWidget {
//   final ListTileModel model;
//   const ListTileWidget({
//     super.key,
//     required this.model,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Theme.of(context).brightness == Brightness.dark
//               ? Colors.grey.shade800
//               : Colors.grey.shade300,
//         ),
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       margin: const EdgeInsets.only(bottom: 5.0, top: 5),
//       child: ListTile(
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
//         style: ListTileStyle.drawer,
//         minLeadingWidth: 20,
//         trailing: model.trailing,
//         // ??
//         // Icon(
//         //   Icons.arrow_forward_ios,
//         //   color: Colors.grey.shade500,
//         //   size: 16.0,
//         // ),
//         title: Text(
//           model.title ?? '',
//           style: GoogleFonts.lato(
//             fontWeight: FontWeight.w600,
//             fontSize: 16.0,
//             color: const Color(0xFF002A3A),
//           ),
//         ),
//         subtitle: model.subtitle == null ? null : subtitle(),
//         onTap: model.onTap as GestureTapCallback?,
//       ),
//     );
//   }

//   Column subtitle() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (model.subtitle != null)
//           Text(
//             model.subtitle ?? '',
//             style: GoogleFonts.openSans(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey.shade700,
//             ),
//           ),
//         if (model.text != null)
//           Column(
//             children: [
//               const SizedBox(height: 6.0),
//               Text(
//                 model.text ?? '',
//                 style: GoogleFonts.roboto(
//                   fontSize: 12.0,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }
