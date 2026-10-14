/// One note, mapped to/from a node under `notes/{id}` in Realtime Database.
class Note {
  final String id;
  final String title;
  final String body;
  final String collection;
  final bool archived;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? imageUrl;

  const Note({
    required this.id,
    required this.title,
    required this.body,
    required this.collection,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
  });

  factory Note.fromMap(String id, Map<dynamic, dynamic> map) {
    final img = map['imageUrl'] as String?;
    return Note(
      id: id,
      title: (map['title'] ?? '') as String,
      body: (map['body'] ?? '') as String,
      collection: (map['collection'] ?? '') as String,
      archived: map['archived'] == true,
      createdAt: DateTime.tryParse('${map['createdAt']}') ?? DateTime.now(),
      updatedAt: DateTime.tryParse('${map['updatedAt']}') ?? DateTime.now(),
      imageUrl: (img == null || img.isEmpty) ? null : img,
    );
  }
}
