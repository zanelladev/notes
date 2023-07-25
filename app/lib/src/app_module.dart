import 'package:dependencies/dependencies.dart';

import 'modules/folders/folders_module.dart';
import 'modules/notes/notes_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: FoldersModule()),
        ModuleRoute('/notes', module: NotesModule()),
      ];
}
