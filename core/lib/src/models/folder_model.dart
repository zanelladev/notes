class Folder {
  final int id;
  final String title;
  final int notesCount;

  const Folder({
    required this.id,
    required this.title,
    required this.notesCount,
  });

  factory Folder.fromSqfliteDatabase(Map<String, dynamic> map) => Folder(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? '',
        notesCount: map['notes_count']?.toInt() ?? 0,
      );
}
