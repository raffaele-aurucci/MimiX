import 'package:mimix_app/persistence/bean/play_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class PlayLogDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertPlayLog(PlayLog playLog) async {
    final db = await _databaseHelper.database;
    try {
      final playLogMap = playLog.toJson();
      playLogMap.remove('id'); // Remove id as it is auto-generated
      return await db.insert(
        'play_log',
        playLogMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting play_log: $e');
    }
  }

  Future<PlayLog?> getPlayLogById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'play_log',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return PlayLog.fromJson(maps.first);
      }
      return null; // Return null if no play_log is found
    } catch (e) {
      throw ArgumentError('Error retrieving play_log by id: $e');
    }
  }

  Future<List<PlayLog>> getPlayLogsByUserId(int userId) async {
    final db = await _databaseHelper.database;
    try {
      if (userId <= 0) {
        throw ArgumentError('Error: Invalid user_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'play_log',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      return maps.map((map) => PlayLog.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving play_logs by user_id: $e');
    }
  }

  Future<List<PlayLog>> getPlayLogsByMinigameId(int minigameId) async {
    final db = await _databaseHelper.database;
    try {
      if (minigameId <= 0) {
        throw ArgumentError('Error: Invalid minigame_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'play_log',
        where: 'minigame_id = ?',
        whereArgs: [minigameId],
      );
      return maps.map((map) => PlayLog.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving play_logs by minigame_id: $e');
    }
  }

  Future<int> updatePlayLog(PlayLog playLog) async {
    final db = await _databaseHelper.database;
    try {
      final playLogMap = playLog.toJson();
      if (playLog.id == null) {
        throw ArgumentError('Error: PlayLog id cannot be null.');
      }
      return await db.update(
        'play_log',
        playLogMap,
        where: 'id = ?',
        whereArgs: [playLog.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating play_log: $e');
    }
  }

  Future<int> deletePlayLog(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      return await db.delete(
        'play_log',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting play_log: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllPlayLogs() async {
    final db = await _databaseHelper.database;
    return await db.query('play_log');
  }
}
