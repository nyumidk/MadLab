import 'package:flutter/material.dart';

import 'journal_screen.dart';
import 'quick_add_dialog.dart';
import 'sidebar.dart';
import 'theme.dart';

/// Wide screens get a sidebar; phones get a bottom navigation bar.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  static const _labels = ['Journal', 'Write', 'Archive', 'Collections'];
  static const _icons = [
    Icons.menu_book,
    Icons.edit_note,
    Icons.inventory_2_outlined,
    Icons.collections_bookmark_outlined,
  ];
  int _index = 0;

  void _select(int i) {
    if (i == 1) {
      showQuickAdd(context); // "Write" opens the editor instead of a page
      return;
    }
    setState(() => _index = i);
  }

  Widget get _page => _index == 0
      ? JournalScreen(onWrite: () => showQuickAdd(context))
      : Center(
          child: Text('${_labels[_index]} — coming in the next step',
              style: titleStyle),
        );

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 800;
    if (wide) {
      return Scaffold(
        body: Row(children: [
          Sidebar(
            labels: _labels,
            icons: _icons,
            selected: _index,
            onSelect: _select,
            onQuickScribble: () => showQuickAdd(context),
          ),
          Expanded(child: _page),
        ]),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('The Living Archive', style: displayStyle(22)),
      ),
      body: _page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _select,
        destinations: [
          for (var i = 0; i < _labels.length; i++)
            NavigationDestination(icon: Icon(_icons[i]), label: _labels[i]),
        ],
      ),
    );
  }
}
