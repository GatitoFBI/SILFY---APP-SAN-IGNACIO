import 'package:flutter/material.dart';

import '../../../../../../1.CONFIG/Core/constants/app_constants.dart';
import '../../../../Data/datasources/Local Datasource/place_local_datasource.dart';
import '../../../../Domain/entities/tourist_visita_entity.dart';
import '../../../widgets/app_text.dart';

var homeBanner = [
  HomeBanner(
    firtText: "Visitas",
    secondText: "Explora y recuerda",
    pathImage: "assets/images/categories/turismo.png",
    color: const Color(0xffF8A44C),
    listTouristVisitaEntity: visitasLocalDataSource,
  ),
  HomeBanner(
    firtText: "Hospedajes",
    secondText: "Viaja y sueña",
    pathImage: "assets/images/categories/hotel.png",
    color: const Color(0xff6BCB77),
    listTouristVisitaEntity: hotelesLocalDataSource,
  ),
  HomeBanner(
    firtText: "Restaurantes",
    secondText: "Aroma y sazón",
    pathImage: "assets/images/categories/restaurante.png",
    color: const Color(0xffF8A44C),
    listTouristVisitaEntity: restaurantesLocalDataSource,
  ),
  // //TODO: Poner anuncio Publicitario A:600 L:250
  // const HomeBanner(
  //   firtText: "",
  //   secondText: "",
  //   pathImage:
  //       "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/Anuncios%20Locales%2Fpublicidad01.jpeg?alt=media&token=a686db36-fd5e-439f-b234-6fad29fad8e6", // tu URL de imagen
  //   adUrl: "https://www.facebook.com/profile.php?id=61575632282424", // link a abrir
  // ),
  HomeBanner(
    firtText: "Festividades",
    secondText: "Alegría que une",
    pathImage: "assets/images/categories/festividades.png",
    color: const Color(0xff6BCB77),
    listTouristVisitaEntity: festividadesLocalDataSource,
  ),
  HomeBanner(
    firtText: "Platos típicos",
    secondText: "Sabores con historia",
    pathImage: "assets/images/categories/comidas.png",
    color: const Color(0xff9D4EDD),
    listTouristVisitaEntity: platosTipicosLocalDataSource,
  ),
];

class HomeBanner extends StatelessWidget {
  final String firtText;
  final String secondText;
  final String pathImage;
  final Color? color;
  final List<TouristVisitaEntity>? listTouristVisitaEntity;
  final String? adUrl; // Para publicidad (si no es null → es anuncio)

  const HomeBanner({
    super.key,
    required this.firtText,
    required this.secondText,
    required this.pathImage,
    this.color = AppConstants.primaryColor,
    this.listTouristVisitaEntity,
    this.adUrl,
  });

  bool get isAd => adUrl != null;

  @override
  Widget build(BuildContext context) {
    if (isAd) {
      // 🔥 Banner de publicidad (solo imagen de internet)
      return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            pathImage,
            width: 350,
            height: 115,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // 🔥 Banner normal (categoría)
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        width: 350,
        height: 115,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: color!.withOpacity(0.25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Image.asset(
                pathImage,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: firtText,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
                AppText(
                  text: secondText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
