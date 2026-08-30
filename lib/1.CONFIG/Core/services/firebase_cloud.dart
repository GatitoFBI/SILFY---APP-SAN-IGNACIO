import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloud {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //*~~~~~Obtiene los datos del clima desde Firebase~~~~~*
  Future<Map<String, dynamic>> getWeatherData() async {
    try {
      final doc = await _db.collection('weather').doc('iinxRUuV1pDl5Y6hXQzk').get();

      if (doc.exists) {
        final data = doc.data()!;

        return {
          "location": data["location"],
          "currentTemp": data["currentTemp"],
          "forecast":
              (data["forecast"] as Map<String, dynamic>).values.map((e) => Map<String, dynamic>.from(e)).toList(),
        };
      } else {
        throw Exception("Documento de clima no encontrado");
      }
    } catch (e) {
      throw Exception("Error al obtener datos del clima: $e");
    }
  }

  //*~~~~~Obtiene la temperatura actual desde Firebase~~~~~*
  Future<String> getCurrentTemperature() async {
    try {
      final weatherData = await getWeatherData();
      final temp = weatherData["currentTemp"];
      return "$temp°C";
    } catch (e) {
      throw Exception("No se pudo obtener la temperatura actual: $e");
    }
  }
}
