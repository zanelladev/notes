import 'package:dependencies/dependencies.dart';

import 'ui/pages/general_notes_pages.dart';
import 'ui/pages/note_page.dart';

class NotesModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => GeneralNotesPage(folderInfo: args.data)),
        ChildRoute('/note',
            child: (_, args) => NotePage(folderNoteInfo: args.data)),
      ];
}
