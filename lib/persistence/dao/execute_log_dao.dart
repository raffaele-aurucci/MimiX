import 'package:mimix_app/persistence/bean/execute_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class ExecuteLogDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertExecuteLog(ExecuteLog executeLog) async {
    final db = await _databaseHelper.database;
    try {
      final executeLogMap = executeLog.toJson();
      executeLogMap.remove('id'); // Remove id as it is auto-generated
      return await db.insert(
        'execute_log',
        executeLogMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting execute_log: $e');
    }
  }

  Future<ExecuteLog?> getExecuteLogById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'execute_log',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return ExecuteLog.fromJson(maps.first);
      }
      return null; // Return null if no execute_log is found
    } catch (e) {
      throw ArgumentError('Error retrieving execute_log by id: $e');
    }
  }

  Future<List<ExecuteLog>> getExecuteLogsByUserId(int userId) async {
    final db = await _databaseHelper.database;
    try {
      if (userId <= 0) {
        throw ArgumentError('Error: Invalid user_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'execute_log',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      return maps.map((map) => ExecuteLog.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving execute_logs by user_id: $e');
    }
  }

  Future<List<ExecuteLog>> getExecuteLogsByExerciseId(int exerciseId) async {
    final db = await _databaseHelper.database;
    try {
      if (exerciseId <= 0) {
        throw ArgumentError('Error: Invalid exercise_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'execute_log',
        where: 'exercise_id = ?',
        whereArgs: [exerciseId],
      );
      return maps.map((map) => ExecuteLog.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving execute_logs by exercise_id: $e');
    }
  }

  Future<int> updateExecuteLog(ExecuteLog executeLog) async {
    final db = await _databaseHelper.database;
    try {
      final executeLogMap = executeLog.toJson();
      if (executeLog.id == null) {
        throw ArgumentError('Error: ExecuteLog id cannot be null.');
      }
      return await db.update(
        'execute_log',
        executeLogMap,
        where: 'id = ?',
        whereArgs: [executeLog.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating execute_log: $e');
    }
  }

  Future<int> deleteExecuteLog(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      return await db.delete(
        'execute_log',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting execute_log: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllExecuteLogs() async {
    final db = await _databaseHelper.database;
    return await db.query('execute_log');
  }
}
