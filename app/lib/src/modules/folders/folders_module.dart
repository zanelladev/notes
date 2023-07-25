import 'package:dependencies/dependencies.dart';

import 'presenter/ui/folders_page.dart';

class FoldersModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => const FoldersPage()),
      ];
}
