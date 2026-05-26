import 'package:flowly/core/config/database/app_database.dart';
import 'package:flowly/models/models.dart';

class ScheduleTaskRepository {
  Future<int> insert(ScheduleTask task) async {
    final db = await AppDatabase.database;

    return db.insert('schedule_tasks', task.toMap());
  }

  Future<List<ScheduleTask>> getAll() async {
    final db = await AppDatabase.database;
    final result = await db.query('schedule_tasks', orderBy: 'id DESC');
    return result.map((e) => ScheduleTask.fromMap(e)).toList();
  }

  Future<ScheduleTask> getById(int id) async {
    final db = await AppDatabase.database;
    final result = await db.query(
      'schedule_tasks',
      where: 'id = ?',
      whereArgs: [id],
      orderBy: 'id DESC',
      limit: 1,
    );
    return ScheduleTask.fromMap(result.first);
  }

  Future<int> update(ScheduleTask task) async {
    final db = await AppDatabase.database;

    return db.update(
      'schedule_tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete(
      'task_occurrence',
      where: 'scheduleTaskId = ?',
      whereArgs: [id],
    );
    return db.delete('schedule_tasks', where: 'id = ?', whereArgs: [id]);
  }
}
