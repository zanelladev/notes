import 'package:dependencies/dependencies.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
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
                    'PERSONAL NOTES  •  13/06/2023',
                    style: textStyles.smallTextGrey.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Text('empty title', style: textStyles.headlineSDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
