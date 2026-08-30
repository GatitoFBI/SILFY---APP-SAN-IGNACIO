// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Domain/entities/tourist_visita_entity.dart';

class ShareButton extends StatelessWidget {
  final TouristVisitaEntity item;

  const ShareButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _shareTouristSpot,
      child: _buildCircleIcon(),
    );
  }

  void _shareTouristSpot() async {
    final costoEntrada = item.infoItems.firstWhere(
      (e) => e.containsKey("Costo entrada:"),
      orElse: () => {"Costo entrada:": "¡Podría ser gratis! Descúbrelo en la app 🎁"},
    )["Costo entrada:"];

    final shortDescription = item.description
        .split(RegExp(r'\s+')) // divide por espacios
        .take(50) // toma las primeras 50 palabras
        .join(' ');

    final shareText = '''
🏞️ ¡Descubre "${item.title}" en San Ignacio!

$shortDescription...

💰 Entrada: $costoEntrada
🎥 Video: https://www.youtube.com/watch?v=${item.videoUrl}

📲 Descarga nuestra app y conoce todos los detalles. ¡Hay mucho más por explorar! 🚀
''';

    final uri = Uri.parse('https://wa.me/?text=${Uri.encodeComponent(shareText)}');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('No se pudo abrir la app para compartir.');
    }
  }

  Widget _buildCircleIcon() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
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
        child: SvgPicture.asset(
          'assets/icons/button_icons/share.svg',
          color: Colors.black,
        ),
      ),
    );
  }
}
