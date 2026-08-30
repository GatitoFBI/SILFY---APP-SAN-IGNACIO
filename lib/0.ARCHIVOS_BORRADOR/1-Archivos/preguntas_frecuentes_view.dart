// import 'package:flutter/material.dart';

// import '../../../../widgets/1.Details_View/components/full_screen_image_viewer.dart';
// import '../../../../widgets/app_text.dart';
// import '../intro_card.dart';

// class PreguntasFrecuentesView extends StatelessWidget {
//   final String categoryName;
//   final String categoryDescription;
//   final List<Map<String, String>> preguntas;

//   const PreguntasFrecuentesView({
//     super.key,
//     required this.categoryName,
//     required this.categoryDescription,
//     required this.preguntas,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: const Padding(
//             padding: EdgeInsets.only(left: 25),
//             child: Icon(Icons.arrow_back_ios),
//           ),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           IntroCard(
//             title: categoryName,
//             description: categoryDescription,
//           ),
//           Expanded(
//             child: ListView.separated(
//               padding: const EdgeInsets.all(12),
//               itemCount: preguntas.length,
//               separatorBuilder: (_, __) => const SizedBox(height: 10),
//               itemBuilder: (context, index) {
//                 final pregunta = preguntas[index]['pregunta'] ?? 'Pregunta';
//                 final respuesta = preguntas[index]['respuesta'] ?? 'Respuesta';
//                 final imageUrl = preguntas[index]['imagen'];

//                 return PreguntaTile(
//                   pregunta: pregunta,
//                   respuesta: respuesta,
//                   imageUrl: imageUrl,
//                   index: index, // usa el índice directamente
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PreguntaTile extends StatelessWidget {
//   final String pregunta;
//   final String respuesta;
//   final String? imageUrl;
//   final int index;

//   const PreguntaTile({
//     super.key,
//     required this.pregunta,
//     required this.respuesta,
//     required this.imageUrl,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           title: AppText(
//             text: pregunta,
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//           ),
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AppText(
//                     text: respuesta,
//                     fontSize: 14,
//                     color: Colors.grey[700],
//                   ),
//                   const SizedBox(height: 8),
//                   if (imageUrl != null)
//                     GestureDetector(
//                       child: Hero(
//                         tag: 'pregunta-image-$index',
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.network(
//                             imageUrl!,
//                             height: 120,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                             errorBuilder: (_, __, ___) => const Text('No se pudo cargar la imagen.'),
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageRouteBuilder(
//                             transitionDuration: const Duration(milliseconds: 400),
//                             pageBuilder: (_, __, ___) => FullscreenImageViewer(
//                               imageUrls: [imageUrl!],
//                               initialIndex: 0,
//                               heroTag: 'pregunta-image-$index',
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
