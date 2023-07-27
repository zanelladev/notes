import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotePage extends StatefulWidget {
  final Map<String, dynamic> folderNoteInfo;
  const NotePage({super.key, required this.folderNoteInfo});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
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
    final Folder folder = widget.folderNoteInfo["folder"];
    futureNotes = notesDB.fetchByFolder(folderId: folder.id);
    notesNotifier.value = await futureNotes as List<Note>;
  }

  @override
  Widget build(BuildContext context) {
    final folder = widget.folderNoteInfo["folder"];
    final note = widget.folderNoteInfo["note"];
    final theme = Theme.of(context);
    final textStyles = theme.extension<NotesTextStylesExtension>()!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: NotesSystemChromeSettings.dark,
      child: Scaffold(
        backgroundColor: theme.colorScheme.onBackground,
        body: SingleChildScrollView(
          child: Column(
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
                            Ionicons.arrow_back_outline,
                            color: theme.colorScheme.background,
                            size: 28,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(16),
                          child: Icon(
                            Ionicons.bookmark_outline,
                            color: theme.colorScheme.background,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '${folder.title}  •  ${note.updateAt}',
                      style: textStyles.smallTextGrey
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      style: textStyles.headlineSDark,
                      initialValue: note.title,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      cursorColor: theme.colorScheme.secondary,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      onChanged: (value) {
                        notesDB.update(id: note.id, title: value);
                      },
                    ),
                    SingleChildScrollView(
                      child: TextFormField(
                        style: textStyles.smallTextGrey,
                        initialValue: note.content,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        cursorColor: theme.colorScheme.secondary,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          notesDB.update(id: note.id, content: value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
