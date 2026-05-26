import 'package:flowly/core/controllers/controllers.dart';
import 'package:flowly/core/widgets/widgets.dart';
import 'package:flowly/models/schedule_task.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flowly/views/schedule_task/schedule_task_details.dart';
import 'package:flutter/material.dart';
import 'package:flowly/core/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DisplayListOfSchedTasks extends StatelessWidget {
  const DisplayListOfSchedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final selection = context.watch<SelectionController<ScheduleTask>>();
    final viewModel = context.watch<ScheduleTaskViewModel>();

    return ListView.separated(
      shrinkWrap: true,
      itemCount: viewModel.scheduleTasks.length,
      itemBuilder: (ctx, index) {
        final scheduledTask = viewModel.scheduleTasks[index];
        final isSelected = selection.isSelected(scheduledTask);
        return InkWell(
          onLongPress: () {
            selection.select(scheduledTask);
          },
          onTap: () async {
            if (selection.isSelectionMode) {
              selection.toggle(scheduledTask);
              return;
            }
            await Navigator.push(
              ctx,
              MaterialPageRoute(
                builder: (_) =>
                    ScheduleTaskDetails(scheduleTask: scheduledTask),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 80,
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.primaryContainer
                  : colors.outlineVariant,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: colors.primary, width: 2)
                  : null,
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
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Icon(
                          scheduledTask.icon,
                          size: 30,
                          color: colors.surfaceBright,
                        ),
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            scheduledTask.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            scheduledTask.note ?? '',
                            style: const TextStyle(fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (scheduledTask.type == TaskType.daily)
                  const Text('Todo Dia')
                else if (scheduledTask.type == TaskType.single)
                  Text(
                    DateFormat('dd/MM/yyyy').format(scheduledTask.singleDate!),
                  )
                else if (scheduledTask.type == TaskType.monthly)
                  Text('Dia ${scheduledTask.dayOfMonth}')
                else if (scheduledTask.type == TaskType.weekly)
                  DisplayTinyWeekDays(activeWeekDays: scheduledTask.weekDays)
                else
                  const SizedBox(),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(thickness: 1.5),
    );
  }
}
