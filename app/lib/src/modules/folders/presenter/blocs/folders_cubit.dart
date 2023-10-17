import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:your_notes/src/modules/folders/data/repositories/folders_repository.dart';
import 'package:your_notes/src/modules/folders/presenter/blocs/folders_state.dart';
import 'package:your_notes/src/modules/notes/data/repositories/notes_repository_concrete.dart';

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

  Future<void> updateCountUp({required int folderId}) async {
    await repository.updateCount(
        id: folderId, newCount: state.folders[folderId - 1].notesCount + 1);
    final newFolders = state.folders.map((folder) {
      if (folder.id == folderId) {
        return Folder(
          id: folderId,
          title: folder.title,
          notesCount: folder.notesCount + 1,
        );
      }
      return folder;
    }).toList();
    emit(FoldersSuccessState(folders: newFolders));
  }

  Future<void> updateCountDown({required int folderId}) async {
    await repository.updateCount(
        id: folderId, newCount: state.folders[folderId - 1].notesCount + 1);
    final newFolders = state.folders.map((folder) {
      if (folder.id == folderId) {
        return Folder(
          id: folderId,
          title: folder.title,
          notesCount: folder.notesCount - 1,
        );
      }
      return folder;
    }).toList();
    emit(FoldersSuccessState(folders: newFolders));
  }

  Future<void> deleteFolder({required int folderId}) async {
    NotesRepositoryConcrete notesRepository = Modular.get();
    await repository.delete(folderId: folderId);
    await notesRepository.deleteAllByFolder(folderId: folderId);
    state.folders.removeWhere((folder) => folder.id == folderId);

    emit(FoldersSuccessState(folders: state.folders));
  }
}
