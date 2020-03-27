import 'package:mobx/mobx.dart';

part 'simulator_controller.g.dart';

class SimulatorController = _SimulatorControllerBase with _$SimulatorController;

abstract class _SimulatorControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
