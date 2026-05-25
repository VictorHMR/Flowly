import 'package:flowly/models/models.dart';
import 'package:flowly/repositories/repositories.dart';

class ScheduleGenerationService {
  static Future<void> generateTodayTasks() async {
    final scheduleRepository = ScheduleTaskRepository();
    final occurrenceRepository = TaskOccurrenceRepository();
    final tasks = await scheduleRepository.getAll();
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    for (final task in tasks) {
      final shouldCreate = _shouldCreateTaskForToday(task, today);
      if (!shouldCreate) {
        continue;
      }
      final alreadyExists = await occurrenceRepository.existsForDate(
        task.id!,
        today,
      );
      if (alreadyExists) {
        continue;
      }
      await occurrenceRepository.insert(
        TaskOccurrence(
          scheduleTaskId: task.id!,
          date: today,
          isComplete: false,
        ),
      );
    }
  }

  static bool _shouldCreateTaskForToday(ScheduleTask task, DateTime date) {
    switch (task.type) {
      case TaskType.daily:
        return true;
      case TaskType.weekly:
        final weekDay = WeekDay.fromDateTimeWeekday(date.weekday);
        return task.weekDays?.contains(weekDay) ?? false;
      case TaskType.monthly:
        return task.dayOfMonth == date.day;
      case TaskType.single:
        return task.singleDate?.day == date.day &&
            task.singleDate?.month == date.month &&
            task.singleDate?.year == date.year;
    }
  }
}
