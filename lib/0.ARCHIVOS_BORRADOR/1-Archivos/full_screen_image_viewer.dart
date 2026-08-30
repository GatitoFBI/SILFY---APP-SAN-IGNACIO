// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class FullscreenImageViewer extends StatefulWidget {
//   //*La solucion es que cuando estoy en zoom que no pueda cambiar de imagen solo cuando estoy en la imagen normal
//   final List<String> imageUrls;
//   final int initialIndex;
//   final String heroTag;

//   const FullscreenImageViewer({
//     super.key,
//     required this.imageUrls,
//     required this.initialIndex,
//     required this.heroTag,
//   });

//   @override
//   State<FullscreenImageViewer> createState() => _FullscreenImageViewerState();
// }

// class _FullscreenImageViewerState extends State<FullscreenImageViewer> with SingleTickerProviderStateMixin {
//   late final PageController _pageController;
//   int currentIndex = 0;

//   late TransformationController _transformationController;
//   TapDownDetails? _doubleTapDetails;
//   bool _isZoomed = false;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.initialIndex);
//     currentIndex = widget.initialIndex;
//     _transformationController = TransformationController();

//     _transformationController.addListener(() {
//       final isZooming = _isMatrixZoomed(_transformationController.value);
//       if (isZooming != _isZoomed) {
//         setState(() {
//           _isZoomed = isZooming;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _transformationController.dispose();
//     super.dispose();
//   }

//   void _handleDoubleTap() {
//     final position = _doubleTapDetails?.localPosition;
//     if (_transformationController.value != Matrix4.identity()) {
//       _transformationController.value = Matrix4.identity();
//     } else if (position != null) {
//       const zoom = 3.0;
//       _transformationController.value = Matrix4.identity()
//         ..translate(-position.dx * (zoom - 1), -position.dy * (zoom - 1))
//         ..scale(zoom);
//     }
//   }

//   bool _isMatrixZoomed(Matrix4 matrix) {
//     const double tolerance = 0.001;
//     return (matrix.storage[0] - 1.0).abs() > tolerance || // escala X
//         (matrix.storage[5] - 1.0).abs() > tolerance || // escala Y
//         (matrix.storage[12]).abs() > tolerance || // desplazamiento X
//         (matrix.storage[13]).abs() > tolerance; // desplazamiento Y
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: AnimatedOpacity(
//         opacity: 1,
//         duration: const Duration(milliseconds: 300),
//         child: Stack(
//           children: [
//             NotificationListener<ScrollNotification>(
//               onNotification: (notification) => true,
//               child: PageView.builder(
//                 controller: _pageController,
//                 physics: _isZoomed ? const NeverScrollableScrollPhysics() : const PageScrollPhysics(),
//                 itemCount: widget.imageUrls.length,
//                 onPageChanged: (index) {
//                   setState(() {
//                     currentIndex = index;
//                     _transformationController.value = Matrix4.identity(); // reset zoom
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   final imageUrl = widget.imageUrls[index];
//                   return GestureDetector(
//                     onTapDown: (details) => _doubleTapDetails = details,
//                     onDoubleTap: _handleDoubleTap,
//                     child: Center(
//                       child: Hero(
//                         tag: widget.heroTag,
//                         child: InteractiveViewer(
//                           transformationController: _transformationController,
//                           panEnabled: true,
//                           clipBehavior: Clip.none,
//                           minScale: 1,
//                           maxScale: 5,
//                           child: SizedBox.expand(
//                             child: Image.network(
//                               imageUrl,
//                               fit: BoxFit.contain,
//                               alignment: Alignment.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Botón Cerrar SVG (solo si no está en zoom)
//             if (!_isZoomed)
//               Positioned(
//                 top: MediaQuery.of(context).padding.top + 16,
//                 left: 10,
//                 child: GestureDetector(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: Container(
//                     margin: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black38,
//                           blurRadius: 37,
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: SvgPicture.asset(
//                           'assets/icons/button_icons/cerrar.svg',
//                           height: 15,
//                           width: 15,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//             // Indicador de página (solo si no está en zoom)
//             if (!_isZoomed)
//               Positioned(
//                 bottom: 30,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: SmoothPageIndicator(
//                     controller: _pageController,
//                     count: widget.imageUrls.length,
//                     effect: const WormEffect(
//                       dotColor: Colors.white54,
//                       activeDotColor: Colors.white,
//                       dotHeight: 8,
//                       dotWidth: 8,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
