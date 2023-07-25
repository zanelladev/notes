import 'package:dependencies/dependencies.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralNotesPage extends StatefulWidget {
  final String folderId;

  const GeneralNotesPage({super.key, required this.folderId});

  @override
  State<GeneralNotesPage> createState() => _GeneralNotesPageState();
}

class _GeneralNotesPageState extends State<GeneralNotesPage> {
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
                        onTap: () {},
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
                  Text('personal notes', style: textStyles.headlineSDark),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(
                    10,
                    (index) => NoteCard(
                      title: 'how I found a new dream',
                      contentPreview: 'Today my wish has come true - to devote the whole dedede to the world',
                      onTap: () => Modular.to.pushNamed('note'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
