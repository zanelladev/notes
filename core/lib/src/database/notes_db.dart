import 'package:core/src/database/database_service.dart';
import 'package:dependencies/dependencies.dart';
import '../models/note_model.dart';

class NoteDB {
  final tableName = 'notes';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "title" TEXT NOT NULL,
      "content" TEXT NOT NULL,
      "update_at" INTEGER NOT NULL,
      "folder_id" INTEGER NOT NULL,
      "favorited" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY(folder_id) REFERENCES folders(id)
    );""");
  }

  Future<int> create({required int folderId}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (title, content, update_at, folder_id, favorited) VALUES (?, ?, ?, ?, ?)''',
        ['new note', '', DateTime.now().millisecondsSinceEpoch, folderId, 0]);
  }

  Future<List<Note>> fetchByFolder({required int folderId}) async {
    final database = await DatabaseService().database;
    final notes =
        await database.rawQuery('''SELECT * from $tableName WHERE folder_id = ? ORDER BY id DESC''', [folderId]);
    return notes.map((note) => Note.fromSqfliteDatabase(note)).toList();
  }

  Future<int> update({required int id, String? title, String? content, bool? isFavorited}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        if (title != null) 'title': title,
        if (content != null) 'content': content,
        if (isFavorited != null) 'favorited': isFavorited,
        'update_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<void> delete({required int id}) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }
}
