import 'package:flutter/material.dart';

import '../../../../widgets/app_text.dart';
import '../../../../widgets/bottom_audio_player.dart';
import '../../../../widgets/full_screen_image_viewer.dart';
import '../intro_card.dart';

class CuestionesFrecuentesView extends StatefulWidget {
  final String categoryName;
  final String categoryDescription;
  final List<Map<String, String>> cuestiones;

  const CuestionesFrecuentesView({
    super.key,
    required this.categoryName,
    required this.categoryDescription,
    required this.cuestiones,
  });

  @override
  State<CuestionesFrecuentesView> createState() => _CuestionesFrecuentesViewState();
}

class _CuestionesFrecuentesViewState extends State<CuestionesFrecuentesView> {
  String? currentTTS;

  void startTTS(String text) {
    setState(() {
      currentTTS = text;
    });
  }

  void stopTTS() {
    setState(() {
      currentTTS = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntroCard(
                title: widget.categoryName,
                description: widget.categoryDescription,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: widget.cuestiones.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final cuestiones = widget.cuestiones[index]['cuestion1'] ?? 'No hay resultado';
                    final respuesta = widget.cuestiones[index]['cuestion2'] ?? 'No hay resultado';
                    final imageUrl = widget.cuestiones[index]['imagen'];

                    return CuestionTile(
                      cuestion: cuestiones,
                      respuesta: respuesta,
                      imageUrl: imageUrl,
                      index: index,
                      onTTS: startTTS,
                    );
                  },
                ),
              ),
            ],
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
    );
  }
}

class CuestionTile extends StatelessWidget {
  final String cuestion;
  final String respuesta;
  final String? imageUrl;
  final int index;
  final Function(String) onTTS;

  const CuestionTile({
    super.key,
    required this.cuestion,
    required this.respuesta,
    required this.imageUrl,
    required this.index,
    required this.onTTS,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: AppText(
            text: cuestion,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: respuesta,
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(height: 8),
                  if (imageUrl != null)
                    GestureDetector(
                      child: Hero(
                        tag: 'cuestion-image-$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageUrl!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Text('No se pudo cargar la imagen.'),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) => FullscreenImageViewer(
                              imageUrls: [imageUrl!],
                              initialIndex: 0,
                              heroTag: 'cuestion-image-$index',
                            ),
                          ),
                        );
                      },
                    ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.volume_up_rounded),
                        onPressed: () => onTTS(respuesta),
                        tooltip: 'Leer en voz alta',
                      ),
                      const Text('Escuchar respuesta'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
