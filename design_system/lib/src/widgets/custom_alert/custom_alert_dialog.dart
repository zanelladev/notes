import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../design_system.dart';

class CustomAlertDialog extends StatelessWidget {
  final bool isFolder;
  final String title;
  const CustomAlertDialog({
    super.key,
    required this.isFolder,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final String titleType;
    isFolder ? titleType = 'folder' : titleType = 'note';
    final theme = Theme.of(context);
    final textStyles = theme.extension<NotesTextStylesExtension>()!;
    return CupertinoAlertDialog(
      title: Text(
        'Are you sure you want to delete "$title" $titleType?',
        style: textStyles.headlineSLight.copyWith(fontSize: 16),
      ),
      content: Text(
        'This item will be deleted immediately. You can\'t undo this action.',
        style: textStyles.smallTextGrey.copyWith(fontSize: 12),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Yes',
              style: textStyles.headlineSLight.copyWith(fontSize: 16),
            )),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: textStyles.headlineSLight.copyWith(fontSize: 16, color: theme.colorScheme.primary),
          ),
        )
      ],
    );
  }
}
