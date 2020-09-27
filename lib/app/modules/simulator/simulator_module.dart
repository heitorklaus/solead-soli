import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:login/app/modules/simulator/simulator_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/modules/simulator/simulator_page.dart';

class SimulatorModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SimulatorController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SimulatorPage()),
      ];

  static Inject get to => Inject<SimulatorModule>.of();
}
