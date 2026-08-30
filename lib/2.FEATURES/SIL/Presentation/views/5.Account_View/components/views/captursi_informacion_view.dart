import 'package:flutter/material.dart';

import '../contact_us_button_component.dart';
import '../intro_card.dart';

class CaptursiInfoView extends StatelessWidget {
  final String categoryName;
  final String categoryDescription;

  const CaptursiInfoView({
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
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntroCard(
              title: categoryName,
              description: categoryDescription,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/VARIADOS%2FCAPTURSI%2Fcaptursi1.jpg?alt=media&token=53b42808-a0dd-48f4-b7f7-8e3a7f0030d5",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: "Objetivo Institucional",
              content:
                  "Promover el desarrollo sustentable del turismo en la provincia de San Ignacio, estableciendo alianzas con actores del sector a nivel regional, nacional e internacional.",
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/VARIADOS%2FCAPTURSI%2Fcaptursi4.jpg?alt=media&token=155398a7-63ab-45c9-98ec-b7d4fc18b9f0",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: "Nuestra Misión",
              content:
                  "• Organizar cursos, talleres y seminarios de capacitación en calidad de servicio y atención al turista.\n"
                  "• Promover eventos para la promoción del destino turístico San Ignacio y los productos agroindustriales de los asociados.\n"
                  "• Facilitar la participación en ferias regionales y nacionales para posicionar San Ignacio y sus productos.\n"
                  "• Impulsar el turismo sostenible, valorando tradiciones, cultura y recursos naturales.\n"
                  "• Fortalecer la colaboración entre emprendedores, comunidad, instituciones públicas y privadas.",
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/VARIADOS%2FCAPTURSI%2Fcaptursi3.jpg?alt=media&token=4472e7a2-08e4-4734-baa5-5d44d971b56d",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: "Beneficios para los Socios",
              content: "• Promoción de sus servicios y productos a nivel regional, nacional e internacional.\n"
                  "• Participación en eventos nacionales e internacionales.\n"
                  "• Capacitación y desarrollo de capacidades.\n"
                  "• Contactos con empresas privadas e instituciones públicas.\n"
                  "• Respaldo institucional ante instituciones públicas y privadas.",
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/VARIADOS%2FCAPTURSI%2Fcaptursi2.jpg?alt=media&token=0ab7307c-5311-417f-be0c-dd5d9c5f0009",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const ContactUsButton(
              linkmessage:
                  "https://wa.me/51969696563?text=¡Hola!%20Me%20gustaría%20recibir%20información%20sobre%20cómo%20asociarme%20a%20CAPTURSI%20y%20conocer%20los%20beneficios.%20¿Podrían%20orientarme%3F",
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
