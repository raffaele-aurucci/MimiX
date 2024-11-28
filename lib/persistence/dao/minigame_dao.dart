import 'package:mimix_app/persistence/bean/minigame.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class MinigameDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertMinigame(Minigame minigame) async {
    final db = await _databaseHelper.database;
    try {
      final minigameMap = minigame.toJson();
      minigameMap.remove('id'); // Remove id because it's set by the database

      return await db.insert(
        'minigame',
        minigameMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting minigame: $e');
    }
  }

  Future<Minigame?> getMinigameById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'minigame',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Minigame.fromJson(maps.first);
      }
      return null; // Return null if no minigame is found
    } catch (e) {
      throw ArgumentError('Error retrieving minigame by id: $e');
    }
  }

  Future<int> updateMinigame(Minigame minigame) async {
    final db = await _databaseHelper.database;
    try {
      final minigameMap = minigame.toJson();
      if (minigame.id == null) {
        throw ArgumentError('Error: Minigame id cannot be null.');
      }
      return await db.update(
        'minigame',
        minigameMap,
        where: 'id = ?',
        whereArgs: [minigame.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating minigame: $e');
    }
  }

  Future<int> deleteMinigame(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      return await db.delete(
        'minigame',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting minigame: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllMinigames() async {
    final db = await _databaseHelper.database;
    return await db.query('minigame');
  }
}
