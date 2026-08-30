// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../../1.CONFIG/Core/utils/enum_category_type.dart';
// import '../../Domain/entities/tourist_visita_entity.dart';

// class HorizontalItem extends StatefulWidget {
//   final TouristVisitaEntity item;

//   const HorizontalItem({super.key, required this.item});

//   @override
//   State<HorizontalItem> createState() => _HorizontalItemState();
// }

// class _HorizontalItemState extends State<HorizontalItem> {
//   bool isFavorite = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1C1C1C),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           // Imagen con etiqueta y botón de favorito
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   bottomLeft: Radius.circular(20),
//                 ),
//                 child: Image.network(
//                   widget.item.imagePaths[0],
//                   width: 200,
//                   height: 160,
//                   fit: BoxFit.cover,
//                 ),
//               ),

//               // Etiqueta "Recomendado"
//               if (widget.item.isRecommended)
//                 Positioned(
//                   top: 15,
//                   left: 0,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: const BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.only(
//                         bottomRight: Radius.circular(12),
//                         topRight: Radius.circular(12),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         SvgPicture.asset(
//                           'assets/icons/button_icons/regalo.svg',
//                           color: Colors.white,
//                           width: 14,
//                           height: 14,
//                         ),
//                         const SizedBox(width: 4),
//                         const Text(
//                           'Recomendado',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//               // Botón de favorito
//               Positioned(
//                 top: 10,
//                 right: 10,
//                 child: GestureDetector(
//                   onTap: () => setState(() => isFavorite = !isFavorite),
//                   child: SvgPicture.asset(
//                     isFavorite
//                         ? 'assets/icons/button_icons/corazon_con.svg'
//                         : 'assets/icons/button_icons/corazon_sin.svg',
//                     width: 28,
//                     height: 28,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),

//               // Tag de duración o calificación
//               if (_buildInfoTag() is! SizedBox)
//                 Positioned(
//                   bottom: 10,
//                   right: 10,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: _buildInfoTag(),
//                   ),
//                 ),
//             ],
//           ),

//           const SizedBox(width: 12),

//           // Textos
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 12, bottom: 12, right: 5),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.item.title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     _buildPrecioTexto(),
//                     style: const TextStyle(
//                       color: Color(0xFFAAAAAA),
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoTag() {
//     String getRating() {
//       final map = widget.item.infoItems.firstWhere(
//         (e) => e.containsKey("Calificación"),
//         orElse: () => {"Calificación": "Sin calificación"},
//       );
//       return map["Calificación"]!;
//     }

//     switch (widget.item.locationType) {
//       case CategoryType.visitas:
//         return Row(
//           children: [
//             SvgPicture.asset(
//               'assets/icons/button_icons/tiempo.svg',
//               color: Colors.white,
//               width: 14,
//               height: 14,
//             ),
//             const SizedBox(width: 4),
//             _buildDurationText(),
//           ],
//         );
//       case CategoryType.hoteles:
//       case CategoryType.restaurantes:
//         return Row(
//           children: [
//             SvgPicture.asset(
//               'assets/icons/button_icons/estrella.svg',
//               color: Colors.white,
//               width: 14,
//               height: 14,
//             ),
//             const SizedBox(width: 4),
//             Text(
//               getRating(),
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         );
//       default:
//         return const SizedBox.shrink();
//     }
//   }

//   Widget _buildDurationText() {
//     final duracionStr = widget.item.infoItems
//         .firstWhere(
//           (e) => e.containsKey("Duración promedio:"),
//           orElse: () => {"Duración promedio:": ""},
//         )["Duración promedio:"]!
//         .toLowerCase();

//     final regex = RegExp(r'(\d+)\s*(h|m|min|horas?)');
//     final matches = regex.allMatches(duracionStr);

//     int totalMinutes = 0;
//     for (final match in matches) {
//       final value = int.tryParse(match.group(1) ?? '0') ?? 0;
//       final unit = match.group(2);
//       if (unit!.contains('h')) {
//         totalMinutes += value * 60;
//       } else {
//         totalMinutes += value;
//       }
//     }

//     final hours = totalMinutes ~/ 60;
//     final minutes = totalMinutes % 60;
//     final formatted = hours > 0 ? (minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h') : '${minutes}m';

//     return Text(
//       formatted,
//       style: const TextStyle(
//         color: Colors.white,
//         fontSize: 12,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }

//   String _buildPrecioTexto() {
//     if (widget.item.locationType == CategoryType.festividades) {
//       final fecha = widget.item.infoItems.firstWhere(
//         (e) => e.containsKey("Fecha:"),
//         orElse: () => {"Fecha:": "Fecha no disponible"},
//       )["Fecha:"];

//       return fecha ?? "Fecha no disponible";
//     }

//     if (widget.item.locationType == CategoryType.museo) {
//       final fecha = widget.item.infoItems.firstWhere(
//         (e) => e.containsKey("Código de inventario:"),
//         orElse: () => {"Código de inventario:": "Código no disponible"},
//       )["Código de inventario:"];

//       return fecha ?? "Código no disponible";
//     }

//     final key = switch (widget.item.locationType) {
//       CategoryType.visitas => "Costo movilidad:",
//       CategoryType.hoteles => "Costo día:",
//       CategoryType.restaurantes => "Precio estimado:",
//       CategoryType.platos => "Costo por plato:",
//       _ => "",
//     };

//     final costoRaw = widget.item.infoItems.firstWhere(
//           (e) => e.containsKey(key),
//           orElse: () => {key: "Precio no disponible"},
//         )[key] ??
//         "Precio no disponible";

//     final match = RegExp(r'S\/\s*\d+(\.\d+)?').firstMatch(costoRaw);
//     final costoLimpio = match?.group(0) ?? "Precio no disponible";

//     return 'A partir de $costoLimpio';
//   }
// }
