import 'package:core/src/database/database_service.dart';
import 'package:dependencies/dependencies.dart';
import '../models/folder_model.dart';

class FolderDB {
  final tableName = 'folders';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "title" TEXT NOT NULL,
      "notes_count" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create({required String title}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (title, notes_count) VALUES (?, ?)''',
        [title, 0]);
  }

  Future<List<Folder>> fetchAll() async {
    final database = await DatabaseService().database;
    final folders = await database
        .rawQuery('''SELECT * from $tableName ORDER BY notes_count DESC''');
    return folders.map((folder) => Folder.fromSqfliteDatabase(folder)).toList();
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }
}
