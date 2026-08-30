// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../../../Domain/entities/tourist_visita_entity.dart';
// import '../selection_title.dart';
// import '../video_widget.dart';
// import 'components/favorite_button.dart';
// import 'components/full_screen_image_viewer.dart';
// import 'components/share_button.dart';
// import 'components/tourist_info_card.dart';
// import 'components/tourist_social_media_card.dart';

// class DetailsViewWidget extends StatefulWidget {
//   final TouristVisitaEntity item;

//   const DetailsViewWidget({
//     required this.item,
//     super.key,
//   });

//   @override
//   State<DetailsViewWidget> createState() => _DetailsViewWidgetState();
// }

// class _DetailsViewWidgetState extends State<DetailsViewWidget> {
//   final PageController _pageController = PageController();
//   int currentIndex = 0;
//   bool _expanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildImageCarousel(),
//             const SizedBox(height: 12),
//             _buildTitle(),
//             const SizedBox(height: 12),
//             _buildActionButtons(),
//             const SizedBox(height: 20),
//             _buildExpandableDescription(),
//             const SizedBox(height: 3),
//             _buildReadMoreButton(),
//             const SizedBox(height: 10),
//             VideoWidget(videoId: widget.item.videoUrl),
//             const SizedBox(height: 10),
//             const SectionTitle(text: "Detalles Adicionales"),
//             TouristInfoCard(infoItems: widget.item.infoItems),
//             if (widget.item.phoneNumber != null ||
//                 (widget.item.socialMediaLinks != null && widget.item.socialMediaLinks!.isNotEmpty)) ...[
//               const SizedBox(height: 15),
//               const SectionTitle(text: "Redes Sociales y Contacto"),
//               TouristSocialMediaCard(
//                 phoneNumber: widget.item.phoneNumber,
//                 socialMediaLinks: widget.item.socialMediaLinks,
//               ),
//             ],
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       surfaceTintColor: Colors.transparent,
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       leading: GestureDetector(
//         onTap: () => Navigator.pop(context),
//         child: _buildBackButton(),
//       ),
//       actions: [
//         const FavoriteButton(),
//         ShareButton(item: widget.item),
//       ],
//     );
//   }

//   Widget _buildImageCarousel() {
//     return SizedBox(
//       height: 250,
//       child: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             itemCount: widget.item.imagePaths.length,
//             onPageChanged: (index) {
//               setState(() {
//                 currentIndex = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               final imageUrl = widget.item.imagePaths[index];

//               return GestureDetector(
//                 child: Hero(
//                   tag: widget.item.id,
//                   child: Image.network(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageRouteBuilder(
//                       transitionDuration: const Duration(milliseconds: 400),
//                       pageBuilder: (_, __, ___) => FullscreenImageViewer(
//                         imageUrls: widget.item.imagePaths,
//                         initialIndex: index,
//                         heroTag: widget.item.id,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           Positioned(
//             bottom: 10,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: SmoothPageIndicator(
//                 controller: _pageController,
//                 count: widget.item.imagePaths.length,
//                 effect: const WormEffect(
//                   dotColor: Colors.white54,
//                   activeDotColor: Colors.white,
//                   dotHeight: 8,
//                   dotWidth: 8,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTitle() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Text(
//         widget.item.title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Wrap(
//         spacing: 12,
//         runSpacing: 12,
//         alignment: WrapAlignment.center,
//         children: [
//           _buildSvgButton('assets/icons/button_icons/audio.svg', 'Reproducir audio', () {}),
//           _buildSvgButton('assets/icons/button_icons/vr.svg', 'VR', () {}),
//           _buildSvgButton('assets/icons/button_icons/mapa.svg', 'Mapa', () {}),
//         ],
//       ),
//     );
//   }

//   Widget _buildExpandableDescription() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: AnimatedCrossFade(
//         crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//         duration: const Duration(milliseconds: 300),
//         firstChild: _buildDescriptionText(maxLines: 4),
//         secondChild: _buildDescriptionText(),
//       ),
//     );
//   }

//   Widget _buildReadMoreButton() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           TextButton(
//             onPressed: () {
//               setState(() => _expanded = !_expanded);
//             },
//             child: Text(
//               _expanded ? 'Leer menos' : 'Leer más',
//               style: const TextStyle(
//                 color: Colors.white,
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSvgButton(String assetPath, String label, Function()? onPressed) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       ),
//       icon: SvgPicture.asset(
//         assetPath,
//         width: 20,
//         height: 20,
//       ),
//       label: Text(label),
//     );
//   }

//   Widget _buildDescriptionText({int? maxLines}) {
//     return Text(
//       widget.item.description,
//       style: const TextStyle(
//         color: Colors.white,
//       ),
//       overflow: maxLines != null ? TextOverflow.ellipsis : null,
//       maxLines: maxLines,
//     );
//   }

//   Widget _buildBackButton() {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black38,
//             blurRadius: 37,
//           ),
//         ],
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: SvgPicture.asset(
//             'assets/icons/button_icons/izquierdo.svg',
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
