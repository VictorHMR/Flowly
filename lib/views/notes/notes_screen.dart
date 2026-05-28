import 'package:flowly/models/models.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flowly/views/notes/note_editor_screen.dart';
import 'package:flowly/views/notes/widgets/display_list_of_notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NoteViewModel>().loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'notes_list_fab',
        onPressed: () async {
          await Navigator.push<Note>(
            context,
            MaterialPageRoute(builder: (ctx) => NoteEditorScreen()),
          );
        },
        backgroundColor: colors.primary,
        foregroundColor: colors.surface,
        child: const Icon(Icons.add_outlined, size: 40),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: DisplayListOfNotes(),
      ),
    );
  }
}
