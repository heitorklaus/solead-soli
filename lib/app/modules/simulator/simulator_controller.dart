import 'package:flutter/material.dart';
import 'package:login/app/modules/home/home_controller.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/dados_kits.dart';
import 'package:mobx/mobx.dart';

import 'package:login/app/shared/repositories/proposal_strings.dart';

part 'simulator_controller.g.dart';

class SimulatorController = _SimulatorControllerBase with _$SimulatorController;

abstract class _SimulatorControllerBase with Store {
  final media = TextEditingController();
  final mediaMoney = TextEditingController();
  final potencia = TextEditingController();
  final potenciaIndicada1 = TextEditingController();
  final potenciaIndicada2 = TextEditingController();
  final valorKit1 = TextEditingController();
  final valorKit2 = TextEditingController();

  @observable
  bool disableAdd = true;

  @action
  showDialogController(context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return Container(
                    child: Text('teste'),
                  );
                },
              ),
            ));
  }

  _SimulatorControllerBase() {
    mediaMoney.addListener(() async {
      if (mediaMoney.text.length > 2) {
        disableAdd = false;

        print('[ TEST REQUEST POTENCIA]');
        final irradiation = await AuthRepository().getDataLogin();

        final result = (int.parse(mediaMoney.text).toInt() * .91 / (30)) /
            double.parse(irradiation.replaceAll(',', '.')).toDouble() /
            .75;

        potencia.text = result.toStringAsFixed(2);

        var potenciaProximaMaior = await ProposalStringsDao()
            .findPotenciaKit(result.toStringAsFixed(2));
        var potenciaProximaMenor = await ProposalStringsDao()
            .findPotenciaKitMenor(result.toStringAsFixed(2));

        print('NOVO RETORNO AQUI 2: ' + potenciaProximaMaior.id.toString());

        potenciaIndicada1.text = potenciaProximaMenor.potencia;
        valorKit1.text = potenciaProximaMenor.valor;
        potenciaIndicada2.text = potenciaProximaMaior.potencia;
        valorKit2.text = potenciaProximaMaior.valor;
      } else {
        potencia.text = '';
        potenciaIndicada1.text = '';
        valorKit1.text = '';
        potenciaIndicada2.text = '';
        valorKit2.text = '';
        disableAdd = true;
      }
    });

    media.addListener(() async {
      if (media.text.length > 2) {
        disableAdd = false;

        print('[ TEST REQUEST POTENCIA]');
        final irradiation = await AuthRepository().getDataLogin();

        final result = (int.parse(media.text).toInt() / 30) /
            double.parse(irradiation.replaceAll(',', '.')).toDouble() /
            .75;

        potencia.text = result.toStringAsFixed(2);

        var potenciaProximaMaior = await ProposalStringsDao()
            .findPotenciaKit(result.toStringAsFixed(2));
        var potenciaProximaMenor = await ProposalStringsDao()
            .findPotenciaKitMenor(result.toStringAsFixed(2));

        //  print(valor.id.toString());
        //  print(valor.potencia);

        potenciaIndicada1.text = potenciaProximaMenor.potencia;
        valorKit1.text = potenciaProximaMenor.valor;
        potenciaIndicada2.text = potenciaProximaMaior.potencia;
        valorKit2.text = potenciaProximaMaior.valor;
      } else {
        potencia.text = '';
        potenciaIndicada1.text = '';
        valorKit1.text = '';
        potenciaIndicada2.text = '';
        valorKit2.text = '';

        disableAdd = true;
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
