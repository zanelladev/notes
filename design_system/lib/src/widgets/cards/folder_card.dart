import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import '../../../design_system.dart';

class FolderCard extends StatelessWidget {
  final int id;
  final String title;
  final int notesQuantity;
  final VoidCallback onPressed;
  final VoidCallback deleteFunction;

  const FolderCard({
    super.key,
    required this.id,
    required this.title,
    required this.notesQuantity,
    required this.onPressed,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.extension<NotesTextStylesExtension>()!;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 180),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: textStyles.smallTextGrey),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                              isFolder: true,
                              title: title,
                              deleteFunction: () => deleteFunction(),
                            );
                          });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Icon(
                      Ionicons.trash_outline,
                      color: theme.colorScheme.onBackground,
                      size: 18,
                    ),
                  ),
                ],
              ),
              Text(
                notesQuantity.toString(),
                style: textStyles.headlineSLight.copyWith(
                  fontSize: 64,
                  letterSpacing: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
