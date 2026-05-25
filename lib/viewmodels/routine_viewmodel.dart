import 'package:flowly/models/models.dart';
import 'package:flowly/repositories/schedule_task_repository.dart';
import 'package:flowly/services/services.dart';
import 'package:flutter/material.dart';

class RoutineViewModel extends ChangeNotifier {
  final repository = ScheduleTaskRepository();

  List<ScheduleTask> scheduleTasks = [];
  bool isLoading = false;
  Future<void> loadScheduledTasks() async {
    isLoading = true;
    notifyListeners();
    scheduleTasks = await repository.getAll();
    isLoading = false;
    notifyListeners();
  }

  Future<void> saveTask(ScheduleTask task) async {
    if (task.id == null) {
      await repository.insert(task);
    } else {
      await repository.update(task);
    }
    await ScheduleGenerationService.generateTodayTasks();
    await loadScheduledTasks();
  }

  Future<void> deleteTasks(List<ScheduleTask> tasks) async {
    for (final task in tasks) {
      await repository.delete(task.id!);
    }
    await loadScheduledTasks();
  }
}
