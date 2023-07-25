class Folder {
  final int id;
  final String title;
  final int notesCount;

  Folder({
    required this.id,
    required this.title,
    required this.notesCount,
  });

  factory Folder.fromSqfliteDatabase(Map<String, dynamic> map) => Folder(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? '',
        notesCount: map['notesCount']?.toInt() ?? 0,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'notesCount': notesCount,
    };
  }

  @override
  String toString() {
    return 'Folder{id: $id, title: $title, notesCount: $notesCount}';
  }
}
