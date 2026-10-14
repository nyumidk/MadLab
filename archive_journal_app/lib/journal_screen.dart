import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'note.dart';
import 'note_card.dart';
import 'note_service.dart';
import 'start_card.dart';
import 'theme.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key, required this.onWrite});
  final VoidCallback onWrite;

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  // Created once, so rebuilds don't re-subscribe to Firebase.
  late final Stream<List<Note>> _stream = noteService.watchNotes();

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  int _columnsFor(double width) => width < 600 ? 1 : (width < 1000 ? 2 : 3);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEEE, MMMM d').format(DateTime.now()).toUpperCase(),
            style: labelStyle,
          ),
          const SizedBox(height: 4),
          Text('$_greeting, Archivist.', style: displayStyle(40)),
          const SizedBox(height: 24),
          StreamBuilder<List<Note>>(
            stream: _stream,
            builder: (context, snap) {
              if (snap.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('⚠️ ${snap.error}',
                      style: const TextStyle(color: Colors.red)),
                );
              }
              if (!snap.hasData) {
                return const Padding(
                  padding: EdgeInsets.all(48),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return _grid(snap.data!);
            },
          ),
        ],
      ),
    );
  }

  // Simple masonry: deal cards round-robin into N columns.
  Widget _grid(List<Note> notes) {
    return LayoutBuilder(builder: (context, constraints) {
      final cols = _columnsFor(constraints.maxWidth);
      final items = <Widget>[
        StartWritingCard(onTap: widget.onWrite),
        for (var i = 0; i < notes.length; i++)
          NoteCard(note: notes[i], torn: i.isOdd),
      ];
      final columns = List.generate(cols, (_) => <Widget>[]);
      for (var i = 0; i < items.length; i++) {
        columns[i % cols].add(Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: items[i],
        ));
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < cols; i++) ...[
            if (i > 0) const SizedBox(width: 16),
            Expanded(child: Column(children: columns[i])),
          ],
        ],
      );
    });
  }
}
