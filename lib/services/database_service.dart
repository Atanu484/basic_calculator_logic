import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/history_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('calculator_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        calculation TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
      ''');
  }

  Future<HistoryModel> create(HistoryModel history) async {
    final db = await instance.database;
    final Map<String, dynamic> data = history.toMap();
    data.remove('id');
    final id = await db.insert('history', data);
    return history.copyWith(id: id);
  }

  Future<List<HistoryModel>> readAll() async {
    final db = await instance.database;

    final orderBy = 'timestamp DESC';
    final result = await db.query('history', orderBy: orderBy);

    return result.map((json) => HistoryModel.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}