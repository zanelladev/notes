import 'package:core/core.dart';
import 'package:your_notes/src/modules/folders/data/repositories/folders_repository.dart';

class FoldersRepositoryConcrete implements FolderRepository {
  FoldersRepositoryConcrete();

  @override
  Future<List<Folder>> findAll() async {
    return await FolderDB().fetchAll();
  }

  @override
  Future<int> updateCount({required int id, required newCount}) async {
    return await FolderDB().updateCount(id: id, newCount: newCount);
  }

  @override
  Future<int> create({required String title}) async {
    return await FolderDB().create(title: title);
  }
}
