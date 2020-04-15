import 'package:flutter/material.dart';
import 'package:login/app/modules/home/home_controller.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

part 'simulator_controller.g.dart';

class SimulatorController = _SimulatorControllerBase with _$SimulatorController;

abstract class _SimulatorControllerBase with Store {
  final media = TextEditingController();
  final potencia = TextEditingController();

  _SimulatorControllerBase() {
    media.addListener(() async {
      if (media.text.length > 1) {
        final irradiation = await AuthRepository().getDataLogin();

        print('VALOR');
        final result = (int.parse(media.text).toInt() / 30) /
            double.parse(irradiation.replaceAll(',', '.')).toDouble()/.75;

        potencia.text = result.toStringAsFixed(2);
      }
    });

    @observable
    bool retorno = false;

    @observable
    int value = 0;

    @action
    void increment() {
      value++;
    }
  }
}
