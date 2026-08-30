import 'package:flutter/material.dart';

import '../intro_card.dart';

class AcercaDelFundadorView extends StatelessWidget {
  final String categoryName;
  final String categoryDescription;

  const AcercaDelFundadorView({
    super.key,
    required this.categoryName,
    required this.categoryDescription,
  });

  @override
  Widget build(BuildContext context) {
    final integrante = {
      'nombre': 'Fabricio Raúl Ricapa Pérez Roca',
      'rol': 'Fundador y Desarrollador Flutter',
      'imagenUrl':
          'https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/Integrantes%2Ffabricio.jpeg?alt=media&token=85915e7e-c83c-4512-8835-304d48bd91d0',
    };

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
            const SizedBox(height: 10),

            // 🔹 Tarjeta del fundador
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(integrante['imagenUrl'] ?? ''),
                        backgroundColor: Colors.grey[300],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              integrante['nombre'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              integrante['rol'] ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 🔹 Apartado informativo con más “floro”
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sobre el Fundador",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Fabricio Ricapa tiene 16 años, estudiante del Tito Cusy Yupanqui, apasionado por la tecnología y el desarrollo de software. "
                    "Con esta aplicación, buscó combinar esos intereses con algo mucho más cercano a su corazón: su tierra, San Ignacio.",
                    style: TextStyle(
                      color: Colors.grey[300],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "La idea de crear una app turística nació al notar que San Ignacio tiene un enorme potencial, pero muy poca difusión digital. "
                    "A través de esta plataforma, busca mostrar sus paisajes, su cultura y su gente, impulsando el turismo local con ayuda de la tecnología.",
                    style: TextStyle(
                      color: Colors.grey[300],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Hoy, este proyecto representa el esfuerzo que cree en el poder de las ideas y la tecnología para transformar realidades. "
                    "SILFY es más que una app: es una propuesta creada con orgullo, visión y compromiso con San Ignacio.",
                    style: TextStyle(
                      color: Colors.grey[300],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
