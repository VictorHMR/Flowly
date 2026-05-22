import 'dart:ffi';

import 'package:flowly/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/core/widgets/widgets.dart';
import 'package:gap/gap.dart';

class ScheduleTaskDetails extends StatefulWidget {
  const ScheduleTaskDetails({super.key, this.scheduleTask});

  final ScheduleTask? scheduleTask;

  @override
  State<ScheduleTaskDetails> createState() => _ScheduleTaskDetailsState();
}

class _ScheduleTaskDetailsState extends State<ScheduleTaskDetails> {
  late ScheduleTask scheduleTask;

  @override
  void initState() {
    super.initState();

    scheduleTask =
        widget.scheduleTask ??
        ScheduleTask(
          title: '',
          type: TaskType.weekly,
          icon: Icons.alarm,
          weekDays: [WeekDay.fromDateTimeWeekday(DateTime.now().weekday)],
        );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;
    return Scaffold(
      appBar: AppBar(
        title: Text('${scheduleTask.id == null ? 'Nova' : ''} Tarefa'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, scheduleTask);
            },

            child: Text(scheduleTask.id == null ? 'Criar' : 'Salvar'),
          ),
          Gap(20),
        ],
      ),
      body: Align(
        alignment: AlignmentGeometry.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          alignment: AlignmentGeometry.topCenter,
          width: screenSize.width * 0.9,
          height: screenSize.height,
          child: Column(
            children: [
              SectionTitle(textValue: 'Detalhes'),
              Gap(20),
              EditableIconCard<IconData>(
                selectedIcon: scheduleTask.icon,
                onChanged: (newIcon) {
                  setState(() {
                    scheduleTask = scheduleTask.copyWith(icon: newIcon);
                  });
                },
              ),
              Gap(20),
              EditableTitle(
                initialValue: scheduleTask.title,
                onChanged: (value) {
                  setState(() {
                    scheduleTask = scheduleTask.copyWith(title: value);
                  });
                },
              ),
              Gap(20),
              EditableDetailCard<TaskType>(
                icon: Icons.calendar_month_outlined,
                title: 'Tipo',
                value: scheduleTask.type,
                type: FieldType.enumSelection,
                enumValues: TaskType.values,
                getLabel: (type) => type.label,
                onChanged: (newType) {
                  setState(() {
                    scheduleTask = scheduleTask.copyWith(type: newType);
                    switch (scheduleTask.type) {
                      case TaskType.monthly:
                        scheduleTask.dayOfMonth =
                            scheduleTask.dayOfMonth ?? DateTime.now().day;
                      case TaskType.weekly:
                        scheduleTask.weekDays =
                            scheduleTask.weekDays ??
                            [
                              WeekDay.fromDateTimeWeekday(
                                DateTime.now().weekday,
                              ),
                            ];
                      case TaskType.single:
                        scheduleTask.singleDate =
                            scheduleTask.singleDate ?? DateTime.now();
                      default:
                        scheduleTask.dayOfMonth = null;
                        scheduleTask.weekDays = null;
                        scheduleTask.singleDate = null;
                    }
                  });
                },
              ),
              if (scheduleTask.type != TaskType.daily) Gap(10),
              if (scheduleTask.type != TaskType.daily)
                EditableDetailCard<Object?>(
                  icon: Icons.calendar_month_outlined,
                  title: 'Frequência',
                  value: _getFrequencyValue(),
                  type: scheduleTask.type.fieldType,
                  onChanged: (newValue) {
                    setState(() {
                      switch (scheduleTask.type) {
                        case TaskType.daily:
                          break;
                        case TaskType.weekly:
                          scheduleTask = scheduleTask.copyWith(
                            weekDays: newValue as List<WeekDay>,
                          );
                        case TaskType.monthly:
                          scheduleTask = scheduleTask.copyWith(
                            dayOfMonth: (newValue as DateTime).day,
                          );
                        case TaskType.single:
                          scheduleTask = scheduleTask.copyWith(
                            singleDate: newValue as DateTime,
                          );
                      }
                    });
                  },
                ),
              Gap(10),
              EditableDetailCard<String>(
                icon: Icons.description_outlined,
                title: 'Observações',
                value: scheduleTask.note ?? '',
                type: FieldType.multilineText,
                onChanged: (newNote) {
                  setState(() {
                    scheduleTask = scheduleTask.copyWith(note: newNote);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic _getFrequencyValue() => switch (scheduleTask.type) {
    TaskType.daily => '',
    TaskType.weekly => scheduleTask.weekDays,
    TaskType.monthly => scheduleTask.dayOfMonth,
    TaskType.single => scheduleTask.singleDate,
  };
}
