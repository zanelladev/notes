import 'package:dependencies/dependencies.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_notes/src/modules/notes/presenter/blocs/notes_cubit.dart';
import 'package:your_notes/src/modules/notes/presenter/blocs/notes_state.dart';

class NotePage extends StatelessWidget {
  final Map<String, dynamic> folderNoteInfo;
  NotePage({super.key, required this.folderNoteInfo});

  final NotesCubit notesCubit = Modular.get();

  @override
  Widget build(BuildContext context) {
    final folder = folderNoteInfo["folder"];
    final note = folderNoteInfo["note"];
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
                child: BlocBuilder<NotesCubit, NotesState>(
                  bloc: notesCubit,
                  builder: (context, state) {
                    return Column(
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
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomAlertDialog(
                                      isFolder: false,
                                      title: note.title,
                                      deleteFunction: () {},
                                    );
                                  },
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Icon(
                                Ionicons.trash_outline,
                                color: theme.colorScheme.background,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
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
                            notesCubit.updateNote(id: note.id, title: value);
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
                              notesCubit.updateNote(
                                  id: note.id, content: value);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
