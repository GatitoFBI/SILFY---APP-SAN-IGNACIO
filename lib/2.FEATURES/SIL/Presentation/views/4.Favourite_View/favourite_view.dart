import 'package:flutter/material.dart';

import '../../../../../1.CONFIG/Core/utils/enum_category_type.dart';
import '../../../Data/datasources/Local Datasource/place_local_datasource_sqflite.dart';
import '../../../Domain/entities/tourist_visita_entity.dart';
import '../../widgets/1.Details_View/details_view_widget.dart';
import '../../widgets/horizontal_item.dart';
import '../../widgets/name_icon_top_widget.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Visitas, Hoteles, Restaurantes, Festividades
      initialIndex: 0,
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 📝 Título + Icono Corona
              const NameIconTopWidget(title: "Favoritos"),
              const SizedBox(height: 10),
              // 🔥 TabBar
              TabBar(
                isScrollable: true,
                indicatorColor: Theme.of(context).colorScheme.onSurface,
                indicatorWeight: 0.5,
                labelColor: Theme.of(context).colorScheme.onSurface,
                unselectedLabelColor: Theme.of(context).hintColor,
                tabAlignment: TabAlignment.center,
                indicatorSize: TabBarIndicatorSize.label,
                padding: const EdgeInsets.all(8),
                tabs: const [
                  Tab(text: "Visitas"),
                  Tab(text: "Hoteles"),
                  Tab(text: "Restaurantes"),
                  Tab(text: "Festividades"),
                  Tab(text: "Platos"),
                  Tab(text: "Museo"),
                ],
              ),
              const SizedBox(height: 10),
              // 📦 Tab Views
              Expanded(
                child: TabBarView(
                  children: [
                    _buildFavoriteList(context, CategoryType.visitas),
                    _buildFavoriteList(context, CategoryType.hoteles),
                    _buildFavoriteList(context, CategoryType.restaurantes),
                    _buildFavoriteList(context, CategoryType.festividades),
                    _buildFavoriteList(context, CategoryType.platos),
                    _buildFavoriteList(context, CategoryType.museo),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //* Metodo para renderizar la lista de favoritos según la categoría
  Widget _buildFavoriteList(BuildContext context, CategoryType category) {
    debugPrint('Construyendo lista de favoritos para categoría: ${category.name}');

    return FutureBuilder<List<TouristVisitaEntity>>(
      future: PlaceLocalDataSourceSqflite.getFavoritesByCategory(category),
      builder: (context, snapshot) {
        debugPrint('Snapshot estado: ${snapshot.connectionState}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          debugPrint('Error al cargar favoritos: ${snapshot.error}');
          return const Center(child: Text('Error al cargar los favoritos'));
        }

        final items = snapshot.data ?? [];
        debugPrint('Favoritos cargados: ${items.length}');

        // if (items.isEmpty) {
        //   return const Center(child: Column(
        //     children: [
        //       Text("No tienes ningún favorito en esta categoría."),
        //     ],
        //   ));
        // }
        if (items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border, // Puedes cambiarlo por otro que represente mejor tu categoría
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  "No tienes ningún favorito en esta categoría.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 1),
          itemCount: items.length,
          itemBuilder: (context, index) {
            debugPrint('Renderizando item favorito: ${items[index].title}');
            return Material(
              elevation: 2, // sombra ligera
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsViewWidget(
                        item: items[index],
                      ),
                    ),
                  );
                },
                child: HorizontalItem(
                  item: items[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
