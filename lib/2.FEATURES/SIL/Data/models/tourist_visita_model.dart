import 'dart:convert';

import '../../../../1.CONFIG/Core/utils/enum_category_type.dart';
import '../../../../1.CONFIG/Core/utils/enum_social_media_type.dart';
import '../../Domain/entities/tourist_visita_entity.dart';

class TouristVisitaModel {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final int isRecommended; // 1 = true, 0 = false
  final int locationType; // Usando el valor entero del enum
  final String? phoneNumber;
  final String imagePathsJson; // Lista como JSON string
  final String? socialMediaLinksJson; // Mapa como JSON string
  final String infoItemsJson; // Lista de mapas como JSON string
  final double? latitud;
  final double? longitud;
  final String? modeUrl;

  TouristVisitaModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.isRecommended,
    required this.locationType,
    this.phoneNumber,
    required this.imagePathsJson,
    this.socialMediaLinksJson,
    required this.infoItemsJson,
    this.latitud,
    this.longitud,
    this.modeUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'isRecommended': isRecommended,
      'locationType': locationType,
      'phoneNumber': phoneNumber,
      'imagePaths': imagePathsJson,
      'socialMediaLinks': socialMediaLinksJson,
      'infoItems': infoItemsJson,
      'latitud': latitud,
      'longitud': longitud,
      'modeUrl': modeUrl,
    };
  }

  static TouristVisitaModel fromMap(Map<String, dynamic> map) {
    return TouristVisitaModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      videoUrl: map['videoUrl'],
      isRecommended: map['isRecommended'],
      locationType: map['locationType'],
      phoneNumber: map['phoneNumber'],
      imagePathsJson: map['imagePaths'],
      socialMediaLinksJson: map['socialMediaLinks'],
      infoItemsJson: map['infoItems'],
      latitud: map['latitud'] != null ? map['latitud'] as double : null,
      longitud: map['longitud'] != null ? map['longitud'] as double : null,
      modeUrl: map['modeUrl'],
    );
  }

  TouristVisitaEntity toEntity() {
    return TouristVisitaEntity(
      id: id,
      title: title,
      description: description,
      videoUrl: videoUrl,
      isRecommended: isRecommended == 1,
      locationType: CategoryType.values[locationType],
      phoneNumber: phoneNumber,
      imagePaths: List<String>.from(json.decode(imagePathsJson)),
      socialMediaLinks: socialMediaLinksJson != null
          ? Map<EnumSocialMediaType, String>.from(
              (json.decode(socialMediaLinksJson!) as Map<String, dynamic>).map(
                (key, value) => MapEntry(
                  EnumSocialMediaType.values.firstWhere(
                    (e) => e.toString() == 'EnumSocialMediaType.$key',
                    orElse: () => EnumSocialMediaType.values.first, // fallback seguro
                  ),
                  value,
                ),
              ),
            )
          : null,
      infoItems: _parseInfoItems(infoItemsJson),
      latitud: latitud,
      longitud: longitud,
      modeUrl: modeUrl,
    );
  }

  /// Método privado para parsear infoItems seguro
  List<Map<String, String>> _parseInfoItems(String jsonString) {
    try {
      final decoded = json.decode(jsonString);

      if (decoded is List) {
        return decoded.map<Map<String, String>>((item) {
          if (item is Map<String, dynamic>) {
            final title = item['title']?.toString() ?? 'Título desconocido';
            final value = item['value']?.toString() ?? 'Valor desconocido';
            return {title: value};
          }
          return {'Error': 'Formato incorrecto'};
        }).toList();
      } else {
        return [
          {'Error': 'No es una lista'}
        ];
      }
    } catch (e) {
      // Si algo falla (ej: JSON mal formado)
      return [
        {'Error': 'Error al parsear'}
      ];
    }
  }

  /// Este método crea un modelo desde una entidad (muy útil)
  factory TouristVisitaModel.fromEntity(TouristVisitaEntity entity) {
    return TouristVisitaModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      videoUrl: entity.videoUrl,
      isRecommended: entity.isRecommended ? 1 : 0,
      locationType: entity.locationType.index,
      phoneNumber: entity.phoneNumber,
      imagePathsJson: json.encode(entity.imagePaths),
      socialMediaLinksJson: entity.socialMediaLinks != null
          ? json.encode(entity.socialMediaLinks!.map((key, value) => MapEntry(key.name, value)))
          : null,
      // Codifica correctamente los items de información
      infoItemsJson: json.encode(entity.infoItems.map((item) {
        final key = item.keys.first;
        final value = item[key];
        return {
          'title': key,
          'value': value,
        };
      }).toList()),
      latitud: entity.latitud,
      longitud: entity.longitud,
      modeUrl: entity.modeUrl,
    );
  }
}
