import 'package:equatable/equatable.dart';

class ScheduleTask extends Equatable {
  final int? id;
  final String title;
  final TaskType type;

  final String? note;
  final List<WeekDay>? weekDays;
  final int? dayOfMonth;
  final DateTime? singleDate;

  const ScheduleTask({
    this.id,
    required this.title,
    required this.type,

    this.note,
    this.weekDays,
    this.dayOfMonth,
    this.singleDate,
  });

  @override
  List<Object?> get props {
    return [id!, title, note, weekDays, dayOfMonth, singleDate];
  }
}

enum TaskType {
  daily('Diária'),
  weekly('Semanal'),
  monthly('Mensal'),
  single('Pontual');

  final String label;

  const TaskType(this.label);
}

enum WeekDay {
  monday('Seg'),
  tuesday('Ter'),
  wednesday('Qua'),
  thursday('Qui'),
  friday('Sex'),
  saturday('Sab'),
  sunday('Dom');

  final String label;

  const WeekDay(this.label);
}
