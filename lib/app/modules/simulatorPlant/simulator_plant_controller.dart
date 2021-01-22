import 'package:flutter/material.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/proposal_strings.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'simulator_plant_controller.g.dart';

class SimulatorPlantController = _SimulatorPlantControllerBase with _$SimulatorPlantController;

abstract class _SimulatorPlantControllerBase with Store {
  final inputKwh = TextEditingController();
  final inputR$ = TextEditingController();

  _SimulatorPlantControllerBase() {
    // fica escutando cada INPUT nos campos de simulacao
    inputKwh.addListener(() async {
      inputKwh.text.length > 2 ? calculate() : print('nao tem 3 caracteres ainda');
    });
    inputR$.addListener(() async {
      inputR$.text.length > 2 ? calculate() : print('nao tem 3 caracteres ainda');
    });
  }

  calculate() async {
    // Resgato a irradiacao da cidade e eficiencia energitica programada na SPLASH PAGE (0.75 no caso DEFAULT)
    final irradiation = await AuthRepository().getIrradiation();
    final efficiency = await AuthRepository().getEfficiency();
    final tarifa = await AuthRepository().getPrice();
    // Aqui ternario SE TIVER VALOR NO INPUT KWP entao POTENCIA ASSUME a conta com KWP SENAO COM R$
    dynamic potency;

    // Se estou simulando EM KWH
    if (inputKwh.text.length > 2) {
      // potencia NECESSARIA
      potency = ((int.parse(inputKwh.text).toInt() / 30) / double.parse(irradiation.replaceAll(',', '.')).toDouble() / efficiency).toStringAsFixed(2);
    } else {
      // Se estou simulando em REAIS
      potency = ((int.parse(inputR$.text).toInt() * double.parse(tarifa.replaceAll(',', '.')).toDouble() / (30)) / double.parse(irradiation.replaceAll(',', '.')).toDouble() / efficiency).toStringAsFixed(2);
    }

    // Envio a potencia necessaria para fazer uma busca la MENOR e MAIOR
    var potenciaProximaMaior = await ProposalStringsDao().findPotenciaKit(potency);
    var potenciaProximaMenor = await ProposalStringsDao().findPotenciaKitMenor(potency);

    // Pego o retorno e faco o processo pra descobrir a geracao baseada na potencia encontrada
    // POTENCIA * 30 * IRRADIACAO * EFICIENCIA
    var kwhMenor = (potenciaProximaMenor.potencia.toDouble() * 30 * efficiency * double.parse(irradiation.replaceAll(',', '.'))).round();
    var kwhMaior = (potenciaProximaMaior.potencia.toDouble() * 30 * efficiency * double.parse(irradiation.replaceAll(',', '.'))).round();

    var valorKitMenor = potenciaProximaMenor.valor;
    var valorKitMaior = potenciaProximaMaior.valor;

    print(" Potencia MENOR encontrada: ${potenciaProximaMenor.potencia} | $kwhMenor kWh | Valor Kit: $valorKitMenor ");
    print(" Potencia MAIOR encontrada: ${potenciaProximaMaior.potencia} | $kwhMaior kWh | Valor Kit: $valorKitMaior ");
  }

  @observable
  clearKwh() async {
    inputR$.text = '';
  }

  @observable
  clearR$() async {
    inputKwh.text = '';
  }
}
