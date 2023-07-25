class Note {
  final int id;
  final String title;
  final String content;
  final String updateAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.updateAt,
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
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'updateAt': updateAt,
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, updateAt: $updateAt}';
  }
}
