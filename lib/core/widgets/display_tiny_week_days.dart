import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/models/models.dart';
import 'package:flutter/material.dart';

class DisplayTinyWeekDays extends StatelessWidget {
  const DisplayTinyWeekDays({super.key, this.activeWeekDays});
  final List<WeekDay>? activeWeekDays;
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final selectedDays = activeWeekDays ?? [];
    return Row(
      spacing: 5,
      children: WeekDay.values
          .map(
            (day) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: selectedDays.contains(day)
                        ? colors.primaryContainer
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  day.tinyLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedDays.contains(day)
                        ? colors.primaryContainer
                        : colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
