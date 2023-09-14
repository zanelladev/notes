import 'package:core/core.dart';
import 'package:your_notes/src/modules/notes/data/repositories/notes_repository.dart';

class NotesRepositoryConcrete implements NotesRepository {
  NotesRepositoryConcrete();

  @override
  Future<List<Note>> findByFolder({required int folderId}) async {
    return await NoteDB().fetchByFolder(folderId: folderId);
  }

  @override
  Future<int> create({required int folderId}) async {
    return await NoteDB().create(folderId: folderId);
  }

  @override
  Future<int> update({required int id, String? title, String? content}) {
    if (title != null) {
      return NoteDB().update(id: id, title: title);
    } else {
      return NoteDB().update(id: id, content: content);
    }
  }
}