import 'package:module_9_local_db/model/task_model.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

/// A helper class managing the SQLite database operations for Task items.
class TaskDatabase {
  static Database? _db;

  /// Retrieves the initialized Database instance, creating it if it doesn't exist.
  static Future<Database> getDB() async {
    if (_db != null) return _db!;
    
    _db = await openDatabase(
      p.join(await getDatabasesPath(), 'task.db'),
      onCreate: (db, version) {
        // Create the tasks table on first-time launch
        db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, isDone INTEGER)',
        );
      },
      version: 2,
    );
    return _db!;
  }

  /// Inserts a new task into the database, replacing conflicting rows if any.
  static Future<void> insertTask(TaskModel task) async {
    final db = await getDB();
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all stored tasks from the database, ordered by ID.
  static Future<List<TaskModel>> getTasks() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('tasks', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  /// Deletes a single task by its unique identifier.
  static Future<void> deleteTask(int id) async {
    final db = await getDB();
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Deletes multiple tasks at once in an efficient SQL batch/query.
  static Future<void> deleteTasks(List<int> ids) async {
    if (ids.isEmpty) return;
    final db = await getDB();
    // Build a safe parameter list: e.g., (?, ?, ?) for safe query variable binding
    final placeholders = List.filled(ids.length, '?').join(', ');
    await db.delete(
      'tasks',
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
  }

  /// Updates an existing task's properties in the database.
  static Future<void> updateTask(TaskModel task) async {
    final db = await getDB();
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
