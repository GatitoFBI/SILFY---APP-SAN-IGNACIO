// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Domain/entities/tourist_visita_entity.dart';
import '../../views/1.Explorer_View/components/category_items_screen.dart';
import '../../views/tour_guide_view.dart';
import '../1.Details_View/details_view_widget.dart';
import '../horizontal_item.dart';
import '../video_widget.dart';
import 'components/category_item_card_widget.dart';
import 'components/category_items_local_datasource.dart';

List<Color> gridColors = [
  const Color(0xff53B175),
  const Color(0xffF8A44C),
  const Color(0xffF7A593),
  const Color(0xffD3B0E0),
  const Color(0xffFDE598),
  const Color(0xffB7DFF5),
  const Color(0xff836AF6),
  const Color(0xffD73B77),
];

class SearchView extends StatefulWidget {
  final List<TouristVisitaEntity> allPlaces;

  const SearchView({super.key, required this.allPlaces});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final results = widget.allPlaces.where((place) => place.title.toLowerCase().contains(query.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.travel_explore, color: Colors.white54),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            onChanged: (value) => setState(() => query = value),
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Encuentre destinos en todo san ignacio",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Material(
                  color: const Color(0xffEDB440),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const TourGuideScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const beginOffset = Offset(0.0, 1.0);
                            const endOffset = Offset.zero;
                            const curve = Curves.easeOut;

                            final tween = Tween(begin: beginOffset, end: endOffset).chain(CurveTween(curve: curve));
                            final fadeTween = Tween<double>(begin: 0.0, end: 1.0);

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: FadeTransition(
                                opacity: animation.drive(fadeTween),
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/icons/button_icons/corona.svg",
                          color: Colors.black,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // body: query.isEmpty
      //     ? getStaggeredGridView(context: context)
      //     : results.isNotEmpty
      //         ? ListView.builder(
      //             itemCount: results.length,
      //             itemBuilder: (_, index) => GestureDetector(
      //               child: HorizontalItem(item: results[index]),
      //               onTap: () => Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (_) => DetailsViewWidget(
      //                     item: results[index],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           )
      //         : getStaggeredGridView(context: context),
      body: query.isEmpty
          ? getStaggeredGridView(context: context)
          : query.toLowerCase().trim() == "fabricio ricapa"
              ? secretView()
              : results.isNotEmpty
                  ? ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (_, index) => GestureDetector(
                        child: HorizontalItem(item: results[index]),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsViewWidget(
                              item: results[index],
                            ),
                          ),
                        ),
                      ),
                    )
                  : getStaggeredGridView(context: context),
    );
  }

  Widget getStaggeredGridView({required BuildContext context}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0,
        children: categoryItems.asMap().entries.map<Widget>((e) {
          final int index = e.key;
          final CategoryItem categoryItem = e.value;
          return GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: CategoryItemCardWidget(
                item: categoryItem,
                color: gridColors[index % gridColors.length],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoryItemsScreen(
                    categoryName: categoryItem.name,
                    items: categoryItem.listItems,
                  );
                },
              ));
            },
          );
        }).toList(), // add some space
      ),
    );
  }

  Widget secretView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "🌟 Sobre mí",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Imagen de Fabricio
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/Integrantes%2Ffabricio.jpeg?alt=media&token=85915e7e-c83c-4512-8835-304d48bd91d0',
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          // Biografía
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("👨‍💻 Biografía", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    "Soy Fabricio Ricapa, actualmente tengo 16 años, estoy a punto de culminar la secundaria y tengo grandes sueños por delante. Desde los 14 años he estado aprendiendo a programar; mi primer lenguaje fue C#. Luego, me aventuré a crear aplicaciones con Flutter y Dart. Me encanta la sensación de estar construyendo algo bueno. Cada día doy un paso más hacia mis metas.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Sueños y metas
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🚀 Sueños y metas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    "- Aprender Flutter a un nivel avanzado.\n"
                    "- Construir una app que ayude a millones.\n"
                    "- Crear mi aplicación personal (Mondragon o Cursovid).\n"
                    "- Nunca perder la motivación y seguir aprendiendo cada día.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Proceso personal
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("📈 Mi proceso", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    "He aprendido desde cero varias cosas mientras estudio y hago mis proyectos. Cada reto es una oportunidad de crecer y mejorar, y no pienso rendirme hasta lograr mis sueños.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Video
          const Text(
            "🎥 Un mensaje especial",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          //TODO: Poner video de Fabricio
          const VideoWidget(videoId: "NZMoc9G4YwE"),

          const SizedBox(height: 24),
          const Text(
            "Gracias por descubrir este rincón secreto 👀",
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
