// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart' show Color;

class AppConstants {
  // Configuración de la API
  static const String BASE_URL = "https://api.ejemplo.com";
  static const String API_KEY = "1122334455667788";

  // Mensajes comunes
  static const String communErrorMessage = "Ocurrió un error desconocido";
  static const String noInternetMessage = "No hay conexión a Internet";

  // Estilos generales
  static const double extraLarge = 24.0;
  static const double large = 20.0;
  static const double medium = 16.0;
  static const double small = 12.0;

  // Colores principales
  static const Color primaryColor = Color(0xff53B175);
  static const Color seedColorDark = Color(0xFF0D47A1);
  static const Color darkGrey = Color(0xff7C7C7C);
}
