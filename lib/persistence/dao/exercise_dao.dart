import 'package:mimix_app/persistence/bean/exercise.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/utils/storage/database_helper.dart';

class ExerciseDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertExercise(Exercise exercise) async {
    final db = await _databaseHelper.database;
    try {
      final exerciseMap = exercise.toJson();
      exerciseMap.remove('id'); // Remove id because it's set by the database

      return await db.insert(
        'exercise',
        exerciseMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ArgumentError('Error inserting exercise: $e');
    }
  }

  Future<Exercise?> getExerciseById(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'exercise',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Exercise.fromJson(maps.first);
      }
      return null; // Return null if no exercise is found
    } catch (e) {
      throw ArgumentError('Error retrieving exercise by id: $e');
    }
  }

  Future<int> updateExercise(Exercise exercise) async {
    final db = await _databaseHelper.database;
    try {
      final exerciseMap = exercise.toJson();
      if (exercise.id == null) {
        throw ArgumentError('Error: Exercise id cannot be null.');
      }
      return await db.update(
        'exercise',
        exerciseMap,
        where: 'id = ?',
        whereArgs: [exercise.id],
      );
    } catch (e) {
      throw ArgumentError('Error updating exercise: $e');
    }
  }

  Future<int> deleteExercise(int id) async {
    final db = await _databaseHelper.database;
    try {
      if (id <= 0) {
        throw ArgumentError('Error: Invalid id value.');
      }
      return await db.delete(
        'exercise',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ArgumentError('Error deleting exercise: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllExercises() async {
    final db = await _databaseHelper.database;
    return await db.query('exercise');
  }
}
