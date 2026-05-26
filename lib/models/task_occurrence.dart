import 'package:flowly/models/models.dart';

class TaskOccurrence {
  int? id;
  DateTime date;
  int scheduleTaskId;
  bool isComplete;
  ScheduleTask? scheduleTask;

  TaskOccurrence({
    this.id,
    required this.date,
    required this.scheduleTaskId,
    required this.isComplete,
    this.scheduleTask,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'scheduleTaskId': scheduleTaskId,
      'isComplete': isComplete ? 1 : 0,
    };
  }

  factory TaskOccurrence.fromMap(Map<String, dynamic> map) {
    return TaskOccurrence(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      scheduleTaskId: map['scheduleTaskId'],
      isComplete: map['isComplete'] == 1,
    );
  }
}
