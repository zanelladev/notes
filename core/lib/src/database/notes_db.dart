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
      "update_at" TEXT NOT NULL,
      "folder_id" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY(folder_id) REFERENCES folders(id)
    );""");
  }

  Future<int> create() async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (title, content, update_at) VALUES (?, ?, ?)''',
        ['empty title', '', Note.getFormatedData()]);
  }

  Future<List<Note>> fetchAll() async {
    final database = await DatabaseService().database;
    final notes = await database
        .rawQuery('''SELECT * from $tableName ORDER BY id DESC''');
    return notes.map((note) => Note.fromSqfliteDatabase(note)).toList();
  }

  Future<int> update({required int id, String? title, String? content}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        if (title != null) 'title': title,
        if (content != null) 'content': content,
        'update_at': Note.getFormatedData(),
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
