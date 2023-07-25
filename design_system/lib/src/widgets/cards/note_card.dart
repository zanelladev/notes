import 'package:flutter/material.dart';

import '../../common/extensions/notes_text_styles_extension.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String contentPreview;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.title,
    required this.contentPreview,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.extension<NotesTextStylesExtension>()!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textStyles.smallTextDark),
              Text(
                contentPreview,
                style: textStyles.smallTextGrey,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
