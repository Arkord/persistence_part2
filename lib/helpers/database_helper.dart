import 'package:persistence1/models/cat_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'animals.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE cats (
        id INTEGER PRIMARY KEY,
        race TEXT,
        name TEXT
      )
    ''');
  }

  Future<List<Cat>> getCats() async {
    Database db = await instance.database;
    var cats = await db.query('cats', orderBy: 'race');

    List<Cat> catsList = cats.isNotEmpty ? cats.map((e) => Cat.fromMap(e)).toList() : [];
    return catsList;
  }

  Future<int> add(Cat cat) async {
    Database db = await instance.database;
    return await db.insert('cats', cat.toMap());
  }
}