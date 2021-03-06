import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:framework/config/main_colors.dart';
import 'package:framework/ui/form/inputs/input_type.dart';
import 'package:framework/ui/form/inputs/outlined_text_edit.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:login/app/shared/styles/main_colors.dart' as main;
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:framework/ui/form/buttons/danger_button.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/dados_kits.dart';
import 'package:login/app/shared/repositories/entities/power_plants.dart';
import 'package:login/app/shared/styles/main_style.dart';
import 'package:login/app/shared/utils/database_helper.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:mobx/mobx.dart';
import 'dart:ui' as ui;
import 'package:login/app/shared/repositories/proposal_strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pwa;
import 'PdfPreviewScreen.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'charts/chart.dart';

part 'simulator_controller.g.dart';

class SimulatorController = _SimulatorControllerBase with _$SimulatorController;

abstract class _SimulatorControllerBase with Store {
  final mediaKW = TextEditingController();
  final mediaMoney = TextEditingController();
  final potencia = TextEditingController();
  final potenciaIndicada1 = TextEditingController();
  final potenciaIndicada2 = TextEditingController();
  final valorKit1 = TextEditingController();
  final valorKit2 = TextEditingController();
  final testValue = TextEditingController();

  final p1 = Object();

  @observable
  bool disableAdd = true;

  @observable
  String typePlant;

  final powerPlantsMenor = PowerPlants();

  final powerPlantsMaior = PowerPlants();

  @observable
  clearKW() async {
    mediaKW.text = '';
    potencia.text = '';
    potenciaIndicada1.text = '';
    valorKit1.text = '';
    potenciaIndicada2.text = '';
    valorKit2.text = '';

    disableAdd = true;
  }

  clearMoney() async {
    mediaMoney.text = '';
    potencia.text = '';
    potenciaIndicada1.text = '';
    valorKit1.text = '';
    potenciaIndicada2.text = '';
    valorKit2.text = '';

    disableAdd = true;
  }

  @observable
  calcMediaKW() async {
    if (mediaKW.text.length > 2) {
      disableAdd = false;

      final irradiation = await AuthRepository().getIrradiation();
      final efficiency = await AuthRepository().getEfficiency();

      final result = (int.parse(mediaKW.text).toInt() / 30) / double.parse(irradiation.replaceAll(',', '.')).toDouble() / efficiency;

      potencia.text = result.toStringAsFixed(2);

      var potenciaProximaMaior = await ProposalStringsDao().findPotenciaKit(result.toStringAsFixed(2));
      var potenciaProximaMenor = await ProposalStringsDao().findPotenciaKitMenor(result.toStringAsFixed(2));

      final tarifa = await AuthRepository().getPrice();

      //  print(valor.id.toString());
      print('valor.potencia');

      potenciaIndicada1.text = (potenciaProximaMenor.potencia).toString();
      valorKit1.text = potenciaProximaMenor.valor;
      potenciaIndicada2.text = (potenciaProximaMaior.potencia).toString();
      valorKit2.text = potenciaProximaMaior.valor;

      final mediaNova = double.parse((mediaKW.text));
      powerPlantsMenor.consumoEmReais = (mediaNova / double.parse(tarifa.replaceAll(',', '.')).toDouble()).toString();
      powerPlantsMaior.consumoEmReais = (mediaNova / double.parse(tarifa.replaceAll(',', '.')).toDouble()).toString();

      final mediaNovaKw = double.parse((mediaKW.text));
      powerPlantsMenor.consumoEmKw = (mediaNovaKw).toString();
      powerPlantsMaior.consumoEmKw = (mediaNovaKw).toString();

      powerPlantsMenor.id = potenciaProximaMenor.id;
      powerPlantsMenor.inversor = potenciaProximaMenor.inversor;
      powerPlantsMenor.codigo = potenciaProximaMenor.codigo;
      powerPlantsMenor.area = potenciaProximaMenor.area;
      powerPlantsMenor.marcaDoModulo = potenciaProximaMenor.marca_do_modulo;
      powerPlantsMenor.numeroDeModulo = potenciaProximaMenor.numero_de_modulo;
      powerPlantsMenor.peso = potenciaProximaMenor.peso;
      powerPlantsMenor.potencia = potenciaProximaMenor.potencia;
      powerPlantsMenor.potenciaDoModulo = potenciaProximaMenor.potencia_do_modulo.toString();
      powerPlantsMenor.potenciaNovo = powerPlantsMenor.valor = potenciaProximaMenor.valor;
      powerPlantsMenor.dados = potenciaProximaMenor.dados;

      powerPlantsMaior.id = potenciaProximaMaior.id;
      powerPlantsMaior.inversor = potenciaProximaMaior.inversor;
      powerPlantsMaior.codigo = potenciaProximaMaior.codigo;
      powerPlantsMaior.area = potenciaProximaMaior.area;
      powerPlantsMaior.numeroDeModulo = potenciaProximaMaior.numero_de_modulo;
      powerPlantsMaior.marcaDoModulo = potenciaProximaMaior.marca_do_modulo;
      powerPlantsMaior.peso = potenciaProximaMaior.peso;
      powerPlantsMaior.potencia = potenciaProximaMaior.potencia;
      powerPlantsMaior.potenciaDoModulo = potenciaProximaMaior.potencia_do_modulo.toString();
      powerPlantsMaior.potenciaNovo = powerPlantsMaior.valor = potenciaProximaMaior.valor;
      powerPlantsMaior.dados = potenciaProximaMaior.dados;
    } else {
      potencia.text = '';
      potenciaIndicada1.text = '';
      valorKit1.text = '';
      potenciaIndicada2.text = '';
      valorKit2.text = '';

      disableAdd = true;
    }
  }

  @observable
  calcMediaMoney() async {
    if (mediaMoney.text.length > 2) {
      disableAdd = false;

      final irradiation = await AuthRepository().getIrradiation();
      final tarifa = await AuthRepository().getPrice();
      final efficiency = await AuthRepository().getEfficiency();

      final result = (int.parse(mediaMoney.text).toInt() * double.parse(tarifa.replaceAll(',', '.')).toDouble() / (30)) / double.parse(irradiation.replaceAll(',', '.')).toDouble() / efficiency;

      potencia.text = result.toStringAsFixed(2);

      var potenciaProximaMaior = await ProposalStringsDao().findPotenciaKit(result.toStringAsFixed(2));
      var potenciaProximaMenor = await ProposalStringsDao().findPotenciaKitMenor(result.toStringAsFixed(2));

      potenciaIndicada1.text = (potenciaProximaMenor.potencia).toString();
      valorKit1.text = potenciaProximaMenor.valor;
      potenciaIndicada2.text = (potenciaProximaMaior.potencia).toString();
      valorKit2.text = potenciaProximaMaior.valor;

      powerPlantsMenor.id = potenciaProximaMenor.id;
      powerPlantsMenor.inversor = potenciaProximaMenor.inversor;
      powerPlantsMenor.codigo = potenciaProximaMenor.codigo;
      powerPlantsMenor.area = potenciaProximaMenor.area;
      powerPlantsMenor.marcaDoModulo = potenciaProximaMenor.marca_do_modulo;
      powerPlantsMenor.numeroDeModulo = potenciaProximaMenor.numero_de_modulo;
      powerPlantsMenor.peso = potenciaProximaMenor.peso;
      powerPlantsMenor.potencia = potenciaProximaMenor.potencia;
      powerPlantsMenor.potenciaDoModulo = potenciaProximaMenor.potencia_do_modulo.toString();
      powerPlantsMenor.potenciaNovo = powerPlantsMenor.valor = potenciaProximaMenor.valor;
      powerPlantsMenor.dados = potenciaProximaMenor.dados;

      final mediaNova = double.parse((mediaMoney.text));

      powerPlantsMenor.consumoEmReais = (mediaNova).toString();
      powerPlantsMaior.consumoEmReais = (mediaNova).toString();

      final mediaNovaKw = double.parse((mediaMoney.text));

      powerPlantsMenor.consumoEmKw = (mediaNovaKw * double.parse(tarifa.replaceAll(',', '.')).toDouble()).toString();
      powerPlantsMaior.consumoEmKw = (mediaNovaKw * double.parse(tarifa.replaceAll(',', '.')).toDouble()).toString();

      powerPlantsMaior.id = potenciaProximaMaior.id;
      powerPlantsMaior.inversor = potenciaProximaMaior.inversor;
      powerPlantsMaior.codigo = potenciaProximaMaior.codigo;
      powerPlantsMaior.area = potenciaProximaMaior.area;
      powerPlantsMaior.numeroDeModulo = potenciaProximaMaior.numero_de_modulo;
      powerPlantsMaior.marcaDoModulo = potenciaProximaMaior.marca_do_modulo;
      powerPlantsMaior.peso = potenciaProximaMaior.peso;
      powerPlantsMaior.potencia = potenciaProximaMaior.potencia;
      powerPlantsMaior.potenciaDoModulo = potenciaProximaMaior.potencia_do_modulo.toString();
      powerPlantsMaior.potenciaNovo = powerPlantsMaior.valor = potenciaProximaMaior.valor;
      powerPlantsMaior.dados = potenciaProximaMaior.dados;
    } else {
      potencia.text = '';
      potenciaIndicada1.text = '';
      valorKit1.text = '';
      potenciaIndicada2.text = '';
      valorKit2.text = '';
      disableAdd = true;
    }
  }

  @action
  showDialogKitMenor(context) async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
    ));
    Future returnGenerationKW() async {
      final val = new NumberFormat("#,##0.00", "pt_BR");
      // RETORNA A GERACAO MES A MES
      final valor = await Prefs.getStringList("CITIES");
      final efficiency = await AuthRepository().getEfficiency();

      var jan = double.parse(valor[1].split(":")[1]);
      var janValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(1) * jan * efficiency;

      final teste = val.format(janValue).split(",")[0];

      var fev = double.parse(valor[2].split(":")[1]);
      var fevValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(2) * fev * efficiency;

      var mar = double.parse(valor[3].split(":")[1]);
      var marValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(3) * mar * efficiency;

      var abr = double.parse(valor[4].split(":")[1]);
      var abrValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(4) * abr * efficiency;

      var mai = double.parse(valor[5].split(":")[1]);
      var maiValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(5) * mai * efficiency;

      var jun = double.parse(valor[6].split(":")[1]);
      var junValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(6) * jun * efficiency;

      var jul = double.parse(valor[7].split(":")[1]);
      var julValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(7) * jul * efficiency;

      var ago = double.parse(valor[8].split(":")[1]);
      var agoValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(8) * ago * efficiency;

      var sep = double.parse(valor[9].split(":")[1]);
      var sepValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(9) * sep * efficiency;

      var out = double.parse(valor[10].split(":")[1]);
      var outValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(10) * out * efficiency;

      var nov = double.parse(valor[11].split(":")[1]);
      var novValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(11) * nov * efficiency;

      var dez = double.parse(valor[12].split(":")[1]);
      var dezValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(12) * dez * efficiency;

      final mediaGeracaoKwpMenor = (janValue + fevValue + marValue + abrValue + maiValue + junValue + julValue + agoValue + sepValue + outValue + novValue + dezValue) / 12;

      return mediaGeracaoKwpMenor.round();
    }

    Future returnAllMonths() async {
      final val = new NumberFormat("#,##0.00", "pt_BR");
      // RETORNA A GERACAO MES A MES
      final valor = await Prefs.getStringList("CITIES");
      final efficiency = await AuthRepository().getEfficiency();

      var jan = double.parse(valor[1].split(":")[1]);
      var janValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(1) * jan * efficiency;

      //final teste = val.format(janValue).split(",")[0];

      var fev = double.parse(valor[2].split(":")[1]);
      var fevValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(2) * fev * efficiency;

      var mar = double.parse(valor[3].split(":")[1]);
      var marValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(3) * mar * efficiency;

      var abr = double.parse(valor[4].split(":")[1]);
      var abrValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(4) * abr * efficiency;

      var mai = double.parse(valor[5].split(":")[1]);
      var maiValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(5) * mai * efficiency;

      var jun = double.parse(valor[6].split(":")[1]);
      var junValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(6) * jun * efficiency;

      var jul = double.parse(valor[7].split(":")[1]);
      var julValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(7) * jul * efficiency;

      var ago = double.parse(valor[8].split(":")[1]);
      var agoValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(8) * ago * efficiency;

      var sep = double.parse(valor[9].split(":")[1]);
      var sepValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(9) * sep * efficiency;

      var out = double.parse(valor[10].split(":")[1]);
      var outValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(10) * out * efficiency;

      var nov = double.parse(valor[11].split(":")[1]);
      var novValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(11) * nov * efficiency;

      var dez = double.parse(valor[12].split(":")[1]);
      var dezValue = (powerPlantsMenor.potencia) * returnDaysOfMonth(12) * dez * efficiency;

      List<Map<String, double>> allValues;

      allValues = [
        ({"JAN": janValue.round().toDouble()}),
        ({"FEV": fevValue.round().toDouble()}),
        ({"MAR": marValue.round().toDouble()}),
        ({"ABR": abrValue.round().toDouble()}),
        ({"MAI": maiValue.round().toDouble()}),
        ({"JUN": junValue.round().toDouble()}),
        ({"JUL": julValue.round().toDouble()}),
        ({"AGO": agoValue.round().toDouble()}),
        ({"SET": sepValue.round().toDouble()}),
        ({"OUT": outValue.round().toDouble()}),
        ({"NOV": novValue.round().toDouble()}),
        ({"DEZ": dezValue.round().toDouble()}),
      ];

      return allValues;
    }

    final mediaMenor = await returnGenerationKW();

    final returnAll = await returnAllMonths();

    final tarifa = await AuthRepository().getPrice();

    @observable
    Future returnTax() async {
      final valor = await Prefs.getStringList("TAX");

      print(valor[0].split(":")[1]);
      print(valor[1].split(":")[1]);
      print(valor[2].split(":")[1]);
      print(valor[3].split(":")[1]);

      return valor;
    }

    returnConsumo(x) {
      print('chamo 1');
      if (mediaMoney.text.length > 0) {
        final consumo = (double.parse(mediaMoney.text) / x);
        return consumo;
      } else {
        final consumo = (double.parse(mediaKW.text));
        return consumo;
      }
    }

    final role = await Prefs.getString("ROLE");
    final tax = await returnTax();
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Scaffold(
                  body: SingleChildScrollView(child: buildDialog(tarifa, context, powerPlantsMenor, mediaMenor, returnAll, returnConsumo(double.parse(tarifa.replaceAll(',', '.'))), tax, setState, role)),
                ),
              );
            },
          );
        });
  }

  @action
  showDialogKitMaior(context) async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
    ));
    Future returnGenerationKW() async {
      final val = new NumberFormat("#,##0.00", "pt_BR");
      // RETORNA A GERACAO MES A MES
      final valor = await Prefs.getStringList("CITIES");
      final efficiency = await AuthRepository().getEfficiency();

      var jan = double.parse(valor[1].split(":")[1]);
      var janValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(1) * jan * efficiency;

      final teste = val.format(janValue).split(",")[0];

      var fev = double.parse(valor[2].split(":")[1]);
      var fevValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(2) * fev * efficiency;

      var mar = double.parse(valor[3].split(":")[1]);
      var marValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(3) * mar * efficiency;

      var abr = double.parse(valor[4].split(":")[1]);
      var abrValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(4) * abr * efficiency;

      var mai = double.parse(valor[5].split(":")[1]);
      var maiValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(5) * mai * efficiency;

      var jun = double.parse(valor[6].split(":")[1]);
      var junValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(6) * jun * efficiency;

      var jul = double.parse(valor[7].split(":")[1]);
      var julValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(7) * jul * efficiency;

      var ago = double.parse(valor[8].split(":")[1]);
      var agoValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(8) * ago * efficiency;

      var sep = double.parse(valor[9].split(":")[1]);
      var sepValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(9) * sep * efficiency;

      var out = double.parse(valor[10].split(":")[1]);
      var outValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(10) * out * efficiency;

      var nov = double.parse(valor[11].split(":")[1]);
      var novValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(11) * nov * efficiency;

      var dez = double.parse(valor[12].split(":")[1]);
      var dezValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(12) * dez * efficiency;

      final mediaGeracaoKwpMaior = (janValue + fevValue + marValue + abrValue + maiValue + junValue + julValue + agoValue + sepValue + outValue + novValue + dezValue) / 12;

      return mediaGeracaoKwpMaior.round();
    }

    Future returnAllMonths() async {
      final val = new NumberFormat("#,##0.00", "pt_BR");
      // RETORNA A GERACAO MES A MES
      final valor = await Prefs.getStringList("CITIES");
      final efficiency = await AuthRepository().getEfficiency();

      var jan = double.parse(valor[1].split(":")[1]);
      var janValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(1) * jan * efficiency;

      final teste = val.format(janValue).split(",")[0];

      var fev = double.parse(valor[2].split(":")[1]);
      var fevValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(2) * fev * efficiency;

      var mar = double.parse(valor[3].split(":")[1]);
      var marValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(3) * mar * efficiency;

      var abr = double.parse(valor[4].split(":")[1]);
      var abrValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(4) * abr * efficiency;

      var mai = double.parse(valor[5].split(":")[1]);
      var maiValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(5) * mai * efficiency;

      var jun = double.parse(valor[6].split(":")[1]);
      var junValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(6) * jun * efficiency;

      var jul = double.parse(valor[7].split(":")[1]);
      var julValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(7) * jul * efficiency;

      var ago = double.parse(valor[8].split(":")[1]);
      var agoValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(8) * ago * efficiency;

      var sep = double.parse(valor[9].split(":")[1]);
      var sepValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(9) * sep * efficiency;

      var out = double.parse(valor[10].split(":")[1]);
      var outValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(10) * out * efficiency;

      var nov = double.parse(valor[11].split(":")[1]);
      var novValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(11) * nov * efficiency;

      var dez = double.parse(valor[12].split(":")[1]);
      var dezValue = (powerPlantsMaior.potencia) * returnDaysOfMonth(12) * dez * efficiency;

      List<Map<String, double>> allValues;

      allValues = [
        ({"JAN": janValue.round().toDouble()}),
        ({"FEV": fevValue.round().toDouble()}),
        ({"MAR": marValue.round().toDouble()}),
        ({"ABR": abrValue.round().toDouble()}),
        ({"MAI": maiValue.round().toDouble()}),
        ({"JUN": junValue.round().toDouble()}),
        ({"JUL": julValue.round().toDouble()}),
        ({"AGO": agoValue.round().toDouble()}),
        ({"SET": sepValue.round().toDouble()}),
        ({"OUT": outValue.round().toDouble()}),
        ({"NOV": novValue.round().toDouble()}),
        ({"DEZ": dezValue.round().toDouble()}),
      ];

      return allValues;
    }

    final mediaMaior = await returnGenerationKW();

    final returnAll = await returnAllMonths();

    @observable
    Future returnTax() async {
      final valor = await Prefs.getStringList("TAX");

      print(valor[0].split(":")[1]);
      print(valor[1].split(":")[1]);
      print(valor[2].split(":")[1]);
      print(valor[3].split(":")[1]);

      return valor;
    }

    final tax = await returnTax();
    final tarifa = await AuthRepository().getPrice();

    //var sicredi3x = returnTax('sicredi3x');
    returnConsumo(x) {
      print('chamo 2');

      if (mediaMoney.text.length > 0) {
        final consumo = (double.parse(mediaMoney.text) / x);
        return consumo;
      } else {
        final consumo = (double.parse(mediaKW.text));
        return consumo;
      }
    }

    final role = await Prefs.getString("ROLE");
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.

              return AlertDialog(
                content: Scaffold(
                  body: SingleChildScrollView(child: buildDialog(tarifa, context, powerPlantsMaior, mediaMaior, returnAll, returnConsumo(double.parse(tarifa.replaceAll(',', '.'))), tax, setState, role)),
                ),
              );
            },
          );
        });
  }

  _SimulatorControllerBase() {
    mediaMoney.addListener(() async {
      calcMediaMoney();
    });

    mediaKW.addListener(() async {
      calcMediaKW();
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

getCitiesData(month) async {
  final valor = await Prefs.getStringList("CITIES");

  return int.parse(valor[month].split(":")[1]);
}

int returnDaysOfMonth(xx) {
  var dateUtility = DateUtil();
  var now = new DateTime.now();
  var days = dateUtility.daysInMonth(xx, now.year);

  return days;
}

// DIALOG GERADA
@override
buildDialog(tarifa, context, pw, returnGenerationKW, returnAllMonths, consumo, returnTax, setState, role) {
  final inversor = TextEditingController();

  final garantia = TextEditingController();
  final potencia = TextEditingController();
  final marcaModulos = TextEditingController();
  final qtdModulos = TextEditingController();
  final geracao = TextEditingController();
  final area = TextEditingController();
  final codigo = TextEditingController();
  final cliente = TextEditingController();
  final bairro = TextEditingController();
  final cep = TextEditingController();
  final numero = TextEditingController();

  final dados = TextEditingController();
  final cpf = MaskedTextController(mask: '000.000.000-00');

  final valor = new MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');

  final endereco = TextEditingController();

  inversor.text = pw.inversor;
  potencia.text = pw.potencia.toString();
  marcaModulos.text = pw.marcaDoModulo.toString();
  qtdModulos.text = pw.numeroDeModulo.toString();

  geracao.text = returnGenerationKW.toString();
  marcaModulos.text = pw.marcaDoModulo.toString();
  qtdModulos.text = pw.numeroDeModulo.toString();
  area.text = pw.area.toString();
  codigo.text = pw.codigo.toString();
  valor.text = pw.valor.toString();
  garantia.text = "5 anos";

  qtdModulos.addListener(() {
    area.text = (2.25 * double.parse(qtdModulos.text)).round().toString();
  });

  potencia.addListener(() async {
    final irradiation = await AuthRepository().getIrradiation();
    final efficiency = await AuthRepository().getEfficiency();

    geracao.text = (double.parse(irradiation.replaceAll(',', '.')).toDouble() * double.parse(potencia.text) * 30 * efficiency).round().toString();
  });

  dados.text = pw.dados.replaceAll('<BR>', '\n');

  final pdf = pwa.Document();

  final List<Map<String, double>> valorEconomiaMensal = [
    {"valorPaga": double.parse(pw.consumoEmReais), "valorIraPagar": 91.00, "tarifaCidade": double.parse(tarifa.replaceAll(',', '.'))}
  ];

  final double valorEconomiaMensalTotal = valorEconomiaMensal[0]["valorPaga"].toDouble() + valorEconomiaMensal[0]["valorIraPagar"].toDouble();

  final double parc2 = (valorEconomiaMensal[0]["valorIraPagar"].toDouble() / valorEconomiaMensalTotal * 100);

  final val = new NumberFormat("#,##0.00", "pt_BR");

  final double valor_paga_ano = (valorEconomiaMensal[0]["valorPaga"].toDouble()) * 12.toDouble();
  final double valor_ira_pagar_ano = (valorEconomiaMensal[0]["valorIraPagar"].toDouble()) * 12.toDouble();

  final valor_economia_1_ano = val.format((valor_paga_ano - valor_ira_pagar_ano));
  final valor_economia_25_anos = val.format((valor_paga_ano - valor_ira_pagar_ano) * 25);

  final String valor_paga_ano_pdf = val.format(valor_paga_ano).toString();

  final String valor_ira_paga_ano_pdf = val.format(valor_ira_pagar_ano).toString();

// Economia em MES
  final valQuantoPagaBR = val.format(valorEconomiaMensal[0]["valorPaga"].toDouble());

  final valQuantoIraPagarBR = val.format(valorEconomiaMensal[0]["valorIraPagar"].toDouble());

  // economia 25 vanos
  final double economia_25_anos_paga = (valor_paga_ano - valor_ira_pagar_ano) * 111.346;

  final double economia_25_anos_pagara = ((91 * 12 * 25).toDouble() * 3.82);

  var vals = pw.valor.toString().trim().replaceAll('R\$', '').toString().replaceAll(',', '').replaceAll('.', '').trim();

  final value = int.parse(vals) / 100;

  var sicredi3x = value * (double.parse(returnTax[0].split(":")[1].split(",")[0]) / 3);
  var sicredi6x = value * (double.parse(returnTax[0].split(":")[1].split(",")[1]) / 6);
  var sicredi12x = value * (double.parse(returnTax[0].split(":")[1].split(",")[2]) / 12);
  var sicredi24x = value * (double.parse(returnTax[0].split(":")[1].split(",")[4])) / 24;
  var sicredi36x = value * (double.parse(returnTax[0].split(":")[1].split(",")[5]) / 36);
  var sicredi48x = value * (double.parse(returnTax[0].split(":")[1].split(",")[6]) / 48);
  var sicredi60x = value * (double.parse(returnTax[0].split(":")[1].split(",")[7]) / 60);
  var sicredi72x = value * (double.parse(returnTax[0].split(":")[1].split(",")[8]) / 72);
  //var sicrediTax = double.parse(returnTax[0].split(":")[1].split(",")[9]);

  var santanderEntrada = 14 * (value / 100);

  var value2 = (value - santanderEntrada);
  var santander3x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[0]) / 3);
  var santander6x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[1]) / 6);
  var santander12x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[2]) / 12);
  var santander18x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[3]) / 18);
  var santander24x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[4]) / 24);
  var santander36x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[5]) / 36);

  //var santanderTax = double.parse(returnTax[1].split(":")[1].split(",")[8]);

  //
  var bvFinanceira3x = value * (double.parse(returnTax[2].split(":")[1].split(",")[0]) / 3);
  var bvFinanceira6x = value * (double.parse(returnTax[2].split(":")[1].split(",")[1]) / 6);
  var bvFinanceira12x = value * (double.parse(returnTax[2].split(":")[1].split(",")[2]) / 12);
  var bvFinanceira24x = value * (double.parse(returnTax[2].split(":")[1].split(",")[4]) / 24);
  var bvFinanceira36x = value * (double.parse(returnTax[2].split(":")[1].split(",")[5]) / 36);
  var bvFinanceira48x = value * (double.parse(returnTax[2].split(":")[1].split(",")[6]) / 48);
  var bvFinanceira60x = value * (double.parse(returnTax[2].split(":")[1].split(",")[7]) / 60);
  var bvFinanceira72x = value * (double.parse(returnTax[2].split(":")[1].split(",")[8]) / 72);

  //

  var cartaoCredito3x = value * (double.parse(returnTax[3].split(":")[1].split(",")[0]) / 3);
  var cartaoCredito6x = value * (double.parse(returnTax[3].split(":")[1].split(",")[1]) / 6);
  var cartaoCredito12x = (value / (1 - 0.0745) / 12);
  var cartaoCredito24x = value * (double.parse(returnTax[3].split(":")[1].split(",")[3]) / 24);
  var cartaoCredito36x = value * (double.parse(returnTax[3].split(":")[1].split(",")[4]) / 36);
  var cartaoCredito48x = value * (double.parse(returnTax[3].split(":")[1].split(",")[5]) / 48);
  var cartaoCredito60x = value * (double.parse(returnTax[3].split(":")[1].split(",")[6]) / 60);
  var cartaoCredito72x = value * (double.parse(returnTax[3].split(":")[1].split(",")[7]) / 72);
  var cartaoCreditoTax = double.parse(returnTax[3].split(":")[1].split(",")[8]);

  valor.addListener(() {
    var vals = valor.text.trim().replaceAll('R\$', '').toString().replaceAll(',', '').replaceAll('.', '').trim();

    //final double value = double.parse(vals[1].replaceAll('.', ''));

    final double value = double.parse(vals) / 100;

    sicredi3x = value * (double.parse(returnTax[0].split(":")[1].split(",")[0]) / 3);
    sicredi6x = value * (double.parse(returnTax[0].split(":")[1].split(",")[1]) / 6);
    sicredi12x = value * (double.parse(returnTax[0].split(":")[1].split(",")[2]) / 12);
    sicredi24x = value * (double.parse(returnTax[0].split(":")[1].split(",")[4])) / 24;
    sicredi36x = value * (double.parse(returnTax[0].split(":")[1].split(",")[5]) / 36);
    sicredi48x = value * (double.parse(returnTax[0].split(":")[1].split(",")[6]) / 48);
    sicredi60x = value * (double.parse(returnTax[0].split(":")[1].split(",")[7]) / 60);
    sicredi72x = value * (double.parse(returnTax[0].split(":")[1].split(",")[8]) / 72);

    var santanderEntrada = 14 * (value / 100);

    value2 = (value - santanderEntrada);
    santander3x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[0]) / 3);
    santander6x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[1]) / 6);
    santander12x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[2]) / 12);
    santander18x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[3]) / 18);
    santander24x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[4]) / 24);
    santander36x = value2 * (double.parse(returnTax[1].split(":")[1].split(",")[5]) / 36);

    //var santanderTax = double.parse(returnTax[1].split(":")[1].split(",")[8]);

    //
    bvFinanceira3x = value * (double.parse(returnTax[2].split(":")[1].split(",")[0]) / 3);
    bvFinanceira6x = value * (double.parse(returnTax[2].split(":")[1].split(",")[1]) / 6);
    bvFinanceira12x = value * (double.parse(returnTax[2].split(":")[1].split(",")[2]) / 12);
    bvFinanceira24x = value * (double.parse(returnTax[2].split(":")[1].split(",")[4]) / 24);
    bvFinanceira36x = value * (double.parse(returnTax[2].split(":")[1].split(",")[5]) / 36);
    bvFinanceira48x = value * (double.parse(returnTax[2].split(":")[1].split(",")[6]) / 48);
    bvFinanceira60x = value * (double.parse(returnTax[2].split(":")[1].split(",")[7]) / 60);
    bvFinanceira72x = value * (double.parse(returnTax[2].split(":")[1].split(",")[8]) / 72);

    //

    cartaoCredito3x = value * (double.parse(returnTax[3].split(":")[1].split(",")[0]) / 3);
    cartaoCredito6x = value * (double.parse(returnTax[3].split(":")[1].split(",")[1]) / 6);
    cartaoCredito12x = (value / (1 - 0.0745) / 12);
    cartaoCredito24x = value * (double.parse(returnTax[3].split(":")[1].split(",")[3]) / 24);
    cartaoCredito36x = value * (double.parse(returnTax[3].split(":")[1].split(",")[4]) / 36);
    cartaoCredito48x = value * (double.parse(returnTax[3].split(":")[1].split(",")[5]) / 48);
    cartaoCredito60x = value * (double.parse(returnTax[3].split(":")[1].split(",")[6]) / 60);
    cartaoCredito72x = value * (double.parse(returnTax[3].split(":")[1].split(",")[7]) / 72);
    cartaoCreditoTax = double.parse(returnTax[3].split(":")[1].split(",")[8]);
  });

//
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();

  runChartGenerateImage1(img) async {
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List(), name: img);

    return result;
  }

  writeOnPdf(String nameFile) async {
    // GENERATE CHART GRAPH

    Directory tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir.path;

    returnImg(img) {
      final image = PdfImage.file(
        pdf.document,
        bytes: File('$tempPath/img/$img.png').readAsBytesSync(),
      );

      return image;
    }

    returnImageChart(img) {
      final image = PdfImage.file(
        pdf.document,
        bytes: File(('/storage/emulated/0/Soli Leads/$img.jpg')).readAsBytesSync(),
      );

      return image;
    }

    var consumoMostrar = consumo.round();

    var arvoresSalvas = consumoMostrar * 0.01;
    var co2 = consumoMostrar * (12 * 0.08);
    var anoscarro = consumoMostrar * 0.0090;

    pdf.addPage(
      pwa.MultiPage(
        crossAxisAlignment: pwa.CrossAxisAlignment.start,
        pageTheme: pwa.PageTheme(
          margin: pwa.EdgeInsets.zero,
          buildBackground: (context) {
            return pwa.Container(
              decoration: pwa.BoxDecoration(
                image: pwa.DecorationImage(
                  image: returnImg('pagina-1'),
                  fit: pwa.BoxFit.cover,
                ),
              ),
              child: pwa.Container(),
            );
          },
          pageFormat: PdfPageFormat.a4,
        ),
        header: (pwa.Context context) {
          return null;
        },
        footer: (pwa.Context context) {
          return pwa.Container(
            alignment: pwa.Alignment.centerRight,
            child: pwa.Text(
              '${context.pageNumber} / ${context.pagesCount}',
              textAlign: pwa.TextAlign.right,
              style: pwa.TextStyle(
                color: PdfColors.grey,
              ),
            ),
          );
        },
        build: (pwa.Context context) => <pwa.Widget>[
          pwa.Container(
              margin: pwa.EdgeInsets.only(
                top: 200,
              ),
              child: pwa.Stack(children: <pwa.Widget>[
                pwa.Container(
                  width: 535,
                  // FINANCIAMENTO financiamento
                  margin: pwa.EdgeInsets.only(top: 432, left: 44),
                  child: pwa.Column(crossAxisAlignment: pwa.CrossAxisAlignment.start, mainAxisAlignment: pwa.MainAxisAlignment.spaceBetween, children: <pwa.Widget>[
                    pwa.Row(children: <pwa.Widget>[pwa.Text(cliente.text, style: pwa.TextStyle(fontSize: 35, fontWeight: pwa.FontWeight.bold, color: PdfColor.fromHex("#FFFFFF")))]),
                    pwa.SizedBox(
                      height: 7,
                    ),
                    pwa.Row(children: <pwa.Widget>[
                      pwa.Text(endereco.text, style: pwa.TextStyle(fontSize: 22, color: PdfColor.fromHex("#FFFFFF"))),
                    ]),
                  ]),
                ),
              ])),
        ],
      ),
    );

    pdf.addPage(
      pwa.MultiPage(
        crossAxisAlignment: pwa.CrossAxisAlignment.start,
        pageTheme: pwa.PageTheme(
          margin: pwa.EdgeInsets.zero,
          buildBackground: (context) {
            return pwa.Container(
              decoration: pwa.BoxDecoration(
                image: pwa.DecorationImage(
                  image: returnImg('pagina-2'),
                  fit: pwa.BoxFit.cover,
                ),
              ),
              child: pwa.Container(),
            );
          },
          pageFormat: PdfPageFormat.a4,
        ),
        header: (pwa.Context context) {
          return null;
        },
        footer: (pwa.Context context) {
          return pwa.Container(
            alignment: pwa.Alignment.centerRight,
            child: pwa.Text(
              '${context.pageNumber} / ${context.pagesCount}',
              textAlign: pwa.TextAlign.right,
              style: pwa.TextStyle(
                color: PdfColors.grey,
              ),
            ),
          );
        },
        build: (pwa.Context context) => <pwa.Widget>[
          pwa.Container(),
        ],
      ),
    );

    pdf.addPage(
      pwa.MultiPage(
        crossAxisAlignment: pwa.CrossAxisAlignment.start,
        pageTheme: pwa.PageTheme(
          margin: pwa.EdgeInsets.zero,
          buildBackground: (context) {
            return pwa.Container(
              decoration: pwa.BoxDecoration(
                image: pwa.DecorationImage(
                  image: returnImg('pagina-3'),
                  fit: pwa.BoxFit.cover,
                ),
              ),
              child: pwa.Container(),
            );
          },
          pageFormat: PdfPageFormat.a4,
        ),
        header: (pwa.Context context) {
          return null;
        },
        footer: (pwa.Context context) {
          return pwa.Container(
            margin: pwa.EdgeInsets.only(right: 154, bottom: 5),
            alignment: pwa.Alignment.centerRight,
            child: pwa.Text(
              consumoMostrar.toString(),
              textAlign: pwa.TextAlign.right,
              style: pwa.TextStyle(
                color: PdfColors.white,
              ),
            ),
          );
        },
        build: (pwa.Context context) => <pwa.Widget>[
          pwa.Container(
              child: pwa.Row(
                  // mainAxisAlignment: pwa.MainAxisAlignment.end,
                  crossAxisAlignment: pwa.CrossAxisAlignment.end,
                  children: <pwa.Widget>[
                pwa.Container(
                  width: 145,
                  //color: PdfColor.fromHex("#FFC000"),
                  //
                  margin: pwa.EdgeInsets.only(top: 369, left: 400),
                  child: pwa.Text(potencia.text + ' kWp', style: pwa.TextStyle(color: PdfColor.fromHex("#FFFFFF"), fontSize: 25, fontWeight: pwa.FontWeight.bold)),
                ),
              ])),
          pwa.Container(
              child: pwa.Row(
                  // mainAxisAlignment: pwa.MainAxisAlignment.end,
                  crossAxisAlignment: pwa.CrossAxisAlignment.end,
                  children: <pwa.Widget>[
                pwa.Container(
                  width: 145,
                  //color: PdfColor.fromHex("#FFC000"),
                  //
                  margin: pwa.EdgeInsets.only(top: 25, left: 400),
                  child: pwa.Text(qtdModulos.text, style: pwa.TextStyle(color: PdfColor.fromHex("#FFFFFF"), fontSize: 25, fontWeight: pwa.FontWeight.bold)),
                ),
              ])),
          pwa.Container(
              child: pwa.Row(
                  // mainAxisAlignment: pwa.MainAxisAlignment.end,
                  crossAxisAlignment: pwa.CrossAxisAlignment.end,
                  children: <pwa.Widget>[
                pwa.Container(
                  width: 145,
                  //color: PdfColor.fromHex("#FFC000"),
                  //f
                  margin: pwa.EdgeInsets.only(top: 25, left: 400),
                  child: pwa.Text(geracao.text + ' kWh', style: pwa.TextStyle(color: PdfColor.fromHex("#FFFFFF"), fontSize: 25, fontWeight: pwa.FontWeight.bold)),
                ),
              ])),
          pwa.Container(
              child: pwa.Row(
                  // mainAxisAlignment: pwa.MainAxisAlignment.end,
                  crossAxisAlignment: pwa.CrossAxisAlignment.end,
                  children: <pwa.Widget>[
                pwa.Container(
                  width: 145,
                  //color: PdfColor.fromHex("#FFC000"),
                  //
                  margin: pwa.EdgeInsets.only(top: 20, left: 400),
                  child: pwa.Text('${area.text} m²', style: pwa.TextStyle(color: PdfColor.fromHex("#FFFFFF"), fontSize: 25, fontWeight: pwa.FontWeight.bold)),
                ),
              ])),
          pwa.Container(
              child: pwa.Row(
                  // mainAxisAlignment: pwa.MainAxisAlignment.end,
                  crossAxisAlignment: pwa.CrossAxisAlignment.end,
                  children: <pwa.Widget>[
                pwa.Container(
                  width: 500,
                  //color: PdfColor.fromHex("#FFC000"),
                  //
                  margin: pwa.EdgeInsets.only(top: 20, left: 44),
                  child: pwa.Center(child: pwa.Image(returnImageChart('grafico-1'))),
                ),
              ])),
        ],
      ),
    );

    pdf.addPage(
      pwa.MultiPage(
        crossAxisAlignment: pwa.CrossAxisAlignment.start,
        pageTheme: pwa.PageTheme(
          margin: pwa.EdgeInsets.zero,
          buildBackground: (context) {
            return pwa.Container(
              decoration: pwa.BoxDecoration(
                image: pwa.DecorationImage(
                  image: returnImg('pagina-4'),
                  fit: pwa.BoxFit.cover,
                ),
              ),
              child: pwa.Container(),
            );
          },
          pageFormat: PdfPageFormat.a4,
        ),
        header: (pwa.Context context) {
          return null;
        },
        footer: (pwa.Context context) {
          return pwa.Container(
            alignment: pwa.Alignment.centerRight,
            child: pwa.Text(
              '${context.pageNumber} / ${context.pagesCount}',
              textAlign: pwa.TextAlign.right,
              style: pwa.TextStyle(
                color: PdfColors.grey,
              ),
            ),
          );
        },
        build: (pwa.Context context) => <pwa.Widget>[
          pwa.Container(
              child: pwa.Stack(children: <pwa.Widget>[
            pwa.Row(
                // mainAxisAlignment: pwa.MainAxisAlignment.end,
                crossAxisAlignment: pwa.CrossAxisAlignment.end,
                children: <pwa.Widget>[
                  pwa.Container(
                    width: 185,
                    //color: PdfColor.fromHex("#FFC000"),
                    alignment: pwa.Alignment.center,
                    //
                    margin: pwa.EdgeInsets.only(top: 145, left: 15),
                    child: pwa.Text('R\$ $valor_paga_ano_pdf', style: pwa.TextStyle(color: PdfColor.fromHex("#FFFFFF"), fontSize: 25, fontWeight: pwa.FontWeight.bold)),
                  ),
                  pwa.Container(
                    width: 185,
                    // color: PdfColor.fromHex("#FFC000"),
                    alignment: pwa.Alignment.center,
                    //
                    margin: pwa.EdgeInsets.only(top: 0, left: 0),
                    child: pwa.Text('R\$ $valor_ira_paga_ano_pdf', style: pwa.TextStyle(color: PdfColor.fromHex("#FFFFFF"), fontSize: 25, fontWeight: pwa.FontWeight.bold)),
                  ),
                ]),
            // SUA ECONOMIA ANUAL
            pwa.Container(
              width: 185,
              //color: PdfColor.fromHex("#FFC000"),

              //
              margin: pwa.EdgeInsets.only(top: 110, left: 392),
              child: pwa.Text('R\$ $valor_economia_1_ano', style: pwa.TextStyle(color: PdfColor.fromHex("#FFFFFF"), fontSize: 20, fontWeight: pwa.FontWeight.bold)),
            ),
            pwa.Container(
              width: 185,
              //color: PdfColor.fromHex("#FFC000"),

              //
              margin: pwa.EdgeInsets.only(top: 154, left: 392),
              child: pwa.Text('R\$ $valor_economia_25_anos', style: pwa.TextStyle(color: PdfColor.fromHex("#FFFFFF"), fontSize: 20, fontWeight: pwa.FontWeight.bold)),
            ),
            pwa.Container(
                margin: pwa.EdgeInsets.only(
                  top: 200,
                ),
                child: pwa.Stack(children: <pwa.Widget>[
                  pwa.Row(
                      // mainAxisAlignment: pwa.MainAxisAlignment.end,
                      crossAxisAlignment: pwa.CrossAxisAlignment.end,
                      children: <pwa.Widget>[
                        pwa.Container(
                          width: 535,
                          //color: PdfColor.fromHex("#FFC000"),
                          //
                          margin: pwa.EdgeInsets.only(top: 67, left: 38),
                          child: pwa.Center(child: pwa.Image(returnImg('investimento'))),
                        ),
                      ]),
                  pwa.Row(children: <pwa.Widget>[
                    pwa.Container(
                        margin: pwa.EdgeInsets.only(left: 420, top: 71),
                        child: pwa.Text(valor.text,
                            style: pwa.TextStyle(
                              fontSize: 20,
                              fontWeight: pwa.FontWeight.bold,
                              color: PdfColor.fromHex("#FFFFFF"),
                            )))
                  ]),
                  pwa.Container(
                    width: 535,
                    // FINANCIAMENTO financiamento
                    margin: pwa.EdgeInsets.only(top: 168, left: 26),
                    child: pwa.Row(crossAxisAlignment: pwa.CrossAxisAlignment.start, mainAxisAlignment: pwa.MainAxisAlignment.spaceBetween, children: <pwa.Widget>[
                      pwa.Column(children: <pwa.Widget>[pwa.SizedBox(height: 20), pwa.Container(margin: pwa.EdgeInsets.only(left: 58, top: 2), child: pwa.Text('R\$ ${val.format(sicredi24x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 58, top: 8), child: pwa.Text('R\$ ${val.format(sicredi36x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 58, top: 8), child: pwa.Text('R\$ ${val.format(sicredi48x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 58, top: 8), child: pwa.Text('R\$ ${val.format(sicredi60x)}'))]),
                      pwa.Column(children: <pwa.Widget>[pwa.SizedBox(height: 15), pwa.Container(margin: pwa.EdgeInsets.only(left: 85, top: 6), child: pwa.Text('R\$ ${val.format(santanderEntrada)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 85, top: 5), child: pwa.Text('R\$ ${val.format(santander12x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 85, top: 4), child: pwa.Text('R\$ ${val.format(santander18x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 85, top: 1), child: pwa.Text('R\$ ${val.format(santander24x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 85, top: 3), child: pwa.Text('R\$ ${val.format(santander36x)}'))]),
                      pwa.Column(children: <pwa.Widget>[pwa.SizedBox(height: 1), pwa.Container(margin: pwa.EdgeInsets.only(left: 48, top: 5), child: pwa.Text('R\$ ${val.format(bvFinanceira24x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 48, top: 8), child: pwa.Text('R\$ ${val.format(bvFinanceira36x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 48, top: 8), child: pwa.Text('R\$ ${val.format(bvFinanceira48x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 48, top: 7), child: pwa.Text('R\$ ${val.format(bvFinanceira60x)}')), pwa.Container(margin: pwa.EdgeInsets.only(left: 48, top: 7), child: pwa.Text('R\$ ${val.format(bvFinanceira72x)}'))]),
                      pwa.Column(children: <pwa.Widget>[pwa.SizedBox(height: 17), pwa.Container(margin: pwa.EdgeInsets.only(left: 28, top: 60), child: pwa.Text('R\$ ${val.format(cartaoCredito12x)}', style: pwa.TextStyle(fontSize: 20)))]),
                    ]),
                  ),
                  pwa.Row(
                      // mainAxisAlignment: pwa.MainAxisAlignment.end,
                      crossAxisAlignment: pwa.CrossAxisAlignment.end,
                      children: <pwa.Widget>[
                        pwa.Container(
                          width: 535,
                          // color: PdfColor.fromHex("#FFC000"),
                          //
                          margin: pwa.EdgeInsets.only(top: 347, left: 38),
                          //#TODO SE A QUANTIDADE DE DADOS DO SISTEMA FOR MUITO GRANDE VAI QUEBRAR O PDF
                          child: pwa.Text(dados.text.replaceAll('\n', '\n'), style: pwa.TextStyle(lineSpacing: 5, fontSize: 8)),
                        ),
                      ]),
                ])),
          ])),
        ],
      ),
    );

    pdf.addPage(
      pwa.MultiPage(
        crossAxisAlignment: pwa.CrossAxisAlignment.start,
        pageTheme: pwa.PageTheme(
          margin: pwa.EdgeInsets.zero,
          buildBackground: (context) {
            return pwa.Container(
              decoration: pwa.BoxDecoration(
                image: pwa.DecorationImage(
                  image: returnImg('pagina-5'),
                  fit: pwa.BoxFit.cover,
                ),
              ),
              child: pwa.Container(),
            );
          },
          pageFormat: PdfPageFormat.a4,
        ),
        header: (pwa.Context context) {
          return null;
        },
        build: (pwa.Context context) => <pwa.Widget>[
          pwa.Container(
              child: pwa.Stack(children: <pwa.Widget>[
            pwa.Row(
                // mainAxisAlignment: pwa.MainAxisAlignment.end,
                crossAxisAlignment: pwa.CrossAxisAlignment.end,
                children: <pwa.Widget>[]),
            // SUA ECONOMIA ANUAL

            pwa.Container(
                margin: pwa.EdgeInsets.only(
                  top: 200,
                ),
                child: pwa.Stack(children: <pwa.Widget>[
                  pwa.Row(
                      // mainAxisAlignment: pwa.MainAxisAlignment.end,
                      crossAxisAlignment: pwa.CrossAxisAlignment.end,
                      children: <pwa.Widget>[
                        pwa.Container(
                          width: 310,
                          color: PdfColor.fromHex("#FFFFFF"),
                          margin: pwa.EdgeInsets.only(top: 188, left: 210),
                          child: pwa.Row(mainAxisAlignment: pwa.MainAxisAlignment.spaceBetween, children: <pwa.Widget>[pwa.Text(inversor.text, style: pwa.TextStyle(color: PdfColor.fromHex("#666666"), fontSize: 14, fontWeight: pwa.FontWeight.bold)), pwa.Text(garantia.text, style: pwa.TextStyle(color: PdfColor.fromHex("#666666"), fontSize: 14, fontWeight: pwa.FontWeight.bold))]),
                        ),
                      ]),
                  pwa.Row(
                      // mainAxisAlignment: pwa.MainAxisAlignment.end,
                      crossAxisAlignment: pwa.CrossAxisAlignment.end,
                      children: <pwa.Widget>[
                        pwa.Container(
                          width: 310,
                          color: PdfColor.fromHex("#FFFFFF"),
                          //
                          margin: pwa.EdgeInsets.only(top: 243, left: 210),
                          child: pwa.Row(mainAxisAlignment: pwa.MainAxisAlignment.spaceBetween, children: <pwa.Widget>[pwa.Text(marcaModulos.text, style: pwa.TextStyle(color: PdfColor.fromHex("#666666"), fontSize: 14, fontWeight: pwa.FontWeight.bold)), pwa.Text("25 Anos", style: pwa.TextStyle(color: PdfColor.fromHex("#666666"), fontSize: 14, fontWeight: pwa.FontWeight.bold))]),
                        ),
                      ]),
                ])),
          ])),
        ],
      ),
    );

    pdf.addPage(
      pwa.MultiPage(
        crossAxisAlignment: pwa.CrossAxisAlignment.start,
        pageTheme: pwa.PageTheme(
          margin: pwa.EdgeInsets.zero,
          buildBackground: (context) {
            return pwa.Container(
              decoration: pwa.BoxDecoration(
                image: pwa.DecorationImage(
                  image: returnImg('pagina-6'),
                  fit: pwa.BoxFit.cover,
                ),
              ),
              child: pwa.Container(),
            );
          },
          pageFormat: PdfPageFormat.a4,
        ),
        header: (pwa.Context context) {
          return null;
        },
        footer: (pwa.Context context) {
          return pwa.Container(
            alignment: pwa.Alignment.centerRight,
            child: pwa.Text(
              '${context.pageNumber} / ${context.pagesCount}',
              textAlign: pwa.TextAlign.right,
              style: pwa.TextStyle(
                color: PdfColors.grey,
              ),
            ),
          );
        },
        build: (pwa.Context context) => <pwa.Widget>[
          pwa.Container(),
        ],
      ),
    );

    pdf.addPage(
      pwa.MultiPage(
        crossAxisAlignment: pwa.CrossAxisAlignment.start,
        pageTheme: pwa.PageTheme(
          margin: pwa.EdgeInsets.zero,
          buildBackground: (context) {
            return pwa.Container(
              decoration: pwa.BoxDecoration(
                image: pwa.DecorationImage(
                  image: returnImg('pagina-7'),
                  fit: pwa.BoxFit.cover,
                ),
              ),
              child: pwa.Container(),
            );
          },
          pageFormat: PdfPageFormat.a4,
        ),
        header: (pwa.Context context) {
          return null;
        },
        footer: (pwa.Context context) {
          return pwa.Container(
            alignment: pwa.Alignment.centerRight,
            child: pwa.Text(
              '${context.pageNumber} / ${context.pagesCount}',
              textAlign: pwa.TextAlign.right,
              style: pwa.TextStyle(
                color: PdfColors.grey,
              ),
            ),
          );
        },
        build: (pwa.Context context) => <pwa.Widget>[
          pwa.Container(
              margin: pwa.EdgeInsets.only(
                top: 200,
              ),
              child: pwa.Stack(children: <pwa.Widget>[
                pwa.Row(
                    // mainAxisAlignment: pwa.MainAxisAlignment.end,
                    crossAxisAlignment: pwa.CrossAxisAlignment.end,
                    children: <pwa.Widget>[
                      pwa.Container(
                        // color: PdfColors.red,
                        width: 16,
                        margin: pwa.EdgeInsets.only(top: 117, left: 106),
                        alignment: pwa.Alignment.topRight,
                        child: pwa.Text(
                          arvoresSalvas.round().toString(),
                          textAlign: pwa.TextAlign.right,
                          style: pwa.TextStyle(
                            color: PdfColor.fromHex("#5F5E5E"),
                          ),
                        ),
                      ),
                    ]),
                pwa.Row(
                    // mainAxisAlignment: pwa.MainAxisAlignment.end,
                    crossAxisAlignment: pwa.CrossAxisAlignment.end,
                    children: <pwa.Widget>[
                      pwa.Container(
                        //color: PdfColors.red,
                        width: 105,
                        margin: pwa.EdgeInsets.only(top: 176, left: 35),
                        alignment: pwa.Alignment.topRight,
                        child: pwa.Text(
                          co2.round().toString(),
                          textAlign: pwa.TextAlign.right,
                          style: pwa.TextStyle(
                            color: PdfColor.fromHex("#5F5E5E"),
                          ),
                        ),
                      ),
                    ]),
                pwa.Row(
                    // mainAxisAlignment: pwa.MainAxisAlignment.end,
                    crossAxisAlignment: pwa.CrossAxisAlignment.end,
                    children: <pwa.Widget>[
                      pwa.Container(
                        // color: PdfColors.red,
                        width: 16,
                        margin: pwa.EdgeInsets.only(top: 240, left: 119),
                        alignment: pwa.Alignment.topRight,
                        child: pwa.Text(
                          anoscarro.round().toString(),
                          textAlign: pwa.TextAlign.right,
                          style: pwa.TextStyle(
                            color: PdfColor.fromHex("#5F5E5E"),
                          ),
                        ),
                      ),
                    ]),
              ])),
        ],
      ),
    );

    Directory documentDirectory = await getExternalStorageDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/$nameFile.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  /////////////////////// PDF //////////////////////////////////////
  final scrollController = ScrollController();
// DIALOG DE VISUALIZACAO DA USINA
  bool dadosDaUsina_view = false;
  bool custosEComissoes_view = false;

  return Center(
    child: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 90,
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Wrap(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.assessment, color: Colors.blue),
                  SizedBox(width: 20),
                  Text(
                    'Dados da Usina ',
                    style: ubuntu16BlueBold500,
                  ),
                  SizedBox(height: 40),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.highlight_off,
                  //     color: Colors.blue,
                  //     size: 30,
                  //   ),
                  //   onPressed: Navigator.of(context).pop,
                  // ),
                ],
              ),
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Código do sistema: ', style: ubuntu16BlackBold500),
                        TextSpan(text: pw.codigo, style: ubuntu16BlueBold500),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Marca do inversor: ', style: ubuntu16BlackBold500),
                        TextSpan(text: pw.inversor, style: ubuntu16BlueBold500),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Marca das placas: ', style: ubuntu16BlackBold500),
                        TextSpan(text: pw.marcaDoModulo, style: ubuntu16BlueBold500),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Numero de Placas: ', style: ubuntu16BlackBold500),
                        TextSpan(text: pw.numeroDeModulo.toString(), style: ubuntu16BlueBold500),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Área: ', style: ubuntu16BlackBold500),
                        TextSpan(text: pw.area.toString(), style: ubuntu16BlueBold500),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Potência do sistema: ', style: ubuntu16BlackBold500),
                        TextSpan(text: pw.potencia.toString(), style: ubuntu16BlueBold500),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Geração do sistema: ', style: ubuntu16BlackBold500),
                        TextSpan(text: returnGenerationKW.toString() + ' KWp', style: ubuntu16BlueBold500),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Valor do sistema: ', style: ubuntu16BlackBold500),
                        TextSpan(text: pw.valor.toString(), style: ubuntu16BlueBold500),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 200,
                child: SingleChildScrollView(
                  child: SelectableText.rich(
                    TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: pw.dados.replaceAll('<BR>', '\n'), style: TextStyle(fontSize: 10, color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DangerButton(
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.backspace,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Voltar',
                              style: buttonLargeWhite,
                            ),
                          ],
                        ),
                      ),

                      //onPressed:controller.loginWithGoogle,

                      onPressed: () {
                        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                          statusBarColor: main.MainColors.cielo, //or set color with: Color(0xFF0000FF)
                        ));
                        Navigator.of(context).pop();
                      },
                    ).getLarge(),
                    SizedBox(
                      width: 20,
                    ),
                    PrimaryButton(
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                'Avançar',
                                style: buttonLargeWhite,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        //onPressed:controller.loginWithGoogle,

                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              bool _loaderGenerateGraph = false;

                              return StatefulBuilder(
                                builder: (context, setState) {
                                  goGeneratePDF() async {
                                    scrollController.animateTo(scrollController.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                    setState(() {
                                      _loaderGenerateGraph = true;
                                    });

                                    Future.delayed(const Duration(milliseconds: 4000), () async {
                                      await runChartGenerateImage1("grafico-1");

                                      final String file = "Pré-Proposta($returnGenerationKW kWh) Soli Energia";

                                      await writeOnPdf(file);

                                      Directory documentDirectory = await getExternalStorageDirectory();

                                      String documentPath = documentDirectory.path;

                                      String fullPath = "$documentPath/$file.pdf";

                                      setState(() {
                                        _loaderGenerateGraph = false;
                                      });

                                      DatabaseHelper().savePlant(pw);

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PdfPreviewScreen(path: fullPath, pw: pw, file: file)));
                                    });
                                  }

                                  Future<void> paste(name) async {
                                    final ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
                                    if (name == "cliente") cliente.text = data.text;
                                    if (name == "cpf") cpf.text = data.text;
                                    if (name == "cep") cep.text = data.text;
                                    if (name == "bairro") bairro.text = data.text;
                                    if (name == "endereco") endereco.text = data.text;
                                    if (name == "inversor") inversor.text = data.text;
                                    if (name == "potencia") potencia.text = data.text;
                                    if (name == "modulos") marcaModulos.text = data.text;
                                    if (name == "qtd") qtdModulos.text = data.text;
                                    if (name == "geracao") geracao.text = data.text;
                                    if (name == "area") area.text = data.text;
                                    if (name == "codigo") codigo.text = data.text;
                                    if (name == "dados") dados.text = data.text;
                                    // return data;
                                  }

                                  cliente.addListener(() {
                                    pw.cliente = cliente.text;
                                  });

                                  endereco.addListener(() {
                                    pw.endereco = endereco.text;
                                  });

                                  final focusNode = FocusNode();
                                  final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
                                  return AlertDialog(
                                    content: Scaffold(
                                      resizeToAvoidBottomPadding: true,
                                      body: SingleChildScrollView(
                                        controller: scrollController,
                                        child: Stack(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(bottom: 50),
                                              margin: EdgeInsets.only(bottom: 50),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Wrap(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Dados do cliente2',
                                                              style: ubuntu16BlueBold500,
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 18),
                                                          child: OutlinedTextEdit(
                                                            prefixIcon: Icon(Icons.account_circle),
                                                            onChanged: (value) => {},
                                                            label: "Nome do cliente",
                                                            inputType: InputType.EXTRA_SMALL,
                                                            controller: cliente,
                                                            suffixIcon: IconButton(
                                                                icon: Icon(Icons.content_paste),
                                                                onPressed: () {
                                                                  paste("cliente");
                                                                }),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 18),
                                                          child: OutlinedTextEdit(
                                                            prefixIcon: Icon(Icons.chat),
                                                            keyboardType: TextInputType.number,
                                                            onChanged: (value) => {},
                                                            label: "CPF do cliente",
                                                            controller: cpf,
                                                            inputType: InputType.EXTRA_SMALL,
                                                            suffixIcon: IconButton(
                                                                icon: Icon(Icons.content_paste),
                                                                onPressed: () {
                                                                  paste("cpf");
                                                                }),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 18),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: OutlinedTextEdit(
                                                                  prefixIcon: Icon(Icons.assistant_photo),
                                                                  keyboardType: TextInputType.number,
                                                                  onChanged: (value) => {},
                                                                  label: "CEP",
                                                                  controller: cep,
                                                                  inputType: InputType.EXTRA_SMALL,
                                                                  suffixIcon: IconButton(
                                                                      icon: Icon(Icons.content_paste),
                                                                      onPressed: () {
                                                                        paste("cep");
                                                                      }),
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Expanded(
                                                                child: OutlinedTextEdit(
                                                                  prefixIcon: Icon(Icons.dialpad),
                                                                  keyboardType: TextInputType.number,
                                                                  onChanged: (value) => {},
                                                                  label: "Bairro",
                                                                  controller: bairro,
                                                                  suffixIcon: IconButton(
                                                                      icon: Icon(Icons.content_paste),
                                                                      onPressed: () {
                                                                        paste("bairro");
                                                                      }),
                                                                  inputType: InputType.EXTRA_SMALL,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 18),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: OutlinedTextEdit(
                                                                  prefixIcon: Icon(Icons.dvr),
                                                                  keyboardType: TextInputType.text,
                                                                  onChanged: (value) => {},
                                                                  label: "Endereço",
                                                                  controller: endereco,
                                                                  inputType: InputType.EXTRA_SMALL,
                                                                  suffixIcon: IconButton(
                                                                      icon: Icon(Icons.content_paste),
                                                                      onPressed: () {
                                                                        paste("endereco");
                                                                      }),
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Expanded(
                                                                flex: 1,
                                                                child: OutlinedTextEdit(
                                                                  prefixIcon: Icon(Icons.texture),
                                                                  keyboardType: TextInputType.number,
                                                                  controller: numero,
                                                                  onChanged: (value) => {},
                                                                  label: "Número",
                                                                  inputType: InputType.EXTRA_SMALL,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        role == "ROLE_ADMIN"
                                                            ? InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    dadosDaUsina_view = !dadosDaUsina_view;
                                                                  });
                                                                },
                                                                child: Container(
                                                                  margin: EdgeInsets.only(top: 30),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        'Dados da usina',
                                                                        style: ubuntu16BlueBold500,
                                                                      ),
                                                                      IconButton(
                                                                          iconSize: 30,
                                                                          icon: dadosDaUsina_view == false ? Icon(Icons.arrow_drop_down_circle, color: MainColors.cielo) : Icon(Icons.arrow_drop_up, color: Colors.grey),
                                                                          onPressed: () {
                                                                            setState(() {
                                                                              dadosDaUsina_view = !dadosDaUsina_view;
                                                                            });
                                                                          })
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : SizedBox(),
                                                        role == "ROLE_ADMIN"
                                                            ? Visibility(
                                                                visible: dadosDaUsina_view,
                                                                child: Wrap(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(top: 16),
                                                                      child: Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex: 2,
                                                                            child: OutlinedTextEdit(
                                                                              keyboardType: TextInputType.text,
                                                                              onChanged: (value) => {},
                                                                              label: "Inversor",
                                                                              controller: inversor,
                                                                              suffixIcon: IconButton(
                                                                                  icon: Icon(Icons.content_paste),
                                                                                  onPressed: () {
                                                                                    paste("inversor");
                                                                                  }),
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex: 1,
                                                                            child: OutlinedTextEdit(
                                                                              keyboardType: TextInputType.text,
                                                                              onChanged: (value) => {},
                                                                              label: "Garantia",
                                                                              controller: garantia,
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 10),
                                                                          Expanded(
                                                                            flex: 1,
                                                                            child: OutlinedTextEdit(
                                                                              keyboardType: TextInputType.number,
                                                                              onChanged: (value) => {},
                                                                              controller: potencia,
                                                                              label: "Potência",
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(top: 16),
                                                                      child: Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex: 1,
                                                                            child: OutlinedTextEdit(
                                                                              prefixIcon: Icon(Icons.view_comfy),
                                                                              keyboardType: TextInputType.text,
                                                                              onChanged: (value) => {},
                                                                              label: "Módulos",
                                                                              controller: marcaModulos,
                                                                              suffixIcon: IconButton(
                                                                                  icon: Icon(Icons.content_paste),
                                                                                  onPressed: () {
                                                                                    paste("modulos");
                                                                                  }),
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 10),
                                                                          Expanded(
                                                                            flex: 1,
                                                                            child: OutlinedTextEdit(
                                                                              prefixIcon: Icon(Icons.format_list_numbered),
                                                                              keyboardType: TextInputType.number,
                                                                              onChanged: (value) => {},
                                                                              suffixIcon: IconButton(
                                                                                  icon: Icon(Icons.content_paste),
                                                                                  onPressed: () {
                                                                                    paste("qtd");
                                                                                  }),
                                                                              label: "Quant.",
                                                                              controller: qtdModulos,
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(top: 16),
                                                                      child: Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex: 1,
                                                                            child: OutlinedTextEdit(
                                                                              prefixIcon: Icon(Icons.usb),
                                                                              keyboardType: TextInputType.number,
                                                                              onChanged: (value) => {},
                                                                              suffixIcon: IconButton(
                                                                                  icon: Icon(Icons.content_paste),
                                                                                  onPressed: () {
                                                                                    paste("geracao");
                                                                                  }),
                                                                              label: "Geração kWp",
                                                                              controller: geracao,
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 10),
                                                                          Expanded(
                                                                            flex: 1,
                                                                            child: OutlinedTextEdit(
                                                                              prefixIcon: Icon(Icons.aspect_ratio),
                                                                              keyboardType: TextInputType.number,
                                                                              onChanged: (value) => {},
                                                                              label: "Área",
                                                                              suffixIcon: IconButton(
                                                                                  icon: Icon(Icons.content_paste),
                                                                                  onPressed: () {
                                                                                    paste("area");
                                                                                  }),
                                                                              controller: area,
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(top: 16),
                                                                      child: Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex: 1,
                                                                            child: OutlinedTextEdit(
                                                                              keyboardType: TextInputType.number,
                                                                              onChanged: (value) => {},
                                                                              label: "Código",
                                                                              suffixIcon: IconButton(
                                                                                  icon: Icon(Icons.content_paste),
                                                                                  onPressed: () {
                                                                                    paste("codigo");
                                                                                  }),
                                                                              controller: codigo,
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 10),
                                                                          Expanded(
                                                                            flex: 1,
                                                                            child: OutlinedTextEdit(
                                                                              prefixIcon: Icon(Icons.monetization_on),
                                                                              keyboardType: TextInputType.number,
                                                                              onChanged: (value) => {},
                                                                              label: "R\$ Valor",
                                                                              controller: valor,
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(top: 16),
                                                                      child: Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex: 1,
                                                                            child: OutlinedTextEdit(
                                                                              keyboardType: TextInputType.multiline,
                                                                              maxLines: 10,
                                                                              minLines: 10,
                                                                              suffixIcon: IconButton(
                                                                                  icon: Icon(Icons.content_paste),
                                                                                  onPressed: () {
                                                                                    paste("dados");
                                                                                  }),
                                                                              onChanged: (value) => {},
                                                                              label: "Dados da usina",
                                                                              controller: dados,
                                                                              inputType: InputType.EXTRA_SMALL,
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 10),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 100,
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    width: 1,
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Center(
                                                          child: SingleChildScrollView(
                                                            scrollDirection: Axis.horizontal,
                                                            child: Row(
                                                              children: <Widget>[
                                                                SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      RepaintBoundary(
                                                                        key: globalKey,
                                                                        child: Container(
                                                                          color: Colors.white,
                                                                          child: Chart(
                                                                            meses: returnAllMonths,
                                                                            consumo: consumo,
                                                                          ),
                                                                          height: 700,
                                                                          width: 1500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: _loaderGenerateGraph,
                                              child: Container(
                                                color: Colors.white,
                                                height: MediaQuery.of(context).size.height,
                                                child: Center(
                                                  //color: Colors.white,
                                                  // height: MediaQuery.of(context).size.height,

                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Stack(
                                                        children: <Widget>[
                                                          Center(
                                                            child: Container(
                                                              margin: EdgeInsets.only(top: 60),
                                                              child: Image.asset(
                                                                'lib/app/shared/assets/images/l.png',
                                                                width: 70,
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Container(
                                                              width: 200,
                                                              height: 200,
                                                              child: CircularProgressIndicator(
                                                                strokeWidth: 1,
                                                                backgroundColor: Colors.blue[500],
                                                                valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      floatingActionButton: showFab
                                          ? Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Observer(builder: (BuildContext context) {
                                                  return Container(
                                                    margin: EdgeInsets.only(left: 16),
                                                    child: DangerButton(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.backspace,
                                                            color: Colors.white,
                                                            size: 30,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            'Voltar',
                                                            style: buttonLargeWhite,
                                                          ),
                                                        ],
                                                      ),

                                                      ////onPressed:controller.loginWithGoogle,

                                                      onPressed: !_loaderGenerateGraph ? Navigator.of(context).pop : null,
                                                    ).getLarge(),
                                                  );
                                                }),
                                                PrimaryButton(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Gerar PDF',
                                                        style: buttonLargeWhite,
                                                      ),
                                                      Icon(
                                                        Icons.assignment_turned_in,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ],
                                                  ),
                                                  //onPressed:controller.loginWithGoogle,

                                                  // SETANDO NOVA

                                                  onPressed: !_loaderGenerateGraph ? goGeneratePDF : null,
                                                ).getLarge(),
                                              ],
                                            )
                                          : null,
                                    ),
                                  );
                                },
                              );
                            },
                          );

                          //Navigator.of(context).pop();
                        }).getLarge(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
