import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../1.CONFIG/Core/utils/shared/local_storage.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(_loadTheme());

  static bool _loadTheme() {
    return LocalStorage.prefs.getBool('isDarkMode') ?? true; // Modo oscuro por defecto
  }

  void toggleTheme() {
    final bool newTheme = !state;
    emit(newTheme);
    LocalStorage.prefs.setBool('isDarkMode', newTheme);
  }
}
