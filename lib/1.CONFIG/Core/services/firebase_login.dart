import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "1067374039143-5uqpau6j990f82im0hm4h8vkdkgmrpnv.apps.googleusercontent.com",
  );

  //*~~~~~Iniciar sesión con Google~~~~~*
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      // Guardar que ya inició sesión
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      return userCredential.user;
    } catch (e, stacktrace) {
      debugPrint("Error en signInWithGoogle: $e");
      debugPrint("$stacktrace");
      throw Exception("Error al iniciar sesión con Google: $e");
    }
  }

  //*~~~~~Iniciar sesión como invitado~~~~~*
  Future<User?> signInAsGuest() async {
    try {
      final userCredential = await _auth.signInAnonymously();

      // Guardar que ya inició sesión
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      return userCredential.user;
    } catch (e) {
      throw Exception("Error al iniciar como invitado: $e");
    }
  }

  //*~~~~~Cerrar sesión~~~~~*
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    // Limpiar flag de sesión iniciada
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }

  //*~~~~~Obtener usuario actual~~~~~*
  User? get currentUser => _auth.currentUser;

  ImageProvider getUserImage() {
    final user = _auth.currentUser;
    debugPrint(user?.photoURL);
    if (user == null || user.isAnonymous) {
      return const AssetImage('assets/images/photo.jpg');
    }
    if (user.photoURL != null && user.photoURL!.isNotEmpty) {
      return NetworkImage(user.photoURL!);
    }
    return const AssetImage('assets/images/photo.jpg');
  }
}
