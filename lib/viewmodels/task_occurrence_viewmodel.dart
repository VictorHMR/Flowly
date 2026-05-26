import 'package:flowly/models/models.dart';
import 'package:flowly/repositories/repositories.dart';
import 'package:flutter/material.dart';

class TaskOccurrenceViewModel extends ChangeNotifier {
  final repository = TaskOccurrenceRepository();

  List<TaskOccurrence> taskOccurrences = [];
  List<TaskOccurrence> get completedTasks =>
      taskOccurrences.where((e) => e.isComplete).toList();

  List<TaskOccurrence> get pendingTasks =>
      taskOccurrences.where((e) => !e.isComplete).toList();

  double get progressPercent {
    if (taskOccurrences.isEmpty) return 0;

    return completedTasks.length / taskOccurrences.length;
  }

  bool isLoading = false;
  Future<void> loadTaskOccurrences() async {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    isLoading = true;
    notifyListeners();
    taskOccurrences = await repository.getDailyTasks(today);
    isLoading = false;
    notifyListeners();
  }

  Future<void> completeTask(TaskOccurrence task) async {
    task.isComplete = true;
    await repository.completeTask(task);
    await loadTaskOccurrences();
  }
}
