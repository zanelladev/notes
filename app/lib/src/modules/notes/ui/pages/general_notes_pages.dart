import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralNotesPage extends StatefulWidget {
  final Map<String, dynamic> folderInfo;

  const GeneralNotesPage({
    super.key,
    required this.folderInfo,
  });

  @override
  State<GeneralNotesPage> createState() => _GeneralNotesPageState();
}

class _GeneralNotesPageState extends State<GeneralNotesPage> {
  static final ValueNotifier<List<Note>> notesNotifier = ValueNotifier([]);
  Future<List<Note>>? futureNotes;
  final notesDB = NoteDB();
  final folderDB = FolderDB();

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    final Folder folder = widget.folderInfo["folder"];
    futureNotes = notesDB.fetchByFolder(folderId: folder.id);
    notesNotifier.value = await futureNotes as List<Note>;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.extension<NotesTextStylesExtension>()!;
    final Folder folder = widget.folderInfo["folder"];

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
                        onTap: () async {
                          int beforeAdd = folder.notesCount;
                          await notesDB.create(folderId: folder.id);
                          beforeAdd++;
                          await folderDB.update(
                              id: folder.id, newCount: beforeAdd);
                          fetchNotes();
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
                  Text(folder.title, style: textStyles.headlineSDark),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ValueListenableBuilder(
                    valueListenable: notesNotifier,
                    builder: (context, value, _) {
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children:
                            List.generate(notesNotifier.value.length, (index) {
                          final note = notesNotifier.value[index];
                          final Map<String, dynamic> folderNoteInfo = {
                            "folder": folder,
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
                        }),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
