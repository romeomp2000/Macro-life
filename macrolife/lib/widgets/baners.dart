// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:macrolife/models/banner_model.dart';

// class BannerPSD extends StatelessWidget {
//   final List<BannerModel> banners;
//   const BannerPSD({super.key, required this.banners});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: Get.width,
//       height: Get.height * 0.3,
//       child: Swiper(
//         pagination: const SwiperPagination(
//           alignment: Alignment.bottomCenter,
//           builder: DotSwiperPaginationBuilder(
//             // activeColor: purpleTheme2_,
//             color: Colors.grey,
//           ),
//         ),
//         onTap: (index) => banners[index].onTap(),
//         autoplay: true,
//         autoplayDelay: 7000,
//         itemCount: banners.length,
//         control: const SwiperControl(
//           color: Colors.white,
//           size: 19,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return Stack(
//             children: [
//               (
//                 // alignment: Alignment.center,
//                 width: double.infinity,
//                 imageUrl: banners[index].image,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => const Center(
//                   child: CircularProgressIndicator.adaptive(),
//                 ),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//               if (banners[index].link != '') iconVerMas(index),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Positioned iconVerMas(int index) {
//     return Positioned(
//       top: 0,
//       right: 0,
//       child: InkWell(
//         onTap: () {
//           banners[index].onTap();
//         },
//         child: Container(
//           margin: const EdgeInsets.all(0),
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.8),
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(15),
//             ),
//           ),
//           child: const Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.ads_click_rounded,
//                 color: Colors.white,
//                 size: 18,
//               ),
//               SizedBox(width: 5),
//               VerMas()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class VerMas extends StatelessWidget {
//   const VerMas({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       'Ver más',
//       style: TextStyle(
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//         fontSize: 12,
//       ),
//     );
//   }
// }
