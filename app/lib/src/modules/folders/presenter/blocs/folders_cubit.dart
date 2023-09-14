import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:your_notes/src/modules/folders/data/repositories/folders_repository.dart';
import 'package:your_notes/src/modules/folders/presenter/blocs/folders_state.dart';

class FoldersCubit extends Cubit<FoldersState> {
  final FolderRepository repository;
  FoldersCubit(this.repository) : super(FoldersInitialState());

  void loadFolders() async {
    final List<Folder> folders = await repository.findAll();
    emit(FoldersSuccessState(folders: folders));
  }

  void addFolder({required String title}) async {
    await repository.create(title: title);
    final List<Folder> folders = await FolderDB().fetchAll();
    emit(FoldersSuccessState(folders: folders));
  }

  Future<void> updateCount({required int folderId}) async {
    await repository.updateCount(
        id: folderId, newCount: state.folders[folderId - 1].notesCount + 1);
  }
}
