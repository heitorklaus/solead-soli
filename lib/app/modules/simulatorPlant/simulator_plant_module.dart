import 'simulator_plant_controller.dart';
import 'package:dio/dio.dart';
import 'repositories/simulator_plant_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'simulator_plant_page.dart';

class SimulatorPlantModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SimulatorPlantController()),
      ];
  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SimulatorPlantPage()),
      ];

  static Inject get to => Inject<SimulatorPlantModule>.of();
}
