import 'package:login/app/modules/simulator/form/form_controller.dart';
import 'package:login/app/modules/simulator/simulator_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/modules/simulator/simulator_page.dart';

class SimulatorModule extends ChildModule {
  int qtd;
  SimulatorModule({this.qtd = 0});

  @override
  List<Bind> get binds => [
        Bind((i) => FormController()),
        Bind((i) => SimulatorController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute,
            child: (_, args) => SimulatorPage(
                  qtd: qtd,
                )),
      ];

  static Inject get to => Inject<SimulatorModule>.of();
}
