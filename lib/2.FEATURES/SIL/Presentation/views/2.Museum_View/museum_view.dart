import 'package:flutter/material.dart';

import '../../../Data/datasources/Local Datasource/place_local_datasource.dart';
import '../../widgets/get_horizontal_item_slider.dart';
import '../../widgets/name_icon_top_widget.dart';
import '../../widgets/selection_title.dart';
import '../../widgets/video_widget.dart';

class MuseumView extends StatelessWidget {
  const MuseumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 📝 Name + Icono corona.
              const NameIconTopWidget(title: "Museo Los Faicales"),
              const SizedBox(height: 20),
              // 🌇 Video Introducción museo.
              const VideoWidget(videoId: "QCQAkPDTRCw"),

              ///PIEZAS REPRESENTATIVAS
              const SectionTitle(text: "Piezas Representativas"),
              GetHorizontalItemSlider(museoPiezasRepresentativasLocalDatasource),

              ///PIEZAS DE CERAMICA
              const SectionTitle(text: "Piezas de Cerámica"),
              GetHorizontalItemSlider(museoPiezasCeramicaLocalDatasource),

              ///PIEZAS LITICAS
              const SectionTitle(text: "Piezas Liticas"),
              GetHorizontalItemSlider(museoPiezasLiticasLocalDatasoruce),

              ///RELLENO
              const SizedBox(height: 30),
              finalMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget finalMessage() {
    return const Column(
      children: [
        Text(
          // "With 💙 for all Perú",
          "With 💚 for all San Ignacio",
          style: TextStyle(
            // fontSize: 13,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
