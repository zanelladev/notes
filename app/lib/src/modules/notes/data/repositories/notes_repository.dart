import 'package:core/core.dart';

abstract class NotesRepository {
  Future<List<Note>> findByFolder({required int folderId});
  Future<int> create({required int folderId});
  Future<int> update({required int id, String? title, String? content});
}
