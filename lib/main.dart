import 'package:flutter/material.dart';
import 'package:flowly/core/config/config.dart';
import 'package:flowly/core/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'viewmodels/routine_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RoutineViewModel(),
      child: const FlowlyApp(),
    ),
  );
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
