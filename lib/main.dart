import 'package:flutter/material.dart';
import 'package:flowly/core/config/config.dart';
import 'package:flowly/core/widgets/widgets.dart';

void main() {
  runApp(const FlowlyApp());
}

class FlowlyApp extends StatelessWidget {
  const FlowlyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: Navbar(),
    );
  }
}
