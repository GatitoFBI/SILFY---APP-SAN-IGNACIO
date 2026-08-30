// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../1.CONFIG/Core/services/firebase_cloud.dart';
import '../../../Data/datasources/Local Datasource/place_local_datasource.dart';
import '../../widgets/2.Search_View/search_view.dart';
import '../../widgets/get_horizontal_item_slider.dart';
import '../../widgets/selection_title.dart';
import '../tour_guide_view.dart';
import 'components/category_items_screen.dart';
import 'components/home_banner_widget.dart';

class ExplorerView extends StatelessWidget {
  const ExplorerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 🔍 Buscador + Icono corona.
              _buscadorMoreIcon(context),
              const SizedBox(height: 20),
              // 🌇 Texto principal + clima.
              _fraseMoreClima(context),
              const SizedBox(height: 20),
              // categorias.
              _cardsPromotions(),
              const SizedBox(height: 10),
              const SectionTitle(text: "Visitas obligatorias"),
              GetHorizontalItemSlider(visitasLocalDataSource),
              const SectionTitle(text: "Restaurantes Y Cafeterías"),
              GetHorizontalItemSlider(restaurantesLocalDataSource),
              // const SectionTitle(text: "Video explicativo"),
              // const VideoWidget(videoId: "z0tbQeW6w7c"),
              const SectionTitle(text: "Hoteles"),
              GetHorizontalItemSlider(hotelesLocalDataSource),
              const SectionTitle(text: "Festividades"),
              GetHorizontalItemSlider(festividadesLocalDataSource),
              const SectionTitle(text: "Platos Típicos"),
              GetHorizontalItemSlider(platosTipicosLocalDataSource),
              const SizedBox(height: 30),
              finalMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _fraseMoreClima(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Explora la hermosa\nprovincia de San Ignacio!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: const Color(0xffD9D9D9),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                final weather = await FirebaseCloud().getWeatherData();
                showWeatherDialog(context, weather);
              },
              child: Container(
                width: 50,
                height: 75,
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons/clima.png",
                      width: 33,
                      height: 33,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 4),
                    FutureBuilder<String>(
                      future: FirebaseCloud().getCurrentTemperature(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Error',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                          );
                        } else {
                          return Text(
                            snapshot.data ?? '--°C',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buscadorMoreIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // 🔍 Buscador
          Expanded(
              child: Material(
            color: Colors.transparent, // Necesario para que el ripple funcione
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20), // Para que el ripple respete los bordes redondeados
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, animation, __) => FadeTransition(
                      opacity: animation,
                      child: SearchView(allPlaces: allPlaces),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/button_icons/search.svg",
                      width: 20,
                      height: 20,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        "Encuentre destino, experiencias y mucho más...",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
          const SizedBox(width: 10),
          // 👑 Icono corona
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
    );
  }

  Widget _cardsPromotions() {
    return SizedBox(
      height: 115,
      child: Swiper(
        itemCount: homeBanner.length,
        viewportFraction: 0.85,
        scale: 0.9,
        autoplay: true,
        autoplayDelay: 5000,
        autoplayDisableOnInteraction: true,
        itemBuilder: (BuildContext context, int index) {
          final item = homeBanner[index];
          return GestureDetector(
            child: item,
            onTap: () async {
              if (item.isAd) {
                // 🔗 Si es publicidad → abrir enlace
                final url = Uri.parse(item.adUrl!);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              } else {
                // 🔗 Si es categoría → navegar a pantalla
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CategoryItemsScreen(
                    items: item.listTouristVisitaEntity!,
                    categoryName: item.firtText,
                  );
                }));
              }
            },
          );
        },
      ),
    );
  }

  Widget finalMessage() {
    return const Column(
      children: [
        Text(
          // "With 💙 for all Perú",
          "With 💚 for all San Ignacio",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  void showWeatherDialog(BuildContext context, Map<String, dynamic> weather) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "WeatherDialog",
      barrierColor: Colors.black.withOpacity(0.5), // Fondo semi-transparente
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    weather["location"] ?? "",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.nightlight_round, size: 50),
                  const SizedBox(height: 16),
                  Text(
                    '${weather["currentTemp"]}°C',
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 16),
                  ...List<Map<String, dynamic>>.from(weather["forecast"]).map(
                    (f) => ListTile(
                      title: Text(f["day"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${f["temp"]}°C', style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          const Icon(Icons.cloud),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
