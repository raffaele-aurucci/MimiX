import 'package:mimix_app/persistence/bean/user_reward.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class UserRewardDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertUserReward(UserReward userReward) async {
    final db = await _databaseHelper.database;
    try {
      final userRewardMap = userReward.toJson();
      return await db.insert(
        'user_reward',
        userRewardMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting user_reward: $e');
    }
  }

  Future<List<UserReward>> getRewardsByUserId(int userId) async {
    final db = await _databaseHelper.database;
    try {
      if (userId <= 0) {
        throw ArgumentError('Error: Invalid user_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'user_rewards',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      return maps.map((map) => UserReward.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving rewards by user_id: $e');
    }
  }

  Future<List<UserReward>> getUsersByRewardId(int rewardId) async {
    final db = await _databaseHelper.database;
    try {
      if (rewardId <= 0) {
        throw ArgumentError('Error: Invalid reward_id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'user_reward',
        where: 'reward_id = ?',
        whereArgs: [rewardId],
      );
      return maps.map((map) => UserReward.fromJson(map)).toList();
    } catch (e) {
      throw ArgumentError('Error retrieving users by reward_id: $e');
    }
  }

  Future<int> deleteUserReward(int userId, int rewardId) async {
    final db = await _databaseHelper.database;
    try {
      if (userId <= 0 || rewardId <= 0) {
        throw ArgumentError('Error: Invalid user_id or reward_id value.');
      }
      return await db.delete(
        'user_reward',
        where: 'user_id = ? AND reward_id = ?',
        whereArgs: [userId, rewardId],
      );
    } catch (e) {
      throw ArgumentError('Error deleting user_reward: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllUserRewards() async {
    final db = await _databaseHelper.database;
    return await db.query('user_reward');
  }
}
