import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/models/models.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flowly/views/schedule_task/schedule_task_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/display_list_of_sched_tasks.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ScheduleTaskViewModel>().loadScheduledTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Align(
          alignment: AlignmentGeometry.topCenter,
          child: SizedBox(
            width: screenSize.width * 0.9,
            child: DisplayListOfSchedTasks(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push<ScheduleTask>(
            context,
            MaterialPageRoute(builder: (ctx) => ScheduleTaskDetails()),
          );
        },
        backgroundColor: colors.primary,
        foregroundColor: colors.surface,
        child: const Icon(Icons.add_outlined, size: 40),
      ),
    );
  }
}
