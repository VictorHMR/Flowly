import 'package:flowly/core/controllers/controllers.dart';
import 'package:flowly/models/schedule_task.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:flowly/core/utils/utils.dart';
import 'package:flowly/views/home_screen.dart';
import 'package:flowly/views/routine_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final selection = context.watch<SelectionController<ScheduleTask>>();
    final isRoutinePage = currentPageIndex == 0;
    return Scaffold(
      appBar: AppBar(
        leading: isRoutinePage && selection.isSelectionMode
            ? IconButton(
                onPressed: () {
                  selection.clear();
                },
                icon: const Icon(Icons.close),
              )
            : null,
        title: Text(
          isRoutinePage && selection.isSelectionMode
              ? '${selection.selectedItems.length} selecionados'
              : titles[currentPageIndex],
        ),
        actions: [
          if (isRoutinePage && selection.isSelectionMode)
            IconButton(
              onPressed: () async {
                await context.read<RoutineViewModel>().deleteTasks(
                  selection.selectedItems,
                );
                selection.clear();
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
                  onPressed: () {},
                  icon: const Icon(Icons.settings_outlined),
                  iconSize: 28,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: colors.primary,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(Icons.calendar_view_week_outlined),
            label: titles[0],
          ),
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: titles[1],
          ),
          NavigationDestination(icon: Icon(Icons.notes), label: 'Notas'),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          RoutineScreen(),
          HomeScreen(),
          Center(child: Text(titles[2])),
        ],
      ),
    );
  }
}
