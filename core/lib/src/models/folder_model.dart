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

  Folder copyWith({
    int? id,
    String? title,
    int? notesCount,
  }) {
    return Folder(
      id: id ?? this.id,
      title: title ?? this.title,
      notesCount: notesCount ?? this.notesCount,
    );
  }
}
