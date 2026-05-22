import 'package:flutter/material.dart';

class ScheduleTask {
  int? id;
  String title;
  TaskType type;
  IconData icon;

  String? note;
  List<WeekDay>? weekDays;
  int? dayOfMonth;
  DateTime? singleDate;

  ScheduleTask({
    this.id,
    required this.title,
    required this.type,
    required this.icon,
    this.note,
    this.weekDays,
    this.dayOfMonth,
    this.singleDate,
  });

  ScheduleTask copyWith({
    int? id,
    String? title,
    TaskType? type,
    IconData? icon,
    String? note,
    List<WeekDay>? weekDays,
    int? dayOfMonth,
    DateTime? singleDate,
  }) {
    return ScheduleTask(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      note: note ?? this.note,
      weekDays: weekDays ?? this.weekDays,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      singleDate: singleDate ?? this.singleDate,
    );
  }
}

enum FieldType {
  text,
  multilineText,
  enumSelection,
  weekDaysSelection,
  date,
  day,
  number,
  none,
}

enum TaskType {
  daily('Diária'),
  weekly('Semanal'),
  monthly('Mensal'),
  single('Pontual');

  final String label;

  const TaskType(this.label);

  FieldType get fieldType {
    switch (this) {
      case TaskType.daily:
        return FieldType.none;

      case TaskType.weekly:
        return FieldType.weekDaysSelection;

      case TaskType.monthly:
        return FieldType.day;
      case TaskType.single:
        return FieldType.date;
    }
  }
}

enum WeekDay {
  sunday('Domingo', 'Dom', 'D'),
  monday('Segunda', 'Seg', 'S'),
  tuesday('Terça', 'Ter', 'T'),
  wednesday('Quarta', 'Qua', 'Q'),
  thursday('Quinta', 'Qui', 'Q'),
  friday('Sexta', 'Sex', 'S'),
  saturday('Sábado', 'Sáb', 'S');

  final String label;
  final String shortLabel;
  final String tinyLabel;

  const WeekDay(this.label, this.shortLabel, this.tinyLabel);

  static WeekDay fromDateTimeWeekday(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return WeekDay.monday;
      case DateTime.tuesday:
        return WeekDay.tuesday;
      case DateTime.wednesday:
        return WeekDay.wednesday;
      case DateTime.thursday:
        return WeekDay.thursday;
      case DateTime.friday:
        return WeekDay.friday;
      case DateTime.saturday:
        return WeekDay.saturday;
      case DateTime.sunday:
        return WeekDay.sunday;
      default:
        throw Exception('Dia inválido');
    }
  }
}
