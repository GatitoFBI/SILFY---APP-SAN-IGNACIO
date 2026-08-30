// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../1.CONFIG/Core/constants/app_constants.dart';
import '5.Account_View/components/contact_us_button_component.dart';

class TourGuideScreen extends StatelessWidget {
  const TourGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            HeaderImageWithTitle(),
            IncludedServicesSection(),
            PackagesSection(),
            PromotionSection(),
            ContactUsButton(
                linkmessage:
                    "https://wa.me/51984531531?text=¡Hola!%20Estoy%20interesado%20en%20los%20paquetes%20de%20turismo.%20¿Podrías%20darme%20más%20información%3F"),
          ],
        ),
      ),
    );
  }
}

class HeaderImageWithTitle extends StatelessWidget {
  const HeaderImageWithTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/sil.png',
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            'Descubre San Ignacio\ncomo nunca antes',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 8, color: Colors.black)],
            ),
          ),
        ),
      ],
    );
  }
}

class IncludedServicesSection extends StatelessWidget {
  const IncludedServicesSection({super.key});

  final List<Map<String, String>> items = const [
    {'icon': 'assets/icons/others/turistas.svg', 'text': 'Lugares turísticos'},
    {'icon': 'assets/icons/others/movilidad.svg', 'text': 'Movilidad incluida'},
    {'icon': 'assets/icons/others/entradas.svg', 'text': 'Entradas a sitios'},
    {'icon': 'assets/icons/others/museo_pieza.svg', 'text': 'Museo Los Faicales'},
    {'icon': 'assets/icons/others/hotel_persona.svg', 'text': 'Hoteles y restaurantes'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: items.map((item) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                item['icon']!,
                height: 40,
                color: AppConstants.primaryColor,
              ),
              const SizedBox(height: 4),
              Text(item['text']!, textAlign: TextAlign.center),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class PackagesSection extends StatelessWidget {
  const PackagesSection({super.key});

  final List<Map<String, dynamic>> packages = const [
    {
      'title': 'Paquete 1: Juegos Extremos + Catarata + Laguna Azul',
      'includes': [
        'Hotel 2 noches',
        'Movilidad permanente',
        'Recojo para los tours en su hotel',
        'Desayuno Café en el Cielo',
        'Entrada a los sitios turísticos',
        'Guia turístico',
        'Laguna Azul de Huarango'
      ],
      'image': 'assets/images/lugares/cerro_campana.jpg',
    },
    // {
    //   'title': 'Paquete 2: Facial + Cerro Campana',
    //   'includes': [
    //     'Movilidad',
    //     'Snacks',
    //     'Entradas turísticas',
    //     'Cerro Campana en la noche',
    //     'Recomendaciones locales',
    //     'Recorrido personalizado'
    //   ],
    //   'image': 'assets/images/lugares/faical_pinturas.png',
    // },
    {
      'title': 'Paquete Personalizado: Tú eliges la aventura',
      'includes': [
        'Elige tus destinos favoritos',
        'Te asesoramos y cotizamos a medida',
        'Incluye movilidad y entradas si lo deseas',
        'Ideal para grupos, parejas o familias',
        'Recomendaciones locales exclusivas',
        'Atención personalizada vía WhatsApp'
      ],
      'image': 'assets/images/lugares/cerro_campana_2.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: packages.map((pkg) {
        return Card(
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    pkg['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pkg['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...pkg['includes'].map<Widget>((e) => Text('• $e')).toList(),
                  ],
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}

class PromotionSection extends StatelessWidget {
  const PromotionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDFFFE2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.card_giftcard, color: Colors.green, size: 28),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Promoción por tiempo limitado!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Algunos paquetes suelen estar en descuento 🤩',
                  style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
