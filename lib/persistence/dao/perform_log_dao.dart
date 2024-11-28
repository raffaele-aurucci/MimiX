import 'package:mimix_app/persistence/bean/perform_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class PerformLogDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertPerformLog(PerformLog performLog) async {
    final db = await _databaseHelper.database;
    try {
      final performLogMap = performLog.toJson();
      performLogMap.remove('id'); // Remove id as it is auto-generated
      return await db.insert(
        'perform_log',
        performLogMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting perform_log: $e');
    }
  }

  Future<PerformLog?> getPerformLogById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'perform_log',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return PerformLog.fromJson(maps.first);
      }
      return null; // Return null if no perform_log is found
    } catch (e) {
      throw ArgumentError('Error retrieving perform_log by id: $e');
    }
  }

  Future<List<PerformLog>> getPerformLogsByUserId(int userId) async {
    final db = await _databaseHelper.database;
    try {
      if (userId <= 0) {
        throw ArgumentError('Error: Invalid user_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'perform_log',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      return maps.map((map) => PerformLog.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving perform_logs by user_id: $e');
    }
  }

  Future<List<PerformLog>> getPerformLogsByTaskId(int taskId) async {
    final db = await _databaseHelper.database;
    try {
      if (taskId <= 0) {
        throw ArgumentError('Error: Invalid task_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'perform_log',
        where: 'task_id = ?',
        whereArgs: [taskId],
      );
      return maps.map((map) => PerformLog.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving perform_logs by task_id: $e');
    }
  }

  Future<int> updatePerformLog(PerformLog performLog) async {
    final db = await _databaseHelper.database;
    try {
      final performLogMap = performLog.toJson();
      if (performLog.id == null) {
        throw ArgumentError('Error: PerformLog id cannot be null.');
      }
      return await db.update(
        'perform_log',
        performLogMap,
        where: 'id = ?',
        whereArgs: [performLog.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating perform_log: $e');
    }
  }

  Future<int> deletePerformLog(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      return await db.delete(
        'perform_log',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting perform_log: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllPerformLogs() async {
    final db = await _databaseHelper.database;
    return await db.query('perform_log');
  }
}
