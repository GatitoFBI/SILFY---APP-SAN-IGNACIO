import '../../../../1.CONFIG/Core/utils/enum_category_type.dart';
import '../../../../1.CONFIG/Core/utils/enum_social_media_type.dart';

class TouristVisitaEntity {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final bool isRecommended;
  final String? phoneNumber;
  final CategoryType locationType;
  final List<String> imagePaths;
  final Map<EnumSocialMediaType, String>? socialMediaLinks;
  final List<Map<String, String>> infoItems;
  //*Nuevos campos:
  final double? latitud;
  final double? longitud;
  final String? modeUrl;

  TouristVisitaEntity({
    required this.id,
    required this.imagePaths,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.locationType,
    required this.infoItems,
    this.isRecommended = false,
    this.phoneNumber,
    this.socialMediaLinks,
    this.latitud,
    this.longitud,
    this.modeUrl,
  });
}
