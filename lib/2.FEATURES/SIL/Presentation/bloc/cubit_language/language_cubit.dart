import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../1.CONFIG/Core/utils/shared/local_storage.dart';

class LanguageMethodsCubit extends Cubit<String> {
  LanguageMethodsCubit() : super("Español");

  void changeLanguage(String language) {
    emit(language);
    LocalStorage.prefs.setString('language', language);
  }
}
