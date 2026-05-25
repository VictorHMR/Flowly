import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'flowly.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE schedule_tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            type TEXT NOT NULL,
            icon INTEGER NOT NULL,
            note TEXT,
            week_days TEXT,
            day_of_month INTEGER,
            single_date INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE task_occurrence(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date INTEGER NOT NULL,
            scheduleTaskId INTEGER NOT NULL,
            isComplete INTERGER NOT NULL,

            FOREIGN KEY (scheduleTaskId) REFERENCES schedule_task(id),
            UNIQUE(scheduleTaskId, date)
          )
        ''');
      },
    );
  }
}
