import 'package:flowly/models/models.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:flowly/core/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'task_occorrence_tile.dart';

class DisplayListOfTaskOccurrence extends StatelessWidget {
  const DisplayListOfTaskOccurrence({super.key, required this.isCompleted});

  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final viewModel = context.watch<TaskOccurrenceViewModel>();

    final List<TaskOccurrence> taskOccurrences = isCompleted
        ? viewModel.completedTasks
        : viewModel.pendingTasks;

    return taskOccurrences.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
              color: colors.outlineVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    '${taskOccurrences.length} ${isCompleted ? 'Feito' : 'Pendente'}${taskOccurrences.isNotEmpty ? 's' : ''}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Divider(thickness: 1, color: colors.primaryContainer),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: taskOccurrences.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final taskOccurrence = taskOccurrences[index];
                    return TaskOccorrenceTile(taskOccurrence: taskOccurrence);
                  },
                  separatorBuilder: (_, __) => const Divider(thickness: 1),
                ),
                Gap(10),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
