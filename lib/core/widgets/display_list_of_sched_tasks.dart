import 'package:flowly/models/schedule_task.dart';
import 'package:flowly/views/schedule_task_details.dart';
import 'package:flutter/material.dart';
import 'package:flowly/core/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'widgets.dart';

class DisplayListOfSchedTasks extends StatefulWidget {
  const DisplayListOfSchedTasks({super.key, required this.scheduledTasks});

  final List<ScheduleTask> scheduledTasks;

  @override
  State<DisplayListOfSchedTasks> createState() =>
      _DisplayListOfSchedTasksState();
}

class _DisplayListOfSchedTasksState extends State<DisplayListOfSchedTasks> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.scheduledTasks.length,
      itemBuilder: (ctx, index) {
        var scheduledTask = widget.scheduledTasks[index];
        return InkWell(
          onLongPress: () {
            //Delete Task
          },
          onTap: () async {
            final updatedTask = await Navigator.push<ScheduleTask>(
              ctx,
              MaterialPageRoute(
                builder: (ctx) =>
                    ScheduleTaskDetails(scheduleTask: scheduledTask),
              ),
            );
            if (updatedTask != null) {
              setState(() {
                scheduledTask = updatedTask;
                widget.scheduledTasks[index] = updatedTask;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 80,
            decoration: BoxDecoration(
              color: colors.outlineVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.primary,
                      ),
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Icon(
                          scheduledTask.icon,
                          size: 30,
                          color: colors.surfaceBright,
                        ),
                      ),
                    ),
                    Gap(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scheduledTask.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          scheduledTask.note ?? '',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                if (scheduledTask.type == TaskType.daily)
                  Text('Todo Dia')
                else if (scheduledTask.type == TaskType.single)
                  Text(
                    DateFormat('dd/MM/yyyy').format(scheduledTask.singleDate!),
                  )
                else if (scheduledTask.type == TaskType.monthly)
                  Text('Dia ${scheduledTask.dayOfMonth}')
                else if (scheduledTask.type == TaskType.weekly)
                  DisplayTinyWeekDays(activeWeekDays: scheduledTask.weekDays)
                else
                  Text(''),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(thickness: 1.5);
      },
    );
  }
}
