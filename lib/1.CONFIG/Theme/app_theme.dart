import 'package:flutter/material.dart';

import '../Core/constants/app_constants.dart';

String fontFamilText = "Gilroy";

class AppTheme {
  //? Método o getter para los temas:

  static ThemeData get themeLight {
    return ThemeData(
      fontFamily: fontFamilText,
      useMaterial3: true,
      colorSchemeSeed: AppConstants.primaryColor,
      brightness: Brightness.light,
      //* Ajustes adicionales del tema claro aquí.
    );
  }

  static ThemeData get themeDark {
    return ThemeData(
      fontFamily: fontFamilText,
      useMaterial3: true,
      colorSchemeSeed: AppConstants.primaryColor,
      brightness: Brightness.dark,
      //* Ajustes adicionales del tema oscuro aquí.
    );
  }
}
