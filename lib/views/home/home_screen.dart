import 'package:flowly/core/widgets/widgets.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'widgets/daily_percent_indicator.dart';
import 'widgets/display_list_of_task_occurrence.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TaskOccurrenceViewModel>().loadTaskOccurrences();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskOccurrenceViewModel>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SectionTitle(textValue: 'Tarefas Hoje'),
            Gap(20),
            DailyPercentIndicator(),
            Gap(20),
            DisplayListOfTaskOccurrence(isCompleted: false),
            Gap(20),
            DisplayListOfTaskOccurrence(isCompleted: true),
          ],
        ),
      ),
    );
  }
}
