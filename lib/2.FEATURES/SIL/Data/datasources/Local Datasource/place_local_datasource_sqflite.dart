// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../1.CONFIG/Core/utils/enum_category_type.dart';
import '../../../Domain/entities/tourist_visita_entity.dart';
import '../../models/tourist_visita_model.dart';

class PlaceLocalDataSourceSqflite {
  static Database? _database;

  // Inicialización de la base de datos
  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'places.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await _createTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE places ADD COLUMN latitud REAL");
          await db.execute("ALTER TABLE places ADD COLUMN longitud REAL");
          await db.execute("ALTER TABLE places ADD COLUMN modeUrl TEXT");
        }
      },
    );
  }

  // Crear tabla
  static Future<void> _createTable(Database db) async {
    await db.execute('''
      CREATE TABLE places(
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        videoUrl TEXT,
        isRecommended INTEGER,
        locationType INTEGER,
        phoneNumber TEXT,
        imagePaths TEXT,
        socialMediaLinks TEXT,
        infoItems TEXT,
        latitud REAL,
        longitud REAL,
        modeUrl TEXT
      )
    ''');
  }

  // Obtener la instancia de la base de datos
  static Future<Database> get _databaseInstance async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  //* Insertar lugar en la base de datos
  static Future<void> insertPlace(TouristVisitaEntity place) async {
    final db = await _databaseInstance;
    try {
      final model = TouristVisitaModel.fromEntity(place);
      await db.insert('places', model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

      debugPrint('🛠 Insertando lugar: ${model.toMap()}');

      await db.insert('places', model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

      debugPrint('✅ Lugar insertado: ${model.title}');
    } catch (e, stackTrace) {
      debugPrint('🔥 Error al insertar lugar: $e');
      debugPrint('🪜 Stacktrace: $stackTrace');
      rethrow; // También relanza para que lo captures si quieres
    }
  }

  //* Eliminar lugar por ID
  static Future<void> deletePlace(String id) async {
    final db = await _databaseInstance;
    debugPrint('Eliminando lugar con ID: $id');
    await db.delete('places', where: 'id = ?', whereArgs: [id]);
    debugPrint('Lugar eliminado con ID: $id');
  }

  //* Obtener todos los lugares
  static Future<List<TouristVisitaEntity>> getAllPlaces() async {
    final db = await _databaseInstance;
    final maps = await db.query('places');

    // Convertimos cada registro en un objeto TouristVisitaEntity
    return maps.map((map) => TouristVisitaModel.fromMap(map).toEntity()).toList();
  }

  //* Obtener lugares favoritos filtrados por tipo
  static Future<List<TouristVisitaEntity>> getFavoritesByCategory(CategoryType categoryType) async {
    final db = await _databaseInstance;
    debugPrint('Consultando favoritos para categoría: ${categoryType.name}');

    final maps = await db.query(
      'places',
      where: 'locationType = ?',
      whereArgs: [categoryType.index],
    );

    debugPrint('Cantidad de favoritos encontrados: ${maps.length}');

    return maps.map((map) => TouristVisitaModel.fromMap(map).toEntity()).toList();
  }
}
