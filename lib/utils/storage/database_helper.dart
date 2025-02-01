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
    await _createMinigameTable(db);
    await _createActionTable(db);
    await _createFacialExpressionTable(db);
    await _createCheckLogTable(db);
    await _createExerciseTable(db);
    await _createPlayLogTable(db);
    await _createTaskTable(db);
    await _createExecuteLogTable(db);
    await _createPerformLogTable(db);
    await _createActionMinigameTable(db);
    await _createActionFacialExpressionTable(db);
    await _createFacialExpressionLogTable(db);
    await _createRewardTable(db);
    await _createUserRewardTable(db);
  }

  Future<void> _createUserTable(Database db) async {
    const todoSql = '''CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL,
      age INTEGER NOT NULL,
      level INTEGER NOT NULL,
      level_completion_date INTEGER NOT NULL,
      level_progress REAL NOT NULL
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createMinigameTable(Database db) async {
    const todoSql = '''CREATE TABLE minigame (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createActionTable(Database db) async {
    const todoSql = '''CREATE TABLE action (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL
      )''';
    await db.execute(todoSql);
  }

  // Table used to stored value of different execution of facial expression.
  Future<void> _createFacialExpressionTable(Database db) async {
    const todoSql = '''CREATE TABLE facial_expression (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      parameter TEXT NOT NULL,
      value REAL NOT NULL, 
      check_id INTEGER,
      FOREIGN KEY (check_id) REFERENCES check_log(id)
      )''';
    await db.execute(todoSql);
  }

  // Table used to store value of check ability.
  Future<void> _createCheckLogTable(Database db) async {
    const todoSql = '''CREATE TABLE check_log (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER NOT NULL,
      user_id INTEGER NOT NULL,
      FOREIGN KEY (user_id) REFERENCES user(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createExerciseTable(Database db) async {
    const todoSql = '''CREATE TABLE exercise (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      facial_expression_id INTEGER NOT NULL,
      FOREIGN KEY (facial_expression_id) REFERENCES facial_expression(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createPlayLogTable(Database db) async {
    const todoSql = '''CREATE TABLE play_log (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER NOT NULL,
      record INTEGER NOT NULL,
      outcome INTEGER NOT NULL,
      time INTEGER NOT NULL,
      user_id INTEGER NOT NULL,
      minigame_id INTEGER NOT NULL,
      FOREIGN KEY (user_id) REFERENCES user(id),
      FOREIGN KEY (minigame_id) REFERENCES minigame(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createTaskTable(Database db) async {
    const todoSql = '''CREATE TABLE task (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      score INTEGER NOT NULL,
      level INTEGER NOT NULL,
      experience_points INTEGER NOT NULL,
      minigame_id INTEGER,
      facial_expression_id INTEGER,
      exercise_id INTEGER,
      FOREIGN KEY (minigame_id) REFERENCES minigame(id),
      FOREIGN KEY (facial_expression_id) REFERENCES facial_expression(id),
      FOREIGN KEY (exercise_id) REFERENCES exercise(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createExecuteLogTable(Database db) async {
    const todoSql = '''CREATE TABLE execute_log (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER NOT NULL,
      time INTEGER NOT NULL,
      user_id INTEGER NOT NULL,
      exercise_id INTEGER NOT NULL,
      FOREIGN KEY (user_id) REFERENCES user(id),
      FOREIGN KEY (exercise_id) REFERENCES exercise(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createPerformLogTable(Database db) async {
    const todoSql = '''CREATE TABLE perform_log (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER NOT NULL,
      progress INTEGER NOT NULL,
      outcome INTEGER NOT NULL,
      user_id INTEGER NOT NULL,
      task_id INTEGER NOT NULL, 
      FOREIGN KEY (user_id) REFERENCES user(id),
      FOREIGN KEY (task_id) REFERENCES task(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createActionMinigameTable(Database db) async {
    const todoSql = '''CREATE TABLE action_minigame (
      action_id INTEGER NOT NULL,
      minigame_id INTEGER NOT NULL, 
      PRIMARY KEY (action_id, minigame_id),
      FOREIGN KEY (action_id) REFERENCES action(id),
      FOREIGN KEY (minigame_id) REFERENCES minigame(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createActionFacialExpressionTable(Database db) async {
    const todoSql = '''CREATE TABLE action_facial_expression (
      action_id INTEGER NOT NULL, 
      facial_expression_id INTEGER NOT NULL,
      PRIMARY KEY (action_id, facial_expression_id),
      FOREIGN KEY (action_id) REFERENCES action(id),
      FOREIGN KEY (facial_expression_id) REFERENCES facial_expression(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createFacialExpressionLogTable(Database db) async {
    const todoSql = '''CREATE TABLE facial_expression_log (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      count INTEGER NOT NULL,
      play_log_id INTEGER NOT NULL,
      facial_expression_id INTEGER NOT NULL,
      execute_log_id INTEGER NOT NULL,
      FOREIGN KEY (play_log_id) REFERENCES play_log(id),
      FOREIGN KEY (facial_expression_id) REFERENCES facial_expression(id),
      FOREIGN KEY (execute_log_id) REFERENCES execute_log(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createRewardTable(Database db) async {
    const todoSql = '''CREATE TABLE reward (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      level INTEGER NOT NULL,
      score INTEGER NOT NULL,
      facial_expression_id INTEGER NOT NULL,
      FOREIGN KEY (facial_expression_id) REFERENCES facial_expression(id)
      )''';
    await db.execute(todoSql);
  }

  Future<void> _createUserRewardTable(Database db) async {
    const todoSql = '''CREATE TABLE user_reward (
      user_id INTEGER NOT NULL, 
      reward_id INTEGER NOT NULL,
      PRIMARY KEY (user_id, reward_id),
      FOREIGN KEY (user_id) REFERENCES user(id),
      FOREIGN KEY (reward_id) REFERENCES reward(id)
      )''';
    await db.execute(todoSql);
  }
}