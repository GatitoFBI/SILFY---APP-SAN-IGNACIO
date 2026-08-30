import 'package:flutter_tts/flutter_tts.dart';

class TTSHelper {
  // Crea una instancia única y privada de FlutterTts.
  static final FlutterTts _flutterTts = FlutterTts();

  // Método estático para hablar un texto en voz alta.
  static Future<void> speak(String text) async {
    // Configura el idioma en español de España. Puedes cambiar a "es-MX" o "es-PE" si lo deseas.
    await _flutterTts.setLanguage("es-ES");

    // Configura el tono de la voz. 1 es el tono normal.
    await _flutterTts.setPitch(1);

    // Configura la velocidad del habla. 0.5 es más lento (más fácil de entender).
    // await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setSpeechRate(0.7);

    // Reproduce en voz alta el texto recibido como parámetro.
    await _flutterTts.speak(text);
  }

  // Método para detener cualquier reproducción de voz en curso.
  static Future<void> stop() async {
    await _flutterTts.stop();
  }
}
