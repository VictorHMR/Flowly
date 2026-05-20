import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/core/widgets/display_list_of_sched_tasks.dart';
import 'package:flowly/models/models.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;
    return Scaffold(
      body: Positioned(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Align(
            alignment: AlignmentGeometry.topCenter,
            child: SizedBox(
              width: screenSize.width * 0.9,
              child: DisplayListOfSchedTasks(
                scheduleTasks: [
                  ScheduleTask(title: 'Teste', type: TaskType.weekly),
                  ScheduleTask(
                    title: 'Teste 2',
                    type: TaskType.weekly,
                    note: 'testando uma nota',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
