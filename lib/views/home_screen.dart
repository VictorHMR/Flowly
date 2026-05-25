import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/models/models.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      context.read<HomeViewModel>().loadTaskOccurrences();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;
    final colors = Theme.of(context).colorScheme;
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      body: ListView.builder(
        itemCount: viewModel.taskOccurrences.length,
        itemBuilder: (ctx, index) {
          final taskOccurrence = viewModel.taskOccurrences[index];
          return Text(taskOccurrence.toMap().toString());
        },
      ),
    );
  }
}
