// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../1.CONFIG/Core/utils/enum_category_type.dart';
import '../../../Data/datasources/Local Datasource/place_local_datasource.dart';
import '../../../Domain/entities/tourist_visita_entity.dart';
import '../../widgets/1.Details_View/details_view_widget.dart';
import '../../widgets/2.Search_View/search_view.dart';
import '../tour_guide_view.dart';
import 'components/bottom_info_card.dart';

class MapsView extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const MapsView({super.key, this.latitude, this.longitude});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  CategoryType? _selectedCategory;
  bool _isLoading = false;
  TouristVisitaEntity? selectedPlace;

  static const LatLng _sanIgnacio = LatLng(-5.1436, -79.0001);
  String? currentTTS; // Para guardar el texto que se leerá
  bool isSatelliteView = false; // Controla el tipo de mapa

  @override
  void initState() {
    super.initState();
    _loadMarkers(); // carga todos al inicio
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  void _loadMarkers({CategoryType? filter}) async {
    setState(() => _isLoading = true);

    final filteredPlaces =
        filter == null ? allPlaces : allPlaces.where((place) => place.locationType == filter).toList();

    final newMarkers = filteredPlaces.where((place) => place.latitud != null && place.longitud != null).map((place) {
      return Marker(
        markerId: MarkerId(place.id),
        position: LatLng(place.latitud!, place.longitud!),
        infoWindow: InfoWindow(title: place.title),
        onTap: () {
          setState(() {
            currentTTS = place.description;
            selectedPlace = place;
          });
        },
      );
    }).toSet();

    await Future.delayed(const Duration(milliseconds: 500)); // Simula carga

    setState(() {
      _markers = newMarkers;
      _isLoading = false;
    });

    // Solo centrar en el primer marcador si NO se pasó latitud y longitud por parámetros
    if (_markers.isNotEmpty && widget.latitude == null && widget.longitude == null) {
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_markers.first.position, 15),
      );
    } else if (_markers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No hay lugares con coordenadas disponibles', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          elevation: 8,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _centerOnSanIgnacio() async {
    await mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_sanIgnacio, 13.5),
    );
  }

  void _toggleMapType() {
    setState(() {
      isSatelliteView = !isSatelliteView;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    if (widget.latitude != null && widget.longitude != null) {
      final selectedLatLng = LatLng(widget.latitude!, widget.longitude!);

      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(selectedLatLng, 15), // Asegúrate de incluir zoom también aquí
      );

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId("selected_location"),
            position: selectedLatLng,
            infoWindow: const InfoWindow(title: "Ubicación seleccionada"),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _sanIgnacio,
                zoom: 12.5,
              ),
              mapType: isSatelliteView ? MapType.satellite : MapType.normal,
              markers: _markers,
              myLocationEnabled: true,
              onMapCreated: _onMapCreated,
              onTap: (_) {
                setState(() {
                  selectedPlace = null;
                });
              },
            ),

            // 🔍 Buscador + Filtro
            Positioned(
              top: 5,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buscadorMoreIcon(context),
                  ),
                  const SizedBox(height: 10),
                  _filtroCategorias(),
                ],
              ),
            ),

            // 🌀 Loader mientras carga markers
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.green),
              ),

            // 📍 Botón centrar en San Ignacio
            Positioned(
              bottom: 30,
              left: 16,
              child: FloatingActionButton(
                onPressed: _centerOnSanIgnacio,
                backgroundColor: Colors.white,
                child: const Icon(Icons.my_location, color: Colors.black),
              ),
            ),

            Positioned(
              bottom: 100,
              left: 16,
              child: FloatingActionButton(
                onPressed: _toggleMapType,
                backgroundColor: Colors.white,
                child: Icon(
                  isSatelliteView ? Icons.map : Icons.satellite,
                  color: Colors.black,
                ),
              ),
            ),

            // Muestra la tarjeta inferior si se seleccionó un marcador
            if (selectedPlace != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomInfoCard(
                  place: selectedPlace!,
                  onClose: () {
                    setState(() => selectedPlace = null);
                  },
                  onTap: () {
                    // Aquí navegas a la vista de detalles, reemplaza esto por tu navegación real
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsViewWidget(item: selectedPlace!),
                        ));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _filtroCategorias() {
    final categorias = [
      {'icon': 'assets/icons/others/turistas.svg', 'label': 'Lugares Turisticos', 'type': CategoryType.visitas},
      {'icon': 'assets/icons/others/hotel_persona.svg', 'label': 'Hoteles', 'type': CategoryType.hoteles},
      {'icon': 'assets/icons/others/entradas.svg', 'label': 'Restaurantes', 'type': CategoryType.restaurantes},
    ];

    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: categorias.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final cat = categorias[index];
          final isSelected = _selectedCategory == cat['type'];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = cat['type'] as CategoryType?;
                _loadMarkers(filter: _selectedCategory);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "${cat['icon']}",
                    width: 18,
                    height: 18,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${cat['label']}",
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buscadorMoreIcon(BuildContext context) {
    return Row(
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

        // 👑 Corona
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
    );
  }
}
