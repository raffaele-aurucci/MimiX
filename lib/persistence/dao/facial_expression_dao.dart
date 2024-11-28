import 'package:mimix_app/persistence/bean/facial_expression.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class FacialExpressionDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertFacialExpression(FacialExpression facialExpression) async {
    final db = await _databaseHelper.database;
    try {
      // Remove id because it's set by the database
      final userMap = facialExpression.toJson();
      userMap.remove('id');

      // Insert and return the id of the inserted row
      return await db.insert(
        'facial_expression',
        userMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting facial_expression: $e');
    }
  }

  Future<FacialExpression?> getFacialExpressionById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'facial_expression',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return FacialExpression.fromJson(maps.first);
      }
      return null;  // Return null if no facial_expression is found
    } catch (e) {
      throw ArgumentError('Error retrieving facial_expression by id: $e');
    }
  }

  Future<int> updateFacialExpression(FacialExpression facialExpression) async {
    final db = await _databaseHelper.database;
    try {
      final facialExpressionMap = facialExpression.toJson();
      if (facialExpression.id == null) {
        throw ArgumentError('Error: FacialExpression id cannot be null.');
      }
      // return the number of affected rows
      return await db.update(
        'facial_expression',
        facialExpressionMap,
        where: 'id = ?',
        whereArgs: [facialExpression.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating facial_expression: $e');
    }
  }

  Future<int> deleteFacialExpression(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      // delete and return the number of affected rows
      return await db.delete(
        'facial_expression',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting facial_expression: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllFacialExpressions() async {
    final db = await _databaseHelper.database;
    return await db.query('facial_expression');
  }
}