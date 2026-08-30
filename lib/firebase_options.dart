import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClfIPHY1zNZUPNojp9JUIXMwcMYDCghkg',
    appId: '1:1067374039143:android:cc95320488c0e1c34404c2',
    messagingSenderId: '1067374039143',
    projectId: 'sil-project-32aca',
    storageBucket: 'sil-project-32aca.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCtvBO2p0LAvQ_lTj4PvZwIoq49vPy0-E4',
    appId: '1:1067374039143:web:6e649b265fcf00b54404c2',
    messagingSenderId: '1067374039143',
    projectId: 'sil-project-32aca',
    authDomain: 'sil-project-32aca.firebaseapp.com',
    storageBucket: 'sil-project-32aca.firebasestorage.app',
    measurementId: 'G-GFFS1XWDZP',
  );
}
