import 'package:flowly/models/schedule_task.dart';
import 'package:flutter/material.dart';
import 'package:flowly/core/utils/utils.dart';
import 'package:gap/gap.dart';

class DisplayListOfSchedTasks extends StatelessWidget {
  const DisplayListOfSchedTasks({super.key, required this.scheduleTasks});

  final List<ScheduleTask> scheduleTasks;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: scheduleTasks.length,
      itemBuilder: (ctx, index) {
        final scheduledTask = scheduleTasks[index];
        return InkWell(
          onLongPress: () {
            //Delete Task
          },
          onTap: () {
            //ShowDetails
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
                      child: Center(child: Icon(Icons.circle)),
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
                Text('Seg, Ter, Qua'),
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
