import 'package:mimix_app/persistence/bean/facial_expression_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class FacialExpressionLogDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertFacialExpressionLog(FacialExpressionLog facialExpressionLog) async {
    final db = await _databaseHelper.database;
    try {
      final facialExpressionLogMap = facialExpressionLog.toJson();
      // Insert and return the id of the inserted row
      return await db.insert(
        'facial_expression_log',
        facialExpressionLogMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting facial_expression_log: $e');
    }
  }

  Future<FacialExpressionLog?> getFacialExpressionLogById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'facial_expression_log',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return FacialExpressionLog.fromJson(maps.first);
      }
      return null; // Return null if no facial_expression_log is found
    } catch (e) {
      throw ArgumentError('Error retrieving facial_expression_log by id: $e');
    }
  }

  Future<List<FacialExpressionLog>> getFacialExpressionLogsByPlayLogId(int playLogId) async {
    final db = await _databaseHelper.database;
    try {
      if (playLogId <= 0) {
        throw ArgumentError('Error: Invalid play_log_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'facial_expression_log',
        where: 'play_log_id = ?',
        whereArgs: [playLogId],
      );
      return maps.map((map) => FacialExpressionLog.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving facial_expression_logs by play_log_id: $e');
    }
  }

  Future<int> updateFacialExpressionLog(FacialExpressionLog facialExpressionLog) async {
    final db = await _databaseHelper.database;
    try {
      final facialExpressionLogMap = facialExpressionLog.toJson();
      if (facialExpressionLog.id <= 0) {
        throw ArgumentError('Error: FacialExpressionLog id must be valid.');
      }
      // Return the number of affected rows
      return await db.update(
        'facial_expression_log',
        facialExpressionLogMap,
        where: 'id = ?',
        whereArgs: [facialExpressionLog.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating facial_expression_log: $e');
    }
  }

  Future<int> deleteFacialExpressionLog(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      // Delete and return the number of affected rows
      return await db.delete(
        'facial_expression_log',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting facial_expression_log: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllFacialExpressionLogs() async {
    final db = await _databaseHelper.database;
    return await db.query('facial_expression_log');
  }
}
