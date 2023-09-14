import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_notes/src/modules/folders/presenter/blocs/folders_cubit.dart';
import 'package:your_notes/src/modules/notes/presenter/blocs/notes_cubit.dart';
import 'package:your_notes/src/modules/notes/presenter/blocs/notes_state.dart';

class GeneralNotesPage extends StatefulWidget {
  final Folder folder;

  const GeneralNotesPage({
    super.key,
    required this.folder,
  });

  @override
  State<GeneralNotesPage> createState() => _GeneralNotesPageState();
}

class _GeneralNotesPageState extends State<GeneralNotesPage> {
  final NotesCubit notesCubit = Modular.get();

  @override
  void initState() {
    notesCubit.loadNotes(folderId: widget.folder.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.extension<NotesTextStylesExtension>()!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: NotesSystemChromeSettings.dark,
      child: Scaffold(
        backgroundColor: theme.colorScheme.onBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(28).copyWith(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: Modular.to.pop,
                        borderRadius: BorderRadius.circular(16),
                        child: Icon(
                          Ionicons.return_down_back,
                          color: theme.colorScheme.background,
                          size: 28,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          notesCubit.addNote(folderId: widget.folder.id);
                          final FoldersCubit foldersCubit = Modular.get();
                          foldersCubit.updateCount(folderId: widget.folder.id);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Icon(
                          Ionicons.add,
                          color: theme.colorScheme.background,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(widget.folder.title, style: textStyles.headlineSDark),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: BlocBuilder<NotesCubit, NotesState>(
                  bloc: notesCubit,
                  builder: (context, state) {
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(
                        state.notes.length,
                        (index) {
                          final note = state.notes[index];
                          final Map<String, dynamic> folderNoteInfo = {
                            "folder": widget.folder,
                            "note": note,
                          };
                          return NoteCard(
                            title: note.title,
                            contentPreview: note.content,
                            onTap: () {
                              Modular.to
                                  .pushNamed('note', arguments: folderNoteInfo);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
