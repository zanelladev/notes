import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:your_notes/src/modules/notes/presenter/blocs/notes_state.dart';
import 'package:your_notes/src/modules/notes/data/repositories/notes_repository.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository repository;
  NotesCubit(this.repository) : super(NotesInitialState());

  void loadNotes({required folderId}) async {
    final List<Note> notes = await repository.findByFolder(folderId: folderId);
    emit(NotesSuccessState(notes: notes));
  }

  void addNote({required folderId}) async {
    repository.create(folderId: folderId);
    final List<Note> notes = await repository.findByFolder(folderId: folderId);
    emit(NotesSuccessState(notes: notes));
  }

  void updateNote({required int id, String? title, String? content}) {
    repository.update(id: id, title: title, content: content);

    final updatedNotes = state.notes.map((note) {
      if (note.id == id) {
        return Note(
          id: id,
          title: title ?? note.title,
          content: content ?? note.content,
          updateAt: Note.getFormatedData(
              millisecondsSinceEpoch: DateTime.now().millisecondsSinceEpoch),
          folderId: note.id,
          isFavorited: note.isFavorited,
        );
      }
      return note;
    }).toList();
    emit(NotesSuccessState(notes: updatedNotes));
  }
}
