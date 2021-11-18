import 'package:restourant_app/data/model/restourant_add.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();
  static const String _tblFavorite = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db =
        openDatabase('$path/restourantapp/db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tblFavorite (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating INTEGER
           )     
        ''');
    }, version: 1);
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertFavorite(RestaurantAdd restourant) async {
    final db = await database;
    await db!.insert(_tblFavorite, restourant.toJson());
  }

  Future<List<RestaurantAdd>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblFavorite);
    return result.map((e) => RestaurantAdd.fromJson(e)).toList();
  }

  Future<Map> getFavoritesByName(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db!.query(_tblFavorite, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db!.delete(_tblFavorite, where: 'id = ?', whereArgs: [id]);
  }
}
