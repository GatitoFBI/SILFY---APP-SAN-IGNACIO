import 'package:equatable/equatable.dart';

import '../../../../Data/datasources/Local Datasource/place_local_datasource.dart';
import '../../../../Domain/entities/tourist_visita_entity.dart';

class CategoryItem extends Equatable {
  final int? id;
  final String name;
  final String imagePath;
  final List<TouristVisitaEntity> listItems;

  const CategoryItem({this.id, required this.name, required this.imagePath, required this.listItems});

  @override
  List<Object?> get props => [id, name, imagePath];
}

var categoryItems = [
  CategoryItem(
    name: "Visitas Obligatorias",
    imagePath: "assets/images/categories/turismo.png",
    listItems: visitasLocalDataSource,
  ),
  CategoryItem(
    name: "Hospedajes",
    imagePath: "assets/images/categories/hotel.png",
    listItems: hotelesLocalDataSource,
  ),
  CategoryItem(
    name: "Restaurantes y Cafeterías",
    imagePath: "assets/images/categories/restaurante.png",
    listItems: restaurantesLocalDataSource,
  ),
  CategoryItem(
    name: "Festividades",
    imagePath: "assets/images/categories/festividades.png",
    listItems: festividadesLocalDataSource,
  ),
  CategoryItem(
    name: "Platos Típicos",
    imagePath: "assets/images/categories/comidas.png",
    listItems: platosTipicosLocalDataSource,
  ),
  CategoryItem(
    name: "Museo Los Faicales",
    imagePath: "assets/images/categories/museo.png",
    listItems: [
      ...museoPiezasCeramicaLocalDatasource,
      ...museoPiezasLiticasLocalDatasoruce,
      ...museoPiezasRepresentativasLocalDatasource,
    ],
  ),
];
