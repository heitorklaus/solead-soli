import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'update_controller.g.dart';

@Injectable()
class UpdateController = _UpdateControllerBase with _$UpdateController;

abstract class _UpdateControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
