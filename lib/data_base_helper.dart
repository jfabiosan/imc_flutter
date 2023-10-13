import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  Database? _db;

  DatabaseHelper._();

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  Future<Database> get database async {
    _db ??= await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'imc_database.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE imc_results (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          peso REAL,
          altura REAL,
          resultado REAL
        )
      ''');
    });
  }

  Future<void> insertIMCResult(
      String nome, double peso, double altura, double resultado) async {
    final Database db = await database;
    await db.insert('imc_results', {
      'nome': nome,
      'peso': peso,
      'altura': altura,
      'resultado': resultado,
    });
  }

  Future<List<Map<String, dynamic>>?> getIMCResults() async {
    final Database db = await database;
    return await db.query('imc_results');
  }
}
