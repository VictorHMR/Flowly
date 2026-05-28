import 'package:flowly/models/models.dart';
import 'package:flowly/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:uuid/uuid.dart';

class NoteViewModel extends ChangeNotifier {
  final repository = NoteRepository();

  List<Note> notes = [];
  bool isLoading = false;
  Future<void> loadNotes() async {
    isLoading = true;
    notifyListeners();
    notes = await repository.getAll();
    isLoading = false;
    notifyListeners();
  }

  Future<void> saveNote({
    required QuillController controller,
    required TextEditingController titleController,
    Note? existingNote,
  }) async {
    final delta = controller.document.toDelta().toJson();
    final plainText = controller.document.toPlainText();
    final preview = plainText.replaceAll('\n', ' ').trim();
    final now = DateTime.now();

    final note = Note(
      id: existingNote?.id,
      uuid: existingNote?.uuid ?? const Uuid().v4(),
      firebaseId: existingNote?.firebaseId,
      title: titleController.text.trim(),
      document: {'ops': delta},
      preview: preview,
      pendingSync: true,
      pinnedAt: existingNote?.pinnedAt,
      createdAt: existingNote?.createdAt ?? now,
      updatedAt: now,
    );

    if (existingNote == null) {
      await repository.insert(note);
    } else {
      await repository.update(note);
    }

    await loadNotes();
  }

  Future<void> deleteNotes(List<Note> notes) async {
    for (final note in notes) {
      await repository.delete(note.uuid);
    }
    await loadNotes();
  }
}
