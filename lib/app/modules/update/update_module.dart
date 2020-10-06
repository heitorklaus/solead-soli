import 'package:login/app/modules/update/update_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/modules/update/update_page.dart';

class UpdateModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) {
          return UpdateController();
        }),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => UpdatePage()),
      ];

  static Inject get to => Inject.of();
}
