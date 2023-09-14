import 'package:dependencies/dependencies.dart';

import 'presenter/ui/pages/general_notes_pages.dart';
import 'presenter/ui/pages/note_page.dart';

class NotesModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => GeneralNotesPage(folder: args.data)),
        ChildRoute('/note',
            child: (_, args) => NotePage(folderNoteInfo: args.data)),
      ];
}
