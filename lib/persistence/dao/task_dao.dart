import 'package:mimix_app/persistence/bean/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class TaskDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertTask(Task task) async {
    final db = await _databaseHelper.database;
    try {
      final taskMap = task.toJson();
      taskMap.remove('id'); // Remove id because it's set by the database

      return await db.insert(
        'task',
        taskMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting task: $e');
    }
  }

  Future<Task?> getTaskById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'task',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Task.fromJson(maps.first);
      }
      return null; // Return null if no task is found
    } catch (e) {
      throw ArgumentError('Error retrieving task by id: $e');
    }
  }

  Future<int> updateTask(Task task) async {
    final db = await _databaseHelper.database;
    try {
      final taskMap = task.toJson();
      if (task.id == null) {
        throw ArgumentError('Error: Task id cannot be null.');
      }
      return await db.update(
        'task',
        taskMap,
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating task: $e');
    }
  }

  Future<int> deleteTask(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      return await db.delete(
        'task',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting task: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await _databaseHelper.database;
    return await db.query('task');
  }
}
