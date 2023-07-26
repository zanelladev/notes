class Note {
  final int id;
  final String title;
  final String content;
  final String updateAt;
  final int folderId;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.updateAt,
    required this.folderId,
  });

  static String getFormatedData() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }

  factory Note.fromSqfliteDatabase(Map<String, dynamic> map) => Note(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? '',
        content: map['content'] ?? '',
        updateAt: getFormatedData(),
        folderId: map['folder_id'] ?? 0,
      );
}
