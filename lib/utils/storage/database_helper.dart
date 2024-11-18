import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _databaseName = 'Mimix.db';
  static Database? _database;

  // singleton initialized with private constructor
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // private constructor
  DatabaseHelper._internal();

  // factory public constructor that return _instance
  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _version,
      onCreate: _onCreate
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createUserTable(db);
  }

  Future<void> _createUserTable(Database db) async {
    const todoSql = '''CREATE TABLE USER (
      id INTEGER PRIMARY KEY,
      username TEXT NOT NULL,
      age INTEGER NOT NULL,
      level INTEGER NOT NULL,
      level_completion_date INTEGER NOT NULL
      )''';
    await db.execute(todoSql);
  }

  // TODO: create other tables

}