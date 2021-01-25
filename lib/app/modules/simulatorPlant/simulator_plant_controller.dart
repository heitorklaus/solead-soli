import 'package:flutter/material.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/dados_kits.dart';
import 'package:login/app/shared/repositories/entities/power_plants.dart';
import 'package:login/app/shared/repositories/proposal_strings.dart';
import 'package:mobx/mobx.dart';
//import 'package:flutter_modular/flutter_modular.dart';

part 'simulator_plant_controller.g.dart';

class SimulatorPlantController = _SimulatorPlantControllerBase with _$SimulatorPlantController;

abstract class _SimulatorPlantControllerBase with Store {
  // Campos do simulador INPUT EM kWh e INPUT EM R$
  final inputKwh = TextEditingController();
  final inputR$ = TextEditingController();
  // Campos de retorno pós INPUT
  var inputPotenciaNecessaria = TextEditingController();
  var inputPotenciaIndicadaMenor = TextEditingController();
  var inputPotenciaIndicadaMaior = TextEditingController();
  var inputValorKitMenor = TextEditingController();
  var inputValorKitMaior = TextEditingController();

  _SimulatorPlantControllerBase() {
    // fica escutando cada INPUT nos campos de simulacao OU FAZ CALCULO OU CLEAR
    inputKwh.addListener(() async {
      inputKwh.text.length > 2 ? calculate() : clearKwh();
    });
    inputR$.addListener(() async {
      inputR$.text.length > 2 ? calculate() : clearR$();
    });
  }

  calculate() async {
    // Resgato a irradiacao da cidade e eficiencia energitica programada na SPLASH PAGE (0.75 no caso DEFAULT)
    final irradiation = await AuthRepository().getIrradiation();
    final efficiency = await AuthRepository().getEfficiency();
    final tarifa = await AuthRepository().getPrice();
    // Aqui IF SE TIVER VALOR NO INPUT KWP entao POTENCIA ASSUME a conta com KWP SENAO COM R$
    dynamic potency;

    // Se estou simulando EM KWH
    if (inputKwh.text.length > 2) {
      potency = ((int.parse(inputKwh.text).toInt() / 30) / double.parse(irradiation.replaceAll(',', '.')).toDouble() / efficiency).toStringAsFixed(2);
    } else {
      // Se estou simulando em REAIS
      potency = ((int.parse(inputR$.text).toInt() * double.parse(tarifa.replaceAll(',', '.')).toDouble() / (30)) / double.parse(irradiation.replaceAll(',', '.')).toDouble() / efficiency).toStringAsFixed(2);
    }

    //#TODO: Mudar essa busca no DAO (Criar um serviço)
    // Envio a potencia necessaria para fazer uma busca la no DAO (LUGAR INFELIZ DE COLOCAR) MENOR e MAIOR
    DadosKits potenciaProximaMaior = await ProposalStringsDao().findPotenciaKit(potency);
    DadosKits potenciaProximaMenor = await ProposalStringsDao().findPotenciaKitMenor(potency);

    // Só EXECUTA O BLOCO SE TIVER ENCONTRADO RESULTADO NA BUSCA
    if (potenciaProximaMenor != null) {
      // Pego o retorno e faco o processo pra descobrir a geracao baseada na potencia encontrada
      // POTENCIA * 30 * IRRADIACAO * EFICIENCIA
      var kwhMenor = (potenciaProximaMenor.potencia.toDouble() * 30 * efficiency * double.parse(irradiation.replaceAll(',', '.'))).round();
      var kwhMaior = (potenciaProximaMaior.potencia.toDouble() * 30 * efficiency * double.parse(irradiation.replaceAll(',', '.'))).round();

      // Inputs da pagina
      inputPotenciaNecessaria.text = potency;
      inputPotenciaIndicadaMenor.text = "${potenciaProximaMenor.potencia}";
      inputPotenciaIndicadaMaior.text = "${potenciaProximaMaior.potencia}";
      inputValorKitMenor.text = potenciaProximaMenor.valor;
      inputValorKitMaior.text = potenciaProximaMaior.valor;

      print(" Potencia MENOR encontrada: ${potenciaProximaMenor.potencia} | $kwhMenor kWh | Valor Kit: $inputValorKitMenor ");
      print(" Potencia MAIOR encontrada: ${potenciaProximaMaior.potencia} | $kwhMaior kWh | Valor Kit: $inputValorKitMaior ");
    }
  }

  // Clear Fields, Limpa os campos quando é clicado em um campo diferente
  @observable
  clearKwh() async {
    inputR$.text = '';
    inputPotenciaNecessaria.text = "";
    inputPotenciaIndicadaMenor.text = "";
    inputPotenciaIndicadaMaior.text = "";
    inputValorKitMenor.text = "";
    inputValorKitMaior.text = "";
  }

// Clear Fields, Limpa os campos quando é clicado em um campo diferente
  @observable
  clearR$() async {
    inputKwh.text = '';
    inputPotenciaNecessaria.text = "";
    inputPotenciaIndicadaMenor.text = "";
    inputPotenciaIndicadaMaior.text = "";
    inputValorKitMenor.text = "";
    inputValorKitMaior.text = "";
  }
}
