import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:login/app/modules/simulator/simulator_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/modules/simulator/simulator_page.dart';

class SimulatorModuleEdit extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => SimulatorController()),
      ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SimulatorPage()),
  ];
}
