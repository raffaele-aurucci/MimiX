import 'package:mimix_app/persistence/bean/reward.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class RewardDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertReward(Reward reward) async {
    final db = await _databaseHelper.database;
    try {
      final rewardMap = reward.toJson();
      rewardMap.remove('id'); // Remove id because it's set by the database

      return await db.insert(
        'reward',
        rewardMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting reward: $e');
    }
  }

  Future<Reward?> getRewardById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'reward',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Reward.fromJson(maps.first);
      }
      return null; // Return null if no reward is found
    } catch (e) {
      throw ArgumentError('Error retrieving reward by id: $e');
    }
  }

  Future<int> updateReward(Reward reward) async {
    final db = await _databaseHelper.database;
    try {
      final rewardMap = reward.toJson();
      if (reward.id == null) {
        throw ArgumentError('Error: Reward id cannot be null.');
      }
      return await db.update(
        'reward',
        rewardMap,
        where: 'id = ?',
        whereArgs: [reward.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating reward: $e');
    }
  }

  Future<int> deleteReward(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      return await db.delete(
        'reward',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting reward: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllRewards() async {
    final db = await _databaseHelper.database;
    return await db.query('reward');
  }
}
