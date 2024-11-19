import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/user_management/beans/user.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class UserDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertUser(User user) async {
    final db = await _databaseHelper.database;
    try {
      // Remove id because it's set by the database
      final userMap = user.toJson();
      userMap.remove('id');

      // Insert and return the id of the inserted row
      return await db.insert(
        'user',
        userMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting user: $e');
    }
  }

  Future<User?> getUserById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'user',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return User.fromJson(maps.first);
      }
      return null;  // Return null if no user is found
    } catch (e) {
      throw ArgumentError('Error retrieving user by id: $e');
    }
  }

  Future<int> updateUser(User user) async {
    final db = await _databaseHelper.database;
    try {
      final userMap = user.toJson();
      if (user.id == null) {
        throw ArgumentError('Error: User id cannot be null.');
      }
      // return the number of affected rows
      return await db.update(
        'user',
        userMap,
        where: 'id = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating user: $e');
    }
  }

  Future<int> deleteUser(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      // delete and return the number of affected rows
      return await db.delete(
        'user',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting user: $e');
    }
  }

}