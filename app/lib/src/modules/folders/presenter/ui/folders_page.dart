import 'package:dependencies/dependencies.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:your_notes/src/modules/folders/presenter/blocs/folders_cubit.dart';
import 'package:your_notes/src/modules/folders/presenter/blocs/folders_state.dart';
import 'package:your_notes/src/modules/folders/presenter/ui/widgets/folder_button_widget.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({super.key});

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  final FoldersCubit foldersCubit = Modular.get();

  @override
  void initState() {
    foldersCubit.loadFolders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.extension<NotesTextStylesExtension>()!;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                Text('folders', style: textStyles.headlineSLight),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<FoldersCubit, FoldersState>(
                bloc: foldersCubit,
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.folders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final folder = state.folders[index];

                      return FolderCard(
                        id: folder.id,
                        title: folder.title,
                        notesQuantity: folder.notesCount,
                        onPressed: () => Modular.to.pushNamed(
                          '/notes/',
                          arguments: folder,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const FolderButtonWidget(),
    );
  }
}
