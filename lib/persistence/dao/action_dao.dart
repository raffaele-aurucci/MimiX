import 'package:mimix_app/persistence/bean/action.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class ActionDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertAction(Action action) async {
    final db = await _databaseHelper.database;
    try {
      final actionMap = action.toJson();
      actionMap.remove('id'); // Remove id as it is auto-generated
      return await db.insert(
        'action',
        actionMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting action: $e');
    }
  }

  Future<Action?> getActionById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'action',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Action.fromJson(maps.first);
      }
      return null; // Return null if no action is found
    } catch (e) {
      throw ArgumentError('Error retrieving action by id: $e');
    }
  }

  Future<List<Action>> getAllActions() async {
    final db = await _databaseHelper.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('action');
      return maps.map((map) => Action.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving all actions: $e');
    }
  }

  Future<int> updateAction(Action action) async {
    final db = await _databaseHelper.database;
    try {
      final actionMap = action.toJson();
      if (action.id == null) {
        throw ArgumentError('Error: Action id cannot be null.');
      }
      return await db.update(
        'action',
        actionMap,
        where: 'id = ?',
        whereArgs: [action.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating action: $e');
    }
  }

  Future<int> deleteAction(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      return await db.delete(
        'action',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting action: $e');
    }
  }
}
