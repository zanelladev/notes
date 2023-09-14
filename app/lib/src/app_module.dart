import 'package:dependencies/dependencies.dart';

import 'modules/folders/data/repositories/folders_repository_concrete.dart';
import 'modules/folders/folders_module.dart';
import 'modules/folders/presenter/blocs/folders_cubit.dart';
import 'modules/notes/data/repositories/notes_repository_concrete.dart';
import 'modules/notes/notes_module.dart';
import 'modules/notes/presenter/blocs/notes_cubit.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: FoldersModule()),
        ModuleRoute('/notes', module: NotesModule()),
      ];

  @override
  List<Bind<Object>> get binds => [
        Bind.factory(
          (i) => FoldersRepositoryConcrete(),
        ),
        Bind.singleton(
          (i) => FoldersCubit(i()),
        ),
        Bind.factory(
          (i) => NotesRepositoryConcrete(),
        ),
        Bind.singleton(
          (i) => NotesCubit(i()),
        ),
      ];
}
