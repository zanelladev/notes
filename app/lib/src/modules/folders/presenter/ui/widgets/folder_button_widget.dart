import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class FolderButtonWidget extends StatefulWidget {
  final Folder? folder;
  final VoidCallback fetchFunction;

  const FolderButtonWidget({
    super.key,
    this.folder,
    required this.fetchFunction,
  });

  @override
  State<FolderButtonWidget> createState() => _FolderButtonWidgetState();
}

class _FolderButtonWidgetState extends State<FolderButtonWidget> {
  bool _isExtended = false;
  final _text = '';
  final _controller = TextEditingController();
  final folderDB = FolderDB();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.extension<NotesTextStylesExtension>()!;
    final deviceInfo = MediaQuery.of(context);
    return TapRegion(
      onTapOutside: (event) {
        setState(() {
          _isExtended = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 75,
        width: _isExtended ? deviceInfo.size.width - 32 : 75,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _isExtended
              ? SizedBox(
                  height: 75,
                  width: _isExtended ? deviceInfo.size.width - 32 : 75,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          child: TextFormField(
                            style: textStyles.headlineSLight
                                .copyWith(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'input folder name',
                              hintStyle: textStyles.headlineSLight
                                  .copyWith(fontSize: 14),
                            ),
                            controller: _controller,
                            onChanged: (text) => setState(() => _text),
                          ),
                        ),
                        if (_controller.value.text.isNotEmpty)
                          IconButton(
                            onPressed: () async {
                              await folderDB.create(
                                  title: _controller.value.text);
                              widget.fetchFunction();
                              setState(() {
                                _isExtended = false;
                              });
                            },
                            icon: Icon(
                              Icons.done,
                              color: theme.colorScheme.onBackground,
                              size: 30,
                            ),
                          )
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: 75,
                  width: 75,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isExtended = !_isExtended;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: theme.colorScheme.onBackground,
                      size: 30,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
