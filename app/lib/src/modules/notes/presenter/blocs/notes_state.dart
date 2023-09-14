import 'package:core/core.dart';

abstract class NotesState {
  final List<Note> notes;

  NotesState({required this.notes});
}

class NotesInitialState extends NotesState {
  NotesInitialState() : super(notes: []);
}

class NotesLoadingState extends NotesState {
  NotesLoadingState() : super(notes: []);
}

class NotesSuccessState extends NotesState {
  NotesSuccessState({required List<Note> notes}) : super(notes: notes);
}
