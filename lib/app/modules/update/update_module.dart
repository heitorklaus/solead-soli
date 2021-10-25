import 'package:login/app/modules/update/update_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/modules/update/update_page.dart';

class UpdateModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) {
          return UpdateController();
        }),
      ];

  @override
  List<ModularRoute> get routers => [
        ChildRoute('/', child: (_, args) => UpdatePage()),
      ];
}
