import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class DailyPercentIndicator extends StatefulWidget {
  const DailyPercentIndicator({super.key});

  @override
  State<DailyPercentIndicator> createState() => _DailyPercentIndicatorState();
}

class _DailyPercentIndicatorState extends State<DailyPercentIndicator> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final viewModel = context.watch<TaskOccurrenceViewModel>();
    return Column(
      children: [
        CircularPercentIndicator(
          percent: viewModel.progressPercent,
          progressColor: colors.primaryContainer,
          lineWidth: 14,
          radius: 75.0,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(viewModel.progressPercent * 100).floor()}%',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Concluído'),
            ],
          ),
        ),
      ],
    );
  }
}
