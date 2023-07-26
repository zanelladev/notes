import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:your_notes/src/modules/folders/presenter/ui/widgets/folder_button_widget.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({super.key});

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  static final ValueNotifier<List<Folder>> foldersNotifier = ValueNotifier([]);
  Future<List<Folder>>? futureFolders;
  final folderDB = FolderDB();

  @override
  void initState() {
    super.initState();
    fetchFolders();
  }

  void fetchFolders() async {
    futureFolders = folderDB.fetchAll();
    foldersNotifier.value = await futureFolders as List<Folder>;
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
              child: ValueListenableBuilder(
                  valueListenable: foldersNotifier,
                  builder: (context, value, _) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: foldersNotifier.value.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        final todo = foldersNotifier.value[index];
                        return FolderCard(
                          id: todo.id,
                          title: todo.title,
                          notesQuantity: todo.notesCount,
                          onPressed: () =>
                              Modular.to.pushNamed('/notes/', arguments: index),
                        );
                      },
                    );
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FolderButtonWidget(
        fetchFunction: () => fetchFolders(),
      ),
    );
  }
}
