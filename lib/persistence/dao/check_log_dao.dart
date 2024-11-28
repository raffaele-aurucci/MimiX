import 'package:mimix_app/persistence/bean/check_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class CheckLogDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertCheckLog(CheckLog checkLog) async {
    final db = await _databaseHelper.database;
    try {
      final checkLogMap = checkLog.toJson();
      checkLogMap.remove('id'); // Remove id as it is auto-generated
      return await db.insert(
        'check_log',
        checkLogMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting check_log: $e');
    }
  }

  Future<CheckLog?> getCheckLogById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'check_log',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return CheckLog.fromJson(maps.first);
      }
      return null; // Return null if no check_log is found
    } catch (e) {
      throw ArgumentError('Error retrieving check_log by id: $e');
    }
  }

  Future<List<CheckLog>> getCheckLogsByUserId(int userId) async {
    final db = await _databaseHelper.database;
    try {
      if (userId <= 0) {
        throw ArgumentError('Error: Invalid user_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'check_log',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      return maps.map((map) => CheckLog.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving check_logs by user_id: $e');
    }
  }

  Future<int> updateCheckLog(CheckLog checkLog) async {
    final db = await _databaseHelper.database;
    try {
      final checkLogMap = checkLog.toJson();
      if (checkLog.id == null) {
        throw ArgumentError('Error: CheckLog id cannot be null.');
      }
      return await db.update(
        'check_log',
        checkLogMap,
        where: 'id = ?',
        whereArgs: [checkLog.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating check_log: $e');
    }
  }

  Future<int> deleteCheckLog(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      return await db.delete(
        'check_log',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting check_log: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllCheckLogs() async {
    final db = await _databaseHelper.database;
    return await db.query('check_log');
  }
}
