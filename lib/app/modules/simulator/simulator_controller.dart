import 'package:flutter/material.dart';
import 'package:login/app/modules/home/home_controller.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/dados_kits.dart';
import 'package:login/app/shared/repositories/entities/power_plants.dart';
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

  final p1 = Object();

  @observable
  bool disableAdd = true;

  final powerPlantsMenor = PowerPlants();

  final powerPlantsMaior = PowerPlants();

  @action
  showDialogKitMenor(context) {
    print('[KIT MENOR ] ');
    print('[KIT ID ] ' + powerPlantsMenor.id.toString());
    print('[KIT CODIGO ] ' + powerPlantsMenor.codigo.toString());
    print('[KIT AREA ] ' + powerPlantsMenor.area);
    print('[KIT INVERSOR ] ' + powerPlantsMenor.inversor);
    print('[KIT QUANTIDADE DE PLACAS ] ' +
        powerPlantsMenor.numeroDeModulo.toString());
    print('[KIT MARCA DAS PLACAS ] ' + powerPlantsMenor.marcaDoModulo);
    print('[KIT POTENCIA DAS PLACAS ] ' + powerPlantsMenor.potenciaDoModulo);
    print('[KIT AREA ] ' + powerPlantsMenor.area);
    print('[KIT PESO ] ' + powerPlantsMenor.peso);
    print('[KIT PREÇO TOTAL ] ' + powerPlantsMenor.valor);
    print('[KIT] ' + powerPlantsMenor.dados);

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
                    child: Text(powerPlantsMenor.valor),
                  );
                },
              ),
            ));
  }

  @action
  showDialogKitMaior(context) {
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
                    child: Text(powerPlantsMenor.valor),
                  );
                },
              ),
            ));
  }

  _SimulatorControllerBase() {
    mediaMoney.addListener(() async {
      if (mediaMoney.text.length > 2) {
        disableAdd = false;

        final irradiation = await AuthRepository().getDataLogin();

        final result = (int.parse(mediaMoney.text).toInt() * .91 / (30)) /
            double.parse(irradiation.replaceAll(',', '.')).toDouble() /
            .75;

        potencia.text = result.toStringAsFixed(2);

        var potenciaProximaMaior = await ProposalStringsDao()
            .findPotenciaKit(result.toStringAsFixed(2));
        var potenciaProximaMenor = await ProposalStringsDao()
            .findPotenciaKitMenor(result.toStringAsFixed(2));

        potenciaIndicada1.text = potenciaProximaMenor.potencia;
        valorKit1.text = potenciaProximaMenor.valor;
        potenciaIndicada2.text = potenciaProximaMaior.potencia;
        valorKit2.text = potenciaProximaMaior.valor;

        powerPlantsMenor.id = potenciaProximaMenor.id;
        powerPlantsMenor.inversor = potenciaProximaMenor.inversor;
        powerPlantsMenor.codigo = potenciaProximaMenor.codigo;
        powerPlantsMenor.area = potenciaProximaMenor.area;
        powerPlantsMenor.marcaDoModulo = potenciaProximaMenor.marca_do_modulo;
        powerPlantsMenor.numeroDeModulo = potenciaProximaMenor.numero_de_modulo;
        powerPlantsMenor.peso = potenciaProximaMenor.peso;
        powerPlantsMenor.potencia = potenciaProximaMenor.potencia;
        powerPlantsMenor.potenciaDoModulo =
            potenciaProximaMenor.potencia_do_modulo.toString();
        powerPlantsMenor.potenciaNovo =
            potenciaProximaMenor.potencia_novo.toString();
        powerPlantsMenor.valor = potenciaProximaMenor.valor;
        powerPlantsMenor.dados = potenciaProximaMenor.dados;

        powerPlantsMaior.id = potenciaProximaMaior.id;
        powerPlantsMaior.inversor = potenciaProximaMaior.inversor;
        powerPlantsMaior.codigo = potenciaProximaMaior.codigo;
        powerPlantsMaior.area = potenciaProximaMaior.area;
        powerPlantsMaior.numeroDeModulo = potenciaProximaMaior.numero_de_modulo;
        powerPlantsMaior.marcaDoModulo = potenciaProximaMaior.marca_do_modulo;
        powerPlantsMaior.peso = potenciaProximaMaior.peso;
        powerPlantsMaior.potencia = potenciaProximaMaior.potencia;
        powerPlantsMaior.potenciaDoModulo =
            potenciaProximaMaior.potencia_do_modulo.toString();
        powerPlantsMaior.potenciaNovo =
            potenciaProximaMaior.potencia_novo.toString();
        powerPlantsMaior.valor = potenciaProximaMaior.valor;
        powerPlantsMaior.dados = potenciaProximaMaior.dados;
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
