import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../1.CONFIG/Core/utils/shared/local_storage.dart';

class UsernameCubit extends Cubit<String> {
  UsernameCubit() : super("Cargando...") {
    _initializeUsername();
  }

  Future<void> _initializeUsername() async {
    final savedUsername = LocalStorage.prefs.getString('username');

    if (savedUsername != null && savedUsername.isNotEmpty) {
      emit(savedUsername);
    } else {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.isAnonymous) {
        emit("Cuenta Incógnita");
      } else {
        emit(user.displayName ?? "Cuenta Incógnita");
      }
    }
  }

  void changeUsername(String username) {
    emit(username);
    LocalStorage.prefs.setString('username', username);
  }
}
