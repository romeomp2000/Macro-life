// import 'package:get/get.dart';
// import 'package:macrolife/models/list_tile_model.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class NotificacionesController extends GetxController {
//   final PagingController<int, ListTileModel> pagingController =
//       PagingController(
//     firstPageKey: 0,
//   );

//   @override
//   void onInit() {
//     pagingController.addPageRequestListener((pageKey) {
//       Future.delayed(const Duration(seconds: 2), () {
//         final List<ListTileModel> items = List.generate(
//           10,
//           (index) => ListTileModel(
//             title:
//                 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto $index',
//             subtitle:
//                 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.',
//             // icon: Icons.notifications,
//             onTap: () {
//               // Do something when ListTile is tapped
//               print('Tapped on ListTile $index');
//             },
//           ),
//         );
//         // Append the fetched items to the list
//         pagingController.appendPage(items, pageKey + 1);
//       });
//     });
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     pagingController.dispose();
//     super.onClose();
//   }
// }
