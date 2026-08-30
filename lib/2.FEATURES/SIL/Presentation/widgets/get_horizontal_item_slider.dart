import 'package:flutter/material.dart';

import '../../Domain/entities/tourist_visita_entity.dart';
import '1.Details_View/details_view_widget.dart';
import 'place_item_widget.dart';

class GetHorizontalItemSlider extends StatelessWidget {
  final List<TouristVisitaEntity> items;

  const GetHorizontalItemSlider(
    this.items, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 260,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
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
            child: PlaceItemWidget(
              item: items[index],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 20);
        },
      ),
    );
  }
}
