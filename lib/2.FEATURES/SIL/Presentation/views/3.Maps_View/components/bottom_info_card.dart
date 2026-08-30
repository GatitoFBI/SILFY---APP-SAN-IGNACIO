import 'package:flutter/material.dart';

import '../../../../Domain/entities/tourist_visita_entity.dart';

class BottomInfoCard extends StatelessWidget {
  final TouristVisitaEntity place;
  final VoidCallback onClose;
  final VoidCallback onTap;

  const BottomInfoCard({
    required this.place,
    required this.onClose,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        child: Row(
          children: [
            // Imagen de muestra si tienes una
            if (place.imagePaths.isNotEmpty && place.imagePaths.first.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(place.imagePaths.first, width: 60, height: 60, fit: BoxFit.cover),
              )
            else
              const Icon(Icons.place, size: 60, color: Colors.grey),

            const SizedBox(width: 12),
            // Título y breve descripción
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    place.description.length > 50 ? '${place.description.substring(0, 50)}...' : place.description,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Botón cerrar
            IconButton(
              icon: const Icon(Icons.close, color: Colors.redAccent),
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }
}
