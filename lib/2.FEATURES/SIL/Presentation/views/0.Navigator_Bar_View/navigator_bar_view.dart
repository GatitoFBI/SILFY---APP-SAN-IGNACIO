import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../1.CONFIG/Core/constants/app_constants.dart';
import '../zviews.dart';
import 'components/anuncios_esponsors.dart';
import 'components/navigator_item.dart';

class NavigatorBarView extends StatefulWidget {
  final int initialIndex;
  final double? latitude;
  final double? longitude;

  const NavigatorBarView({
    super.key,
    this.initialIndex = 0,
    this.latitude,
    this.longitude,
  });

  @override
  NavigatorBarViewState createState() => NavigatorBarViewState();
}

class NavigatorBarViewState extends State<NavigatorBarView> {
  late int currentIndex;
  bool _hasShownDialog = false;
  // final anuncio = anunciosEsponsors[Random().nextInt(anunciosEsponsors.length)];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _showDialogOnce();
  }

  // Este método comprueba si es la primera vez que se abre la app
  void _showDialogOnce() {
    if (!_hasShownDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showWelcomeDialog(context);
      });
      _hasShownDialog = true;
    }
  }

  // Muestra el diálogo
  void _showWelcomeDialog(BuildContext context) {
    final anuncio = anunciosEsponsors[Random().nextInt(anunciosEsponsors.length)];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 Imagen
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  anuncio.imagenUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: 180,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade400),
                          strokeWidth: 2.5,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 180,
                      child: Center(
                        child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),

              // 🔹 Contenido
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      anuncio.nombre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🔹 DIRECCIÓN
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, size: 18, color: Colors.teal),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            anuncio.direccion,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // 🔹 NÚMERO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone, size: 18, color: Colors.teal),
                        const SizedBox(width: 6),
                        Text(
                          anuncio.numero,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // 🔹 DESCRIPCIÓN
                    Text(
                      anuncio.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // 🔹 Botón Cerrar
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0, bottom: 12.0),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cerrar",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigatorItems = [
      NavigatorItem("Explore", "assets/icons/navigator_icons/explore_icon.svg", 0, const ExplorerView()),
      NavigatorItem("Museum", "assets/icons/navigator_icons/museum.svg", 1, const MuseumView()),
      NavigatorItem(
        "Maps",
        "assets/icons/navigator_icons/mapa.svg",
        2,
        MapsView(
          latitude: widget.latitude,
          longitude: widget.longitude,
        ),
      ),
      NavigatorItem("Favourite", "assets/icons/navigator_icons/favourite_icon.svg", 3, const FavouriteView()),
      NavigatorItem("Account", "assets/icons/navigator_icons/account_icon.svg", 4, const AccountView()),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: navigatorItems[currentIndex].screen,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 37,
              offset: const Offset(0, -12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppConstants.primaryColor,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedItemColor: Colors.black,
            items: navigatorItems.map((e) {
              return getNavigationBarItem(label: e.label, index: e.index, iconPath: e.iconPath);
            }).toList(),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem getNavigationBarItem({required String label, required String iconPath, required int index}) {
    final Color iconColor = index == currentIndex ? AppConstants.primaryColor : Colors.black;
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        iconPath,
        // ignore: deprecated_member_use
        color: iconColor,
      ),
    );
  }
}
