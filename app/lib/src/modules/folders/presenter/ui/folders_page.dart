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
  Future<List<Folder>>? futureFolders;
  final folderDB = FolderDB();

  @override
  void initState() {
    super.initState();
    fetchFolders();
  }

  void fetchFolders() {
    setState(() {
      futureFolders = folderDB.fetchAll();
    });
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
              child: FutureBuilder(
                future: futureFolders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final todos = snapshot.data!;
                    return RefreshIndicator(
                      onRefresh: () async {
                        fetchFolders();
                      },
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: todos.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (_, index) {
                          final todo = todos[index];
                          return FolderCard(
                            title: todo.title,
                            notesQuantity: todo.notesCount,
                            onPressed: () =>
                                Modular.to.pushNamed('/notes/', arguments: '1'),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
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
