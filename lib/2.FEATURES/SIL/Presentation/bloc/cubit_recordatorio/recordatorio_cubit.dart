import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../1.CONFIG/Core/utils/shared/local_storage.dart';

class RecordatorioCubit extends Cubit<bool> {
  RecordatorioCubit() : super(_loadRecordatorio());

  static bool _loadRecordatorio() {
    return LocalStorage.prefs.getBool('isRecordatorio') ?? false; // False por defecto
  }

  void toggleRecordatorio() {
    final bool newRecordatorio = !state;
    emit(newRecordatorio);
    LocalStorage.prefs.setBool('isRecordatorio', newRecordatorio);
  }
}
