import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../Domain/entities/tourist_visita_entity.dart';
import '../../../widgets/1.Details_View/details_view_widget.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/place_item_widget.dart';

class CategoryItemsScreen extends StatelessWidget {
  final List<TouristVisitaEntity> items;
  final String categoryName;

  const CategoryItemsScreen({
    super.key,
    required this.items,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: AppText(
            text: categoryName,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20, //Vertical
          crossAxisSpacing: 20, //Horizontal
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              child: PlaceItemWidget(
                item: item,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsViewWidget(
                    item: item,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
