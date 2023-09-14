import 'package:core/core.dart';

abstract class FolderRepository {
  Future<List<Folder>> findAll();
  Future<int> updateCount({required int id, required newCount});
  Future<int> create({required String title});
}
