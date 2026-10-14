import 'package:firebase_database/firebase_database.dart';

import 'note.dart';

/// Every Firebase call lives here, so the UI never touches the database.
class NoteService {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('notes');

  /// Live list of notes, newest first, filtered by archived state.
  Stream<List<Note>> watchNotes({bool archived = false}) {
    return _ref.onValue.map((event) {
      final raw = event.snapshot.value;
      if (raw == null) return <Note>[];
      final data = Map<dynamic, dynamic>.from(raw as Map);
      return data.entries
          .map((e) => Note.fromMap(
              e.key as String, Map<dynamic, dynamic>.from(e.value as Map)))
          .where((n) => n.archived == archived)
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  Future<void> add({
    required String title,
    required String body,
    String collection = '',
    String? imageUrl,
  }) {
    final now = DateTime.now().toIso8601String();
    return _ref.push().set({
      'title': title,
      'body': body,
      'collection': collection,
      'archived': false,
      'createdAt': now,
      'updatedAt': now,
      'imageUrl': imageUrl ?? '',
    });
  }

  Future<void> update(String id, Map<String, Object?> changes) {
    return _ref.child(id).update({
      ...changes,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> setArchived(String id, bool value) =>
      update(id, {'archived': value});

  Future<void> delete(String id) => _ref.child(id).remove();
}

final noteService = NoteService();
