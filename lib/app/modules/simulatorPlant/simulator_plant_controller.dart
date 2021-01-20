import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'simulator_plant_controller.g.dart';


@Injectable()
class SimulatorPlantController = _SimulatorPlantControllerBase with _$SimulatorPlantController;

abstract class _SimulatorPlantControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
  