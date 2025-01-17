// import 'dart:async';
// import 'package:macrolife/config/theme.dart';
// import 'package:macrolife/models/selected_model.dart';
// import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:get/get.dart';

// class CustomDropdownSearch extends StatelessWidget {
//   final String label;
//   final List<SelectedModel>? items;
//   final SelectedModel? selectedItem;
//   final Function(SelectedModel?)? onChanged;
//   final String? Function(SelectedModel?)? validator;

//   const CustomDropdownSearch({
//     super.key,
//     required this.label,
//     this.items,
//     required this.selectedItem,
//     this.onChanged,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownSearch<SelectedModel>(
//       decoratorProps: decoratorProps(),
//       popupProps: popupProps(),
//       filterFn: filterFN,
//       dropdownBuilder: dropdownBuilder,
//       validator: validator,
//       itemAsString: (item) => item.text ?? '',
//       selectedItem: selectedItem,
//       items: itemsBuilder,
//       onChanged: onChanged,
//       compareFn: compareFn,
//     );
//   }

//   FutureOr<List<SelectedModel>> itemsBuilder(filter, infiniteScrollProps) =>
//       items ?? [];

//   PopupProps<SelectedModel> popupProps() {
//     return PopupProps.modalBottomSheet(
//       searchDelay: const Duration(microseconds: 0),
//       showSearchBox: (items != null && items!.length > 10),
//       searchFieldProps: searchFieldProps(),
//       errorBuilder: errorBuilder,
//       loadingBuilder: loadingBuilder,
//       containerBuilder: containerBuilder,
//       emptyBuilder: emptyBuilder,
//       title: title(),
//       itemBuilder: itemBuilder,
//     );
//   }

//   Widget emptyBuilder(context, searchEntry) => const Center(
//         heightFactor: 2,
//         child: Text("No se encontraron elementos"),
//       );

//   DropDownDecoratorProps decoratorProps() {
//     return DropDownDecoratorProps(
//       decoration: InputDecoration(
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 21, horizontal: 20),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.black54),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.red),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.red),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.black54),
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }

//   TextFieldProps searchFieldProps() {
//     return TextFieldProps(
//       decoration: InputDecoration(
//         label: const Text('Buscar', style: TextStyle(color: Colors.black54)),
//         border: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.black54, width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.red, width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.red, width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.black54, width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.black54, width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//       ),
//     );
//   }

//   Widget errorBuilder(context, error, stackTrace) {
//     return const Center(
//       heightFactor: 2,
//       child: Text("Error al cargar elementos"),
//     );
//   }

//   Widget containerBuilder(context, child) {
//     return Container(
//       constraints: BoxConstraints(maxHeight: Get.height * 0.6),
//       child: child,
//     );
//   }

//   Widget loadingBuilder(context, searchEntry) {
//     return const Center(
//       heightFactor: 2,
//       child: CircularProgressIndicator.adaptive(),
//     );
//   }

//   Padding title() => Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           textAlign: TextAlign.center,
//         ),
//       );

//   Widget itemBuilder(context, item, isSelected, isFocused) {
//     return ListTile(
//       title: Text(item.text ?? ''),
//       selected: item == selectedItem,
//       selectedTileColor: greenTheme1_,
//       selectedColor: whiteTheme_,
//       tileColor: isFocused ? Colors.grey[300] : null,
//     );
//   }

//   bool compareFn(item1, item2) => item1.value == item2.value;

//   Widget dropdownBuilder(context, selectedItem) {
//     if (selectedItem == null) {
//       return Row(
//         children: [
//           Text(label,
//               style: const TextStyle(color: Colors.black54, fontSize: 16)),
//           if (validator != null)
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   '*',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       );
//     } else {
//       return Text(
//         selectedItem.text ?? '',
//         style: const TextStyle(
//           color: Colors.black54,
//           fontSize: 16,
//         ),
//       );
//     }
//   }

//   bool filterFN(item, filter) {
//     List<String> filterWords = filter.toLowerCase().split(' ');
//     return filterWords.every((word) => item.text!.toLowerCase().contains(word));
//   }
// }
