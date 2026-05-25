import 'package:flowly/services/services.dart';

class AppStartupService {
  static Future<void> initialize() async {
    await ScheduleGenerationService.generateTodayTasks();
  }
}
