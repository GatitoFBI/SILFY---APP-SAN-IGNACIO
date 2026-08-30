// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class FullscreenImageViewer extends StatefulWidget {
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

//   late final AnimationController _animationController;
//   Animation<Matrix4>? _animation;
//   Matrix4Tween? _matrixTween;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.initialIndex);
//     currentIndex = widget.initialIndex;
//     _transformationController = TransformationController();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     )..addListener(() {
//         _transformationController.value = _animation!.value;
//       });

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
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _handleDoubleTap() {
//     final position = _doubleTapDetails?.localPosition;
//     final currentMatrix = _transformationController.value;
//     Matrix4 endMatrix;

//     if (_isMatrixZoomed(currentMatrix)) {
//       endMatrix = Matrix4.identity(); // Zoom out
//     } else if (position != null) {
//       const zoom = 3.0;
//       endMatrix = Matrix4.identity()
//         ..translate(-position.dx * (zoom - 1), -position.dy * (zoom - 1))
//         ..scale(zoom); // Zoom in
//     } else {
//       return;
//     }

//     _matrixTween = Matrix4Tween(begin: currentMatrix, end: endMatrix);
//     _animation = _matrixTween!.animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//     _animationController.forward(from: 0);
//   }

//   bool _isMatrixZoomed(Matrix4 matrix) {
//     const double tolerance = 0.001;
//     return (matrix.storage[0] - 1.0).abs() > tolerance ||
//         (matrix.storage[5] - 1.0).abs() > tolerance ||
//         matrix.storage[12].abs() > tolerance ||
//         matrix.storage[13].abs() > tolerance;
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
//                     _transformationController.value = Matrix4.identity();
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

//             // Botón cerrar
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

//             // Indicador
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
