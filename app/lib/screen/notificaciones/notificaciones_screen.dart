// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fep/config/theme.dart';
// import 'package:fep/models/list_tile_model.dart';
// import 'package:fep/screen/notificaciones/notificaciones_controller.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class NotificacionesScreen extends StatelessWidget {
//   const NotificacionesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NotificacionesController());

//     return PagedListView<int, ListTileModel>(
//       pagingController: controller.pagingController,
//       builderDelegate: PagedChildBuilderDelegate<ListTileModel>(
//         animateTransitions: true,
//         firstPageProgressIndicatorBuilder: (context) =>
//             const Center(child: CircularProgressIndicator.adaptive()),
//         newPageProgressIndicatorBuilder: (context) =>
//             const Center(child: CircularProgressIndicator.adaptive()),
//         transitionDuration: const Duration(milliseconds: 500),
//         itemBuilder: (_, item, index) {
//           return Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: ListTile(
//               title: Text(item.title),
//               dense: true,
//               minLeadingWidth: 20,
//               subtitle: Text(
//                 item.subtitle,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 softWrap: true,
//               ),
//               // leading: Icon(item.icon, color: purpleTheme5_),
//               onTap: item.onTap as void Function()?,
//               // trailing: const Icon(Icons.arrow_forward_ios,
//               //     size: 15, color: purpleTheme5_),
//             ),
//           );
//         },
//         firstPageErrorIndicatorBuilder: (context) => const Text('Error'),
//         noItemsFoundIndicatorBuilder: (context) => const Text('No items found'),
//         newPageErrorIndicatorBuilder: (context) =>
//             const Text('Error loading items'),
//         noMoreItemsIndicatorBuilder: (context) =>
//             const Text('No more items to load'),
//       ),
//     );
//   }
// }
