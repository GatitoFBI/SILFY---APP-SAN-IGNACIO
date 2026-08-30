import 'package:flutter/material.dart';

import '../contact_us_button_component.dart';
import '../intro_card.dart';

class SanIgnacioEmprendeChardinView extends StatelessWidget {
  final String categoryName;
  final String categoryDescription;

  const SanIgnacioEmprendeChardinView({
    super.key,
    required this.categoryName,
    required this.categoryDescription,
  });

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
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntroCard(
              title: categoryName,
              description: categoryDescription,
            ),
            const SizedBox(height: 16),

            // 📸 Imagen del convenio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/VARIADOS%2FCHARDIN%20DE%20SAN%20IGNACIO%20EMPRENDE%2F01.jpg?alt=media&token=489c1cd2-48ef-48f5-88f7-276145279590",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            _buildSection(
              title: "🤝 Convenio de Colaboración",
              content:
                  "Firma de convenio con el programa *San Ignacio Emprende* y Chardin Comunicaciones, con el objetivo de fortalecer la APP Móvil SILFY, mediante la difusión de reportajes y contenidos audiovisuales que promuevan los atractivos turísticos, la cultura y la identidad de la provincia de San Ignacio.",
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/VARIADOS%2FCHARDIN%20DE%20SAN%20IGNACIO%20EMPRENDE%2F03.jpg?alt=media&token=d399f1f1-04ed-4b46-a970-4299c6d91370",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            _buildSection(
              title: "🎯 Objetivo del Convenio",
              content:
                  "El presente convenio tiene como propósito unir esfuerzos para potenciar la promoción turística de San Ignacio a través del uso de reportajes, entrevistas y material audiovisual del programa San Ignacio Emprende, los cuales serán difundidos dentro de la aplicación SILFY.\n\n"
                  "De esta manera, buscamos fortalecer la identidad cultural, impulsar el turismo responsable y resaltar el talento de los emprendedores sanignacinos.",
            ),

            const SizedBox(height: 16),

            _buildSection(
              title: "💡 Aporte de Chardin Comunicaciones",
              content:
                  "Chardin Comunicaciones, dirigido por el comunicador Chardin Mijahuanca Pinzón, aporta su experiencia en diseño gráfico, edición de videos y marketing digital. Gracias a su generosidad, el proyecto SILFY puede hacer uso de todos los reportajes turísticos producidos por San Ignacio Emprende, integrándolos dentro de la app para enriquecer la experiencia del usuario.",
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/VARIADOS%2FCHARDIN%20DE%20SAN%20IGNACIO%20EMPRENDE%2F02.jpg?alt=media&token=d6deb95d-56b9-4f62-9bf1-b597e1beafd5",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            _buildSection(
              title: "📞 Contacto",
              content: "• Chardin Mijahuanca\n"
                  "• Servicios: Diseño gráfico, edición de videos, marketing digital.\n"
                  "• Teléfono: 996 960 146\n"
                  "• Programa: San Ignacio Emprende",
            ),

            const SizedBox(height: 16),

            const ContactUsButton(
              linkmessage:
                  "https://wa.me/51996960146?text=¡Hola!%20Quisiera%20obtener%20más%20información%20sobre%20los%20servicios%20de%20Chardin%20Comunicaciones%20y%20su%20colaboración%20con%20SILFY.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
