import 'dart:convert';

import 'package:flowly/core/config/database/app_database.dart';
import 'package:flowly/models/models.dart';

class NoteRepository {
  Future<int> insert(Note note) async {
    final db = await AppDatabase.database;
    print(note);
    return db.insert('notes', note.toMap());
  }

  Future<List<Note>> getAll() async {
    final db = await AppDatabase.database;
    final result = await db.query(
      'notes',
      orderBy: 'pinned_at DESC, updated_at DESC',
    );
    return result.map((e) => Note.fromMap(e)).toList();
  }

  Future<Note?> getByUuid(String uuid) async {
    final db = await AppDatabase.database;
    final result = await db.query(
      'notes',
      where: 'uuid = ?',
      whereArgs: [uuid],
      limit: 1,
    );
    if (result.isEmpty) {
      return null;
    }
    return Note.fromMap(result.first);
  }

  Future<int> update(Note note) async {
    final db = await AppDatabase.database;
    return db.update(
      'notes',
      note.toMap(),
      where: 'uuid = ?',
      whereArgs: [note.uuid],
    );
  }

  Future<int> updateDocument({
    required String uuid,
    required String title,
    required Map<String, dynamic> document,
    required String preview,
  }) async {
    final db = await AppDatabase.database;
    return db.update(
      'notes',
      {
        'title': title,
        'document': jsonEncode(document),
        'preview': preview,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
        'pending_sync': 1,
      },
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<bool> pinNote(String uuid) async {
    final db = await AppDatabase.database;
    final pinnedNotes = await db.query(
      'notes',
      columns: ['uuid'],
      where: 'pinned_at IS NOT NULL',
    );
    if (pinnedNotes.length >= 3) {
      return false;
    }

    await db.update(
      'notes',

      {
        'pinned_at': DateTime.now().millisecondsSinceEpoch,

        'updated_at': DateTime.now().millisecondsSinceEpoch,

        'pending_sync': 1,
      },

      where: 'uuid = ?',

      whereArgs: [uuid],
    );

    return true;
  }

  Future<void> unpinNote(String uuid) async {
    final db = await AppDatabase.database;

    await db.update(
      'notes',
      {
        'pinned_at': null,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
        'pending_sync': 1,
      },
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<void> markAsSynced(String uuid) async {
    final db = await AppDatabase.database;
    await db.update(
      'notes',
      {'pending_sync': 0},
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<List<Note>> getPendingSync() async {
    final db = await AppDatabase.database;
    final result = await db.query('notes', where: 'pending_sync = 1');
    return result.map((e) => Note.fromMap(e)).toList();
  }

  Future<void> delete(String uuid) async {
    final db = await AppDatabase.database;
    await db.delete('notes', where: 'uuid = ?', whereArgs: [uuid]);
  }
}
