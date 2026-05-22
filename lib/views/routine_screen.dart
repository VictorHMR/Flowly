import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/core/widgets/widgets.dart';
import 'package:flowly/models/models.dart';
import 'package:flowly/views/schedule_task_details.dart';
import 'package:flutter/material.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  late List<ScheduleTask> scheduledTasks;

  @override
  void initState() {
    super.initState();

    scheduledTasks = [
      ScheduleTask(
        id: 1,
        title: 'Teste',
        type: TaskType.weekly,
        weekDays: [
          WeekDay.monday,
          WeekDay.saturday,
          WeekDay.sunday,
          WeekDay.thursday,
          WeekDay.friday,
        ],
        icon: Icons.person,
      ),
      ScheduleTask(
        id: 2,
        title: 'Teste 2',
        type: TaskType.daily,
        note: 'testando uma nota',
        icon: Icons.alarm,
      ),
      ScheduleTask(
        id: 3,
        title: 'Teste 3',
        type: TaskType.monthly,
        note: 'testando uma nota',
        dayOfMonth: 20,
        icon: Icons.task,
      ),
      ScheduleTask(
        title: 'Teste 3',
        type: TaskType.single,
        note: 'testando uma nota',
        singleDate: DateTime(2026, 05, 30),
        icon: Icons.book,
      ),
    ];
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
            child: DisplayListOfSchedTasks(scheduledTasks: scheduledTasks),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newTask = await Navigator.push<ScheduleTask>(
            context,
            MaterialPageRoute(builder: (ctx) => ScheduleTaskDetails()),
          );
          if (newTask != null) {
            setState(() {
              scheduledTasks = [...scheduledTasks, newTask];
            });
          }
        },
        backgroundColor: colors.primary,
        foregroundColor: colors.surface,
        child: const Icon(Icons.add_outlined, size: 40),
      ),
    );
  }
}
