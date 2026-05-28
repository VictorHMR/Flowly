import 'package:flowly/core/controllers/controllers.dart';
import 'package:flowly/models/models.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flowly/views/notes/note_editor_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DisplayListOfNotes extends StatelessWidget {
  const DisplayListOfNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final viewModel = context.watch<NoteViewModel>();
    final selection = context.watch<SelectionController<Note>>();

    return GridView.builder(
      shrinkWrap: true,
      itemCount: viewModel.notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        final note = viewModel.notes[index];
        final isSelected = selection.isSelected(note);

        return InkWell(
          onLongPress: () {
            selection.select(note);
          },
          onTap: () async {
            if (selection.isSelectionMode) {
              selection.toggle(note);
              return;
            }
            await Navigator.push(
              ctx,
              MaterialPageRoute(builder: (_) => NoteEditorScreen(note: note)),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 80,
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.primaryContainer
                  : colors.outlineVariant,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: colors.primary, width: 2)
                  : null,
            ),
            child: SizedBox(
              width: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    note.preview,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
