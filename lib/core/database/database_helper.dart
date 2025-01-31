import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE water_consumption (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        consumed REAL NOT NULL,
        target REAL NOT NULL,
        date DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Insert default values
    await db.insert('water_consumption', {
      'consumed': 0.0,
      'target': 5.0,
      'date': DateTime.now().toIso8601String(),
    });
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}