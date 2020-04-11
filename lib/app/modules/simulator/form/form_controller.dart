import 'package:mobx/mobx.dart';

part 'form_controller.g.dart';

class FormController = _FormControllerBase with _$FormController;

abstract class _FormControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
