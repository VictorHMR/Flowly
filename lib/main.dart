import 'package:flowly/core/controllers/controllers.dart';
import 'package:flowly/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flowly/core/config/config.dart';
import 'package:flowly/core/widgets/widgets.dart';
import 'package:flowly/models/models.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppStartupService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoutineViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(
          create: (_) => SelectionController<ScheduleTask>(),
        ),
      ],

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
