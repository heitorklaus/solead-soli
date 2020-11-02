import 'package:login/app/modules/plants/plants_interface.dart';
import 'package:login/app/modules/plants/plants_page.dart';

import 'plants_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../plants_repository.dart';

class PlantsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PlantsRepository()),
        Bind((i) => PlantsController(i.get<IPlantsRepository>())),
        Bind<IPlantsRepository>((i) => PlantsRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => PlantsPage()),
      ];

  static Inject get to => Inject<PlantsModule>.of();
}
