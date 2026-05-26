import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/models/models.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class TaskOccorrenceTile extends StatelessWidget {
  const TaskOccorrenceTile({
    super.key,
    required this.taskOccurrence,
    this.onChanged,
  });

  final TaskOccurrence taskOccurrence;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final viewModel = context.watch<TaskOccurrenceViewModel>();

    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        height: 60,
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
                      taskOccurrence.scheduleTask!.icon,
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
                        taskOccurrence.scheduleTask!.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        taskOccurrence.scheduleTask!.note ?? '',
                        style: const TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                activeColor: colors.primaryContainer,
                value: taskOccurrence.isComplete,
                onChanged: (value) {
                  if (value == false) return;
                  viewModel.completeTask(taskOccurrence);
                },
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
