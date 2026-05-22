import 'package:flutter/material.dart';
import 'package:flowly/core/utils/utils.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.textValue});
  final String textValue;
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          textValue,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: 70,
          height: 4,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}
