import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '1.CONFIG/Core/utils/shared/local_storage.dart';
import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('🚨 Flutter Error: ${details.exception}');
    debugPrint('📄 Stack trace:\n${details.stack}');
  };

  // Mostrar errores detallados en consola
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('🔥 ${details.exceptionAsString()}');
    debugPrintStack(stackTrace: details.stack);
  };

  //?init Firebase:
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //?init Preferences:
  await LocalStorage.initPrefs();

  runApp(const MyApp());
}
