import 'package:core/core.dart';

abstract class FoldersState {
  final List<Folder> folders;

  FoldersState({required this.folders});
}

class FoldersInitialState extends FoldersState {
  FoldersInitialState() : super(folders: []);
}

class FoldersLoadingState extends FoldersState {
  FoldersLoadingState() : super(folders: []);
}

class FoldersSuccessState extends FoldersState {
  FoldersSuccessState({required List<Folder> folders})
      : super(folders: folders);
}
