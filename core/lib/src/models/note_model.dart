class Note {
  final int id;
  final String title;
  final String content;
  final String updateAt;
  final bool isFavorited;
  final int folderId;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.updateAt,
    required this.isFavorited,
    required this.folderId,
  });

  static String getFormatedData({required millisecondsSinceEpoch}) {
    final now = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final String month;
    final String day;
    now.day < 10 ? day = '0${now.day}' : day = '${now.day}';
    now.month < 10 ? month = '0${now.month}' : month = '${now.month}';

    return '$day/$month/${now.year}';
  }

  factory Note.fromSqfliteDatabase(Map<String, dynamic> map) => Note(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? '',
        content: map['content'] ?? '',
        updateAt: getFormatedData(millisecondsSinceEpoch: map['update_at']),
        isFavorited: map['content'] == 1 ? true : false,
        folderId: map['folder_id'] ?? 0,
      );
}
