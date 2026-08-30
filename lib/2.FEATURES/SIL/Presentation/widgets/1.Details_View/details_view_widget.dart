// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Data/datasources/Local Datasource/place_local_datasource_sqflite.dart';
import '../../../Domain/entities/tourist_visita_entity.dart';
import '../../views/0.Navigator_Bar_View/navigator_bar_view.dart';
import '../3.AR_Model_View/ar_model_view.dart';
import '../bottom_audio_player.dart';
import '../full_screen_image_viewer.dart';
import '../selection_title.dart';
import '../video_widget.dart';
import 'components/favorite_button.dart';
import 'components/share_button.dart';
import 'components/tourist_info_card.dart';
import 'components/tourist_social_media_card.dart';

class DetailsViewWidget extends StatefulWidget {
  final TouristVisitaEntity item;

  const DetailsViewWidget({
    required this.item,
    super.key,
  });

  @override
  State<DetailsViewWidget> createState() => _DetailsViewWidgetState();
}

class _DetailsViewWidgetState extends State<DetailsViewWidget> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  bool _expanded = false;
  String? currentTTS;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();

    _checkIfPlaceIsSaved();
  }

  @override
  void dispose() {
    stopTTS();
    _pageController.dispose();
    super.dispose();
  }

  void _speakDescription() {
    setState(() => currentTTS = widget.item.description);
  }

  void stopTTS() {
    currentTTS = null;
    // setState(() => currentTTS = null);
  }

  Future<void> _checkIfPlaceIsSaved() async {
    try {
      // Verificamos si el lugar con el id está guardado en favoritos
      final places = await PlaceLocalDataSourceSqflite.getAllPlaces();
      setState(() {
        isSaved = places.any((p) => p.id == widget.item.id);
      });
    } catch (e) {
      debugPrint("🍎 Error al verificar si el lugar está guardado: $e");
    }
  }

  Future<void> _toggleSavePlace() async {
    try {
      if (isSaved) {
        await PlaceLocalDataSourceSqflite.deletePlace(widget.item.id);
      } else {
        await PlaceLocalDataSourceSqflite.insertPlace(widget.item);
      }
      await _checkIfPlaceIsSaved();
    } catch (e) {
      debugPrint("🧠 Error al guardar/eliminar el lugar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildImageCarousel(),
                const SizedBox(height: 12),
                _buildTitle(),
                const SizedBox(height: 12),
                _buildActionButtons(),
                const SizedBox(height: 20),
                _buildExpandableDescription(),
                const SizedBox(height: 3),
                _buildReadMoreButton(),
                const SizedBox(height: 10),
                //TODO: video bug:
                VideoWidget(videoId: widget.item.videoUrl),
                const SizedBox(height: 10),
                const SectionTitle(text: "Detalles Adicionales"),
                TouristInfoCard(infoItems: widget.item.infoItems),
                if (widget.item.phoneNumber != null ||
                    (widget.item.socialMediaLinks != null && widget.item.socialMediaLinks!.isNotEmpty)) ...[
                  const SizedBox(height: 15),
                  const SectionTitle(text: "Redes Sociales y Contacto"),
                  TouristSocialMediaCard(
                    phoneNumber: widget.item.phoneNumber,
                    socialMediaLinks: widget.item.socialMediaLinks,
                  ),
                ],
                const SizedBox(height: 30),
                if (currentTTS != null) const SizedBox(height: 50),
              ],
            ),
          ),
          if (currentTTS != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomTTSPlayer(
                text: currentTTS!,
                onFinished: stopTTS,
              ),
            ),
        ],
      ),
      // 🔥 Solo aparece cuando locationType == "visitas"
      // floatingActionButton: widget.item.locationType == CategoryType.visitas
      //     ? FloatingActionButton(
      //         backgroundColor: Colors.white,
      //         onPressed: () {
      //           _showDamageReportForm(context);
      //         },
      //         child: const Icon(
      //           Icons.report_rounded,
      //           color: Colors.red,
      //         ),
      //       )
      //     : null,
    );
  }

  // void _showDamageReportForm(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           left: 16,
  //           right: 16,
  //           top: 20,
  //           bottom: MediaQuery.of(context).viewInsets.bottom + 20,
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Text(
  //               "Reporte de Daño",
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //             const SizedBox(height: 12),

  //             // Campo nombre
  //             const TextField(
  //               decoration: InputDecoration(
  //                 labelText: "Nombre",
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             const SizedBox(height: 12),

  //             // Campo descripción
  //             const TextField(
  //               maxLines: 4,
  //               decoration: InputDecoration(
  //                 labelText: "Descripción del daño",
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             const SizedBox(height: 12),

  //             // Botón enviar ficticio
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.green,
  //                 foregroundColor: Colors.white,
  //                 minimumSize: const Size.fromHeight(45),
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(content: Text("✅ Reporte enviado (ficticio)")),
  //                 );
  //               },
  //               child: const Text("Enviar"),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  AppBar _buildAppBar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: _buildBackButton(),
      ),
      actions: [
        FavoriteButton(
          isFavorite: isSaved,
          onTap: _toggleSavePlace,
        ),
        // onTap: () {
        //   setState(() {
        //     isSaved = !isSaved;
        //   });
        // },

        ShareButton(item: widget.item),
      ],
    );
  }

  Widget _buildImageCarousel() {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.item.imagePaths.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final imageUrl = widget.item.imagePaths[index];

              final imageWidget = (index == 0)
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 40),
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );

              return GestureDetector(
                child: Hero(
                  tag: widget.item.id,
                  child: imageWidget,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) => FullscreenImageViewer(
                        imageUrls: widget.item.imagePaths,
                        initialIndex: index,
                        heroTag: widget.item.id,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Indicadores
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.item.imagePaths.length,
                effect: const WormEffect(
                  dotColor: Colors.white54,
                  activeDotColor: Colors.white,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        widget.item.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final List<Widget> buttons = [
      _buildSvgButton('assets/icons/button_icons/audio.svg', 'Reproducir audio', _speakDescription),
    ];

    // Solo agrega el botón de VR si modeUrl no es null ni está vacío
    if (widget.item.modeUrl != null && widget.item.modeUrl!.trim().isNotEmpty) {
      buttons.add(
        _buildSvgButton('assets/icons/button_icons/vr.svg', 'VR', () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ARModelViewer(
                modelUrl: widget.item.modeUrl!,
                title: widget.item.title,
              ),
            ),
          );
        }),
      );
    }

    final lat = widget.item.latitud;
    final lng = widget.item.longitud;

    final hasValidCoordinates = lat != null && lng != null && lat != 0.0 && lng != 0.0;

    if (hasValidCoordinates) {
      buttons.add(
        _buildSvgButton('assets/icons/button_icons/mapa.svg', 'Mapa', () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NavigatorBarView(
                initialIndex: 2,
                latitude: lat,
                longitude: lng,
              ),
            ),
          );
        }),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: buttons,
      ),
    );
  }

  Widget _buildExpandableDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AnimatedCrossFade(
        crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
        firstChild: _buildDescriptionText(maxLines: 4),
        secondChild: _buildDescriptionText(),
      ),
    );
  }

  Widget _buildReadMoreButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              setState(() => _expanded = !_expanded);
            },
            child: Text(
              _expanded ? 'Leer menos' : 'Leer más',
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSvgButton(String assetPath, String label, Function()? onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      icon: SvgPicture.asset(
        assetPath,
        width: 20,
        height: 20,
      ),
      label: Text(label),
    );
  }

  Widget _buildDescriptionText({int? maxLines}) {
    return Text(
      widget.item.description,
      // style: const TextStyle(
      //   color: Colors.white,
      // ),
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
    );
  }

  Widget _buildBackButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 37,
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            'assets/icons/button_icons/izquierdo.svg',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
