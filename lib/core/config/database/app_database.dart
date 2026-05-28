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
            single_date INTEGER,
            is_active INTERGER NOT NULL
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

        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uuid TEXT NOT NULL,
            firebase_id TEXT,
            title TEXT NOT NULL DEFAULT '',
            document TEXT NOT NULL DEFAULT '',
            preview TEXT NOT NULL DEFAULT '',
            pending_sync INTEGER NOT NULL DEFAULT 1,
            pinned_at INTEGER,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }
}
