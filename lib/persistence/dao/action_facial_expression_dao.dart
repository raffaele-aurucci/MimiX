import 'package:mimix_app/persistence/bean/action_facial_expression.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class ActionFacialExpressionDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertActionFacialExpression(ActionFacialExpression actionFacialExpression) async {
    final db = await _databaseHelper.database;
    try {
      final actionFacialExpressionMap = actionFacialExpression.toJson();
      // Insert and return the number of affected rows
      return await db.insert(
        'action_facial_expression',
        actionFacialExpressionMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting action_facial_expression: $e');
    }
  }

  Future<List<ActionFacialExpression>> getActionFacialExpressionsByActionId(int actionId) async {
    final db = await _databaseHelper.database;
    try {
      if (actionId <= 0) {
        throw ArgumentError('Error: Invalid action_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'action_facial_expression',
        where: 'action_id = ?',
        whereArgs: [actionId],
      );
      return maps.map((map) => ActionFacialExpression.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving action_facial_expressions by action_id: $e');
    }
  }

  Future<List<ActionFacialExpression>> getActionFacialExpressionsByFacialExpressionId(int facialExpressionId) async {
    final db = await _databaseHelper.database;
    try {
      if (facialExpressionId <= 0) {
        throw ArgumentError('Error: Invalid facial_expression_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'action_facial_expression',
        where: 'facial_expression_id = ?',
        whereArgs: [facialExpressionId],
      );
      return maps.map((map) => ActionFacialExpression.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving action_facial_expressions by facial_expression_id: $e');
    }
  }

  Future<int> deleteActionFacialExpression(int actionId, int facialExpressionId) async {
    final db = await _databaseHelper.database;
    try {
      if (actionId <= 0 || facialExpressionId <= 0) {
        throw ArgumentError('Error: Invalid action_id or facial_expression_id value.');
      }
      return await db.delete(
        'action_facial_expression',
        where: 'action_id = ? AND facial_expression_id = ?',
        whereArgs: [actionId, facialExpressionId],
      );
    } catch (e) {
      throw ArgumentError('Error deleting action_facial_expression: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllActionFacialExpressions() async {
    final db = await _databaseHelper.database;
    return await db.query('action_facial_expression');
  }
}
