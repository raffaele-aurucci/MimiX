import 'package:mimix_app/persistence/bean/action_minigame.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class ActionMinigameDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertActionMinigame(ActionMinigame actionMinigame) async {
    final db = await _databaseHelper.database;
    try {
      final actionMinigameMap = actionMinigame.toJson();
      // Insert and return the number of affected rows
      return await db.insert(
        'action_minigame',
        actionMinigameMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting action_minigame: $e');
    }
  }

  Future<List<ActionMinigame>> getActionMinigamesByActionId(int actionId) async {
    final db = await _databaseHelper.database;
    try {
      if (actionId <= 0) {
        throw ArgumentError('Error: Invalid action_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'action_minigame',
        where: 'action_id = ?',
        whereArgs: [actionId],
      );
      return maps.map((map) => ActionMinigame.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving action_minigames by action_id: $e');
    }
  }

  Future<List<ActionMinigame>> getActionMinigamesByMinigameId(int minigameId) async {
    final db = await _databaseHelper.database;
    try {
      if (minigameId <= 0) {
        throw ArgumentError('Error: Invalid minigame_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'action_minigame',
        where: 'minigame_id = ?',
        whereArgs: [minigameId],
      );
      return maps.map((map) => ActionMinigame.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving action_minigames by minigame_id: $e');
    }
  }

  Future<int> deleteActionMinigame(int actionId, int minigameId) async {
    final db = await _databaseHelper.database;
    try {
      if (actionId <= 0 || minigameId <= 0) {
        throw ArgumentError('Error: Invalid action_id or minigame_id value.');
      }
      return await db.delete(
        'action_minigame',
        where: 'action_id = ? AND minigame_id = ?',
        whereArgs: [actionId, minigameId],
      );
    } catch (e) {
      throw ArgumentError('Error deleting action_minigame: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllActionMinigames() async {
    final db = await _databaseHelper.database;
    return await db.query('action_minigame');
  }
}
