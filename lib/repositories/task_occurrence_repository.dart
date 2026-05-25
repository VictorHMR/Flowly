import 'package:flowly/core/config/database/app_database.dart';
import 'package:flowly/models/models.dart';

class TaskOccurrenceRepository {
  Future<bool> existsForDate(int scheduleTaskId, DateTime date) async {
    final db = await AppDatabase.database;
    final result = await db.query(
      'task_occurrence',
      where: 'scheduleTaskId = ? AND date = ?',
      whereArgs: [scheduleTaskId, date.millisecondsSinceEpoch],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<int> insert(TaskOccurrence taskOccurrence) async {
    final db = await AppDatabase.database;
    return db.insert('task_occurrence', taskOccurrence.toMap());
  }

  Future<List<TaskOccurrence>> getDailyTasks(DateTime date) async {
    final db = await AppDatabase.database;
    final result = await db.query(
      'task_occurrence',
      where: 'date = ?',
      whereArgs: [date.millisecondsSinceEpoch],
      orderBy: 'scheduleTaskId DESC',
    );
    return result.map((e) => TaskOccurrence.fromMap(e)).toList();
  }

  Future<int> completeTask(TaskOccurrence task) async {
    final db = await AppDatabase.database;

    return db.update(
      'task_occurrence',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
