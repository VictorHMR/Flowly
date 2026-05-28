import 'package:flowly/core/controllers/controllers.dart';
import 'package:flowly/models/note.dart';
import 'package:flowly/models/schedule_task.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flowly/views/notes/notes_screen.dart';
import 'package:flowly/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/views/home/home_screen.dart';
import 'package:flowly/views/routine/routine_screen.dart';
import 'package:provider/provider.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentPageIndex = 1;
  final titles = ['Cronograma', 'Hoje', 'Notas'];
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    final schedTaskSelection = context
        .watch<SelectionController<ScheduleTask>>();
    final notesSelection = context.watch<SelectionController<Note>>();

    final isRoutinePage = currentPageIndex == 0;
    final isNotesPage = currentPageIndex == 2;

    final isNotesSelection = isNotesPage && notesSelection.isSelectionMode;
    final isRoutineSelection =
        isRoutinePage && schedTaskSelection.isSelectionMode;

    return Scaffold(
      appBar: AppBar(
        leading: (isRoutineSelection || isNotesSelection)
            ? IconButton(
                onPressed: () {
                  if (isRoutineSelection) {
                    schedTaskSelection.clear();
                  } else {
                    notesSelection.clear();
                  }
                },
                icon: const Icon(Icons.close),
              )
            : null,
        title: Text(
          (isRoutineSelection || isNotesSelection)
              ? '${isRoutineSelection ? schedTaskSelection.selectedItems.length : notesSelection.selectedItems.length} selecionados'
              : titles[currentPageIndex],
        ),
        actions: [
          if (isRoutineSelection)
            IconButton(
              onPressed: () async {
                await context.read<ScheduleTaskViewModel>().deleteTasks(
                  schedTaskSelection.selectedItems,
                );

                schedTaskSelection.clear();
              },
              icon: const Icon(Icons.delete),
            )
          else if (isNotesSelection)
            IconButton(
              onPressed: () async {
                await context.read<NoteViewModel>().deleteNotes(
                  notesSelection.selectedItems,
                );

                notesSelection.clear();
              },
              icon: const Icon(Icons.delete),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.transparent,
                child: IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ConfigsScreen()),
                    );
                  },
                  icon: const Icon(Icons.settings_outlined),
                  iconSize: 28,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) async {
          setState(() {
            currentPageIndex = index;
          });
          if (index == 1) {
            await context.read<TaskOccurrenceViewModel>().loadTaskOccurrences();
          }
        },
        indicatorColor: colors.primary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.calendar_view_week_outlined),
            label: 'Cronograma',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Hoje',
          ),
          NavigationDestination(icon: Icon(Icons.notes), label: 'Notas'),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: const <Widget>[RoutineScreen(), HomeScreen(), NotesScreen()],
      ),
    );
  }
}
