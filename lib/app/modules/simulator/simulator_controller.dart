import 'dart:io';

import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:login/app/modules/home/home_controller.dart';
import 'package:login/app/modules/simulator/chart.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/dados_kits.dart';
import 'package:login/app/shared/repositories/entities/power_plants.dart';
import 'package:login/app/shared/styles/main_style.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:mobx/mobx.dart';

import 'package:login/app/shared/repositories/proposal_strings.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pwa;
import 'PdfPreviewScreen.dart';

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

  final testValue = TextEditingController();

  final p1 = Object();

  @observable
  bool disableAdd = true;

  @observable
  String typePlant;

  final powerPlantsMenor = PowerPlants();

  final powerPlantsMaior = PowerPlants();

  @action
  showDialogKitMenor(context) async {
    // print('[KIT MENOR ] ');
    // print('[KIT ID ] ' + powerPlantsMenor.id.toString());
    // print('[KIT CODIGO ] ' + powerPlantsMenor.codigo.toString());
    // print('[KIT AREA ] ' + powerPlantsMenor.area);
    // print('[KIT INVERSOR ] ' + powerPlantsMenor.inversor);
    // print('[KIT QUANTIDADE DE PLACAS ] ' +
    //     powerPlantsMenor.numeroDeModulo.toString());
    // print('[KIT MARCA DAS PLACAS ] ' + powerPlantsMenor.marcaDoModulo);
    // print('[KIT POTENCIA DAS PLACAS ] ' + powerPlantsMenor.potenciaDoModulo);
    // print('[KIT AREA ] ' + powerPlantsMenor.area);
    // print('[KIT PESO ] ' + powerPlantsMenor.peso);
    // print('[KIT PREÇO TOTAL ] ' + powerPlantsMenor.valor);
    // print('[KIT] ' + powerPlantsMenor.dados);

    final valor = await Prefs.getStringList("CITIES");

    var jan = double.parse(valor[1].split(":")[1]);
    var janValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(1) *
        jan *
        .75;

    var fev = double.parse(valor[2].split(":")[1]);
    var fevValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(2) *
        fev *
        .75;

    var mar = double.parse(valor[3].split(":")[1]);
    var marValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(3) *
        mar *
        .75;

    var abr = double.parse(valor[4].split(":")[1]);
    var abrValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(4) *
        abr *
        .75;

    var mai = double.parse(valor[5].split(":")[1]);
    var maiValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(5) *
        mai *
        .75;

    var jun = double.parse(valor[6].split(":")[1]);
    var junValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(6) *
        jun *
        .75;

    var jul = double.parse(valor[7].split(":")[1]);
    var julValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(7) *
        jul *
        .75;

    var ago = double.parse(valor[8].split(":")[1]);
    var agoValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(8) *
        ago *
        .75;

    var sep = double.parse(valor[9].split(":")[1]);
    var sepValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(9) *
        sep *
        .75;

    var out = double.parse(valor[10].split(":")[1]);
    var outValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(10) *
        out *
        .75;

    var nov = double.parse(valor[11].split(":")[1]);
    var novValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(11) *
        nov *
        .75;

    var dez = double.parse(valor[12].split(":")[1]);
    var dezValue = double.parse(powerPlantsMenor.potencia) *
        returnDaysOfMonth(12) *
        dez *
        .75;

    final mediaGeracaoKwpMenor = (janValue +
            fevValue +
            marValue +
            abrValue +
            maiValue +
            junValue +
            julValue +
            agoValue +
            sepValue +
            outValue +
            novValue +
            dezValue) /
        12;

    // print('[ JAN ] ' + janValue.toString());
    // print('[ FEV ] ' + fevValue.toString());
    // print('[ MAR ] ' + marValue.toString());
    // print('[ ABR ] ' + abrValue.toString());
    // print('[ MAI ] ' + maiValue.toString());
    // print('[ JUN ] ' + junValue.toString());
    // print('[ JUL ] ' + julValue.toString());
    // print('[ AGO ] ' + agoValue.toString());
    // print('[ SET ] ' + sepValue.toString());
    // print('[ OUT ] ' + outValue.toString());
    // print('[ NOV ] ' + novValue.toString());
    // print('[ DEZ ] ' + dezValue.toString());

    print('[ MEDIA MENOR ] ' + mediaGeracaoKwpMenor.toString());

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

                  return SingleChildScrollView(
                    child: buildDialog(context, powerPlantsMenor,
                        mediaGeracaoKwpMenor.round()),
                  );
                },
              ),
            ));
  }

  @action
  showDialogKitMaior(context) async {
    final valor = await Prefs.getStringList("CITIES");

    var jan = double.parse(valor[1].split(":")[1]);
    var janValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(1) *
        jan *
        .75;

    var fev = double.parse(valor[2].split(":")[1]);
    var fevValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(2) *
        fev *
        .75;

    var mar = double.parse(valor[3].split(":")[1]);
    var marValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(3) *
        mar *
        .75;

    var abr = double.parse(valor[4].split(":")[1]);
    var abrValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(4) *
        abr *
        .75;

    var mai = double.parse(valor[5].split(":")[1]);
    var maiValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(5) *
        mai *
        .75;

    var jun = double.parse(valor[6].split(":")[1]);
    var junValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(6) *
        jun *
        .75;

    var jul = double.parse(valor[7].split(":")[1]);
    var julValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(7) *
        jul *
        .75;

    var ago = double.parse(valor[8].split(":")[1]);
    var agoValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(8) *
        ago *
        .75;

    var sep = double.parse(valor[9].split(":")[1]);
    var sepValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(9) *
        sep *
        .75;

    var out = double.parse(valor[10].split(":")[1]);
    var outValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(10) *
        out *
        .75;

    var nov = double.parse(valor[11].split(":")[1]);
    var novValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(11) *
        nov *
        .75;

    var dez = double.parse(valor[12].split(":")[1]);
    var dezValue = double.parse(powerPlantsMaior.potencia) *
        returnDaysOfMonth(12) *
        dez *
        .75;

    final mediaGeracaoKwpMaior = (janValue +
            fevValue +
            marValue +
            abrValue +
            maiValue +
            junValue +
            julValue +
            agoValue +
            sepValue +
            outValue +
            novValue +
            dezValue) /
        12;

    // print('[ JAN ] ' + janValue.toString());
    // print('[ FEV ] ' + fevValue.toString());
    // print('[ MAR ] ' + marValue.toString());
    // print('[ ABR ] ' + abrValue.toString());
    // print('[ MAI ] ' + maiValue.toString());
    // print('[ JUN ] ' + junValue.toString());
    // print('[ JUL ] ' + julValue.toString());
    // print('[ AGO ] ' + agoValue.toString());
    // print('[ SET ] ' + sepValue.toString());
    // print('[ OUT ] ' + outValue.toString());
    // print('[ NOV ] ' + novValue.toString());
    // print('[ DEZ ] ' + dezValue.toString());

    print('[ MEDIA MAIOR ] ' + mediaGeracaoKwpMaior.toString());

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

                  return SingleChildScrollView(
                    child: buildDialog(context, powerPlantsMaior,
                        mediaGeracaoKwpMaior.round()),
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

@override
Widget buildDialog(context, pw, mediaGeracaoKwp) {
  final pdf = pwa.Document();

  writeOnPdf() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final image = PdfImage.file(
      pdf.document,
      bytes: File('$tempPath/img/logo_pdf.png').readAsBytesSync(),
    );

    final image_topo_marca = PdfImage.file(
      pdf.document,
      bytes: File('$tempPath/img/logo_topo_marca.png').readAsBytesSync(),
    );

    pdf.addPage(pwa.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pwa.EdgeInsets.all(32),
      build: (pwa.Context context) {
        return <pwa.Widget>[
          pwa.Column(
            children: <pwa.Widget>[
              pwa.SizedBox(height: 50),
              pwa.Center(child: pwa.Image(image)),
              pwa.Center(
                child: pwa.Container(
                    margin: pwa.EdgeInsets.symmetric(vertical: 20),
                    child: pwa.Text("PROPOSTA COMERCIAL",
                        style: pwa.TextStyle(fontSize: 20))),
              ),
              pwa.Center(
                child: pwa.Container(
                    margin: pwa.EdgeInsets.only(bottom: 20),
                    child: pwa.Container(
                        width: 600,
                        height: 5,
                        color: PdfColor.fromHex("#FFC000"))),
              ),
              pwa.Center(
                child: pwa.Container(
                    margin: pwa.EdgeInsets.only(top: 40),
                    child: pwa.Container(
                        child: pwa.Text("Heitor Fabrício Klaus",
                            style: pwa.TextStyle(
                                fontSize: 20,
                                fontWeight: pwa.FontWeight.bold)))),
              ),
              pwa.Center(
                child: pwa.Container(
                    margin: pwa.EdgeInsets.only(top: 10, bottom: 0),
                    child: pwa.Container(
                        child: pwa.Text(
                            "AVENIDA TANCREDO NEVES, 1119 CORREGO DO BARBADO",
                            style: pwa.TextStyle(
                              fontSize: 10,
                            )))),
              ),
              pwa.SizedBox(height: 20),
              pwa.Row(
                mainAxisAlignment: pwa.MainAxisAlignment.spaceEvenly,
                children: <pwa.Widget>[
                  pwa.Column(children: <pwa.Widget>[
                    pwa.Container(
                      color: PdfColor.fromHex("#FFC000"),
                      padding: pwa.EdgeInsets.only(top: 9, left: 15, right: 15),
                      height: 30,
                      child: pwa.Column(children: <pwa.Widget>[
                        pwa.Text(
                          'Consumo Médio',
                          textAlign: pwa.TextAlign.center,
                          style: pwa.TextStyle(fontSize: 12),
                        ),
                      ]),
                    ),
                    pwa.SizedBox(height: 10),
                    pwa.Text('700(kWh) / Mês',
                        style: pwa.TextStyle(
                            fontSize: 12, fontWeight: pwa.FontWeight.bold))
                  ]),
                  pwa.Column(children: <pwa.Widget>[
                    pwa.Container(
                      color: PdfColor.fromHex("#FFC000"),
                      padding: pwa.EdgeInsets.only(top: 9, left: 15, right: 15),
                      height: 30,
                      child: pwa.Text(
                        'Distribuidora',
                        textAlign: pwa.TextAlign.center,
                        style: pwa.TextStyle(fontSize: 12),
                      ),
                    ),
                    pwa.SizedBox(height: 10),
                    pwa.Text('ENERGISA',
                        style: pwa.TextStyle(
                            fontSize: 12, fontWeight: pwa.FontWeight.bold))
                  ]),
                  pwa.Column(children: <pwa.Widget>[
                    pwa.Container(
                      color: PdfColor.fromHex("#FFC000"),
                      padding: pwa.EdgeInsets.only(top: 9, left: 15, right: 15),
                      height: 30,
                      child: pwa.Text(
                        'Tipo de Cobertura',
                        textAlign: pwa.TextAlign.center,
                        style: pwa.TextStyle(fontSize: 12),
                      ),
                    ),
                    pwa.SizedBox(height: 10),
                    pwa.Text('FIBROCIMENTO',
                        style: pwa.TextStyle(
                            fontSize: 12, fontWeight: pwa.FontWeight.bold))
                  ]),
                  pwa.Column(children: <pwa.Widget>[
                    pwa.Container(
                      color: PdfColor.fromHex("#FFC000"),
                      padding: pwa.EdgeInsets.only(top: 9, left: 15, right: 15),
                      height: 30,
                      child: pwa.Text(
                        'Canal de Entrada',
                        textAlign: pwa.TextAlign.center,
                        style: pwa.TextStyle(fontSize: 12),
                      ),
                    ),
                    pwa.SizedBox(height: 10),
                    pwa.Text('TRIFASICO',
                        style: pwa.TextStyle(
                            fontSize: 12, fontWeight: pwa.FontWeight.bold))
                  ]),
                ],
              ),
              pwa.SizedBox(height: 20),
              pwa.Text(
                  "Esta é a apresentação de uma estimativa de custo e de geração de energia do sistema baseado nas informações fornecidaspelo cliente e não tem caráter orçamentário, a proposta de custo final só poderá ser realizada após uma visita técnica ao local da instalação para levantamento de todas as condicionantes que influenciam direta e indiretamente no custo e geração de energia do sistema.",
                  style: pwa.TextStyle(fontSize: 10),
                  textAlign: pwa.TextAlign.center),
              // SECOND PAGE
              pwa.SizedBox(height: 50),
              pwa.Row(
                  mainAxisAlignment: pwa.MainAxisAlignment.spaceBetween,
                  children: <pwa.Widget>[
                    pwa.Center(child: pwa.Image(image_topo_marca)),
                    pwa.Text("ANÁLISE FINANCEIRA",
                        style: pwa.TextStyle(fontWeight: pwa.FontWeight.bold))
                  ]),

              pwa.Center(
                child: pwa.Container(
                    margin: pwa.EdgeInsets.symmetric(vertical: 10),
                    child: pwa.Text("Situação Atual",
                        style: pwa.TextStyle(
                          fontSize: 23,
                          color: PdfColor.fromHex("#FFC000"),
                          fontWeight: pwa.FontWeight.bold,
                        ))),
              ),
              pwa.Center(
                child: pwa.Container(
                    margin: pwa.EdgeInsets.only(bottom: 20),
                    child: pwa.Container(
                        width: 600,
                        height: 5,
                        color: PdfColor.fromHex("#FFC000"))),
              ),
              pwa.Center(
                child: pwa.Container(
                    // margin: pwa.EdgeInsets.only(top: 40),
                    child: pwa.Container(
                        child: pwa.Text(
                            "O valor médio da sua conta de luz hoje?",
                            style: pwa.TextStyle(
                                fontSize: 16,
                                fontWeight: pwa.FontWeight.bold)))),
              ),
              pwa.SizedBox(height: 10),
              pwa.Center(
                child: pwa.Container(
                    // margin: pwa.EdgeInsets.only(top: 40),
                    child: pwa.Row(
                        mainAxisAlignment: pwa.MainAxisAlignment.center,
                        children: <pwa.Widget>[
                      pwa.SizedBox(width: 30),
                      pwa.Container(
                          child: pwa.Text("R\$ 637,00",
                              style: pwa.TextStyle(
                                  color: PdfColor.fromHex("#FFC000"),
                                  fontSize: 20,
                                  fontWeight: pwa.FontWeight.bold))),
                      pwa.Text(
                        " / por mês",
                        style: pwa.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      pwa.SizedBox(width: 30),
                    ])),
              ),

              pwa.SizedBox(height: 10),
              pwa.Center(
                child: pwa.Container(
                    // margin: pwa.EdgeInsets.only(top: 40),
                    child: pwa.Row(
                        mainAxisAlignment: pwa.MainAxisAlignment.center,
                        children: <pwa.Widget>[
                      pwa.SizedBox(width: 30),
                      pwa.Container(
                          child: pwa.Text("Consumo médio mensal:",
                              style: pwa.TextStyle(
                                fontSize: 16,
                              ))),
                      pwa.Text(
                        " 700 kWh/mês",
                        style: pwa.TextStyle(
                            fontSize: 16,
                            color: PdfColor.fromHex("#FFC000"),
                            fontWeight: pwa.FontWeight.bold),
                      ),
                      pwa.SizedBox(width: 30),
                    ])),
              ),

              pwa.Center(
                child: pwa.Container(
                    margin: pwa.EdgeInsets.only(top: 20),
                    child: pwa.Text("Economia Mensal",
                        style: pwa.TextStyle(
                          fontSize: 23,
                          color: PdfColor.fromHex("#9cd85a"),
                          fontWeight: pwa.FontWeight.bold,
                        ))),
              ),
              pwa.Center(
                child: pwa.Container(
                    margin: pwa.EdgeInsets.only(bottom: 20, top: 10),
                    child: pwa.Container(
                        width: 600,
                        height: 5,
                        color: PdfColor.fromHex("#9cd85a"))),
              ),
              pwa.Center(
                child: pwa.Container(
                    // margin: pwa.EdgeInsets.only(top: 40),
                    child: pwa.Container(
                        child: pwa.Text(
                            "Quanto você irá pagar na sua conta de luz?",
                            style: pwa.TextStyle(
                                fontSize: 16,
                                fontWeight: pwa.FontWeight.bold)))),
              ),
              pwa.SizedBox(height: 10),
              pwa.Center(
                child: pwa.Container(
                    // margin: pwa.EdgeInsets.only(top: 40),
                    child: pwa.Row(
                        mainAxisAlignment: pwa.MainAxisAlignment.center,
                        children: <pwa.Widget>[
                      pwa.SizedBox(width: 30),
                      pwa.Container(
                          child: pwa.Text("R\$ 37,00",
                              style: pwa.TextStyle(
                                  color: PdfColor.fromHex("#FFC000"),
                                  fontSize: 20,
                                  fontWeight: pwa.FontWeight.bold))),
                    ])),
              ),

              pwa.Center(
                child: pwa.Container(
                    // margin: pwa.EdgeInsets.only(top: 40),
                    child: pwa.Row(
                        mainAxisAlignment: pwa.MainAxisAlignment.center,
                        children: <pwa.Widget>[
                      pwa.SizedBox(width: 30),
                      pwa.Container(
                          child: pwa.Text("Consumo médio mensal:",
                              style: pwa.TextStyle(
                                fontSize: 16,
                              ))),
                      pwa.Text(
                        " 700 kWh/mês",
                        style: pwa.TextStyle(
                            fontSize: 16,
                            color: PdfColor.fromHex("#FFC000"),
                            fontWeight: pwa.FontWeight.bold),
                      ),
                      pwa.SizedBox(width: 30),
                    ])),
              ),
            ],
          ),
        ];
      },
    ));
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  return SingleChildScrollView(
    child: Container(
      // height: 900,
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Dados da Usina ',
                style: ubuntu16BlueBold500,
              ),
              IconButton(
                icon: Icon(
                  Icons.highlight_off,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: Navigator.of(context).pop,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Código do sistema: '),
                    TextSpan(
                        text: pw.codigo,
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: 'Marca do inversor: '),
                    TextSpan(
                        text: pw.inversor,
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: 'Marca das placas: '),
                    TextSpan(
                        text: pw.marcaDoModulo,
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: 'Numero de Placas: '),
                    TextSpan(
                        text: pw.numeroDeModulo.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: 'Área: '),
                    TextSpan(
                        text: pw.area.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: 'Potência do sistema: '),
                    TextSpan(
                        text: pw.potencia.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: 'Geração do sistema: '),
                    TextSpan(
                        text: mediaGeracaoKwp.toString() + ' KWp',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: 'Valor do sistema: '),
                    TextSpan(
                        text: pw.valor.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          SelectableText.rich(
            TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: pw.dados.replaceAll('<BR>', '\n'),
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: PrimaryButton(
                    child: Text(
                      'Gerar Proposta',
                      style: buttonLargeWhite,
                    ),
                    //onPressed:controller.loginWithGoogle,

                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                content: Builder(
                                  builder: (context) {
                                    // Get available height and width of the build area of this widget. Make a choice depending on the size.

                                    var height =
                                        MediaQuery.of(context).size.height;
                                    var width =
                                        MediaQuery.of(context).size.width;

                                    final List<Map<String, double>> valores = [
                                      {"São Paulo": 6500.50, "Barcelona": 50.20}
                                    ];

                                    final double valor =
                                        valores[0]["São Paulo"].toDouble() +
                                            valores[0]["Barcelona"].toDouble();

                                    final double parc1 =
                                        valores[0]["São Paulo"].toDouble();
                                    final double parc2 =
                                        valores[0]["Barcelona"].toDouble();

                                    return Scaffold(
                                      body: Row(
                                        children: <Widget>[
                                          Container(
                                              color: Colors.blue,
                                              width: 50,
                                              height: (parc1 / valor * 100)
                                                  .round()
                                                  .toDouble()
                                              // 197.5 * (60 / 100),
                                              ),
                                          SizedBox(width: 20),
                                          Container(
                                              color: Colors.red,
                                              width: 50,
                                              height: (parc2 / valor * 100)
                                                  .round()
                                                  .toDouble()),
                                          FlatButton(
                                              onPressed: () {
                                                print(parc1);
                                                print(parc2);
                                                print(valor);

                                                print((parc1 / valor * 100)
                                                    .round());
                                                print((parc2 / valor * 100)
                                                    .round());
                                              },
                                              child: Text('Pressione')),
                                        ],
                                      )
                                      // body: Chart(),
                                      // body: Column(
                                      //   children: <Widget>[
                                      //     // Row(
                                      //     //   mainAxisAlignment:
                                      //     //       MainAxisAlignment.spaceEvenly,
                                      //     //   children: <Widget>[
                                      //     //     Column(
                                      //     //       children: <Widget>[
                                      //     //         Container(
                                      //     //           padding: EdgeInsets.only(
                                      //     //               top: 2.5,
                                      //     //               left: 5,
                                      //     //               right: 5),
                                      //     //           color: Color(0xFFFFC000),
                                      //     //           height: 30,
                                      //     //           child: Text(
                                      //     //             'Consumo Mensal \nMédio (kWh)',
                                      //     //             textAlign:
                                      //     //                 TextAlign.center,
                                      //     //             style: TextStyle(
                                      //     //                 fontSize: 9),
                                      //     //           ),
                                      //     //         ),
                                      //     //         SizedBox(height: 5),
                                      //     //         Text('700',
                                      //     //             style: TextStyle(
                                      //     //                 fontSize: 9,
                                      //     //                 fontWeight:
                                      //     //                     FontWeight.bold))
                                      //     //       ],
                                      //     //     ),
                                      //     //     Column(
                                      //     //       children: <Widget>[
                                      //     //         Container(
                                      //     //           padding: EdgeInsets.only(
                                      //     //               top: 9,
                                      //     //               left: 5,
                                      //     //               right: 5),
                                      //     //           height: 30,
                                      //     //           color: Color(0xFFFFC000),
                                      //     //           child: Text(
                                      //     //             'Distribuidora',
                                      //     //             textAlign:
                                      //     //                 TextAlign.center,
                                      //     //             style: TextStyle(
                                      //     //                 fontSize: 9),
                                      //     //           ),
                                      //     //         ),
                                      //     //         SizedBox(height: 5),
                                      //     //         Text('ENERGISA',
                                      //     //             style: TextStyle(
                                      //     //                 fontSize: 9,
                                      //     //                 fontWeight:
                                      //     //                     FontWeight.bold))
                                      //     //       ],
                                      //     //     ),
                                      //     //     Column(
                                      //     //       children: <Widget>[
                                      //     //         Container(
                                      //     //           color: Color(0xFFFFC000),
                                      //     //           padding: EdgeInsets.only(
                                      //     //               top: 9,
                                      //     //               left: 5,
                                      //     //               right: 5),
                                      //     //           height: 30,
                                      //     //           child: Text(
                                      //     //             'Tipo de Cobertura',
                                      //     //             textAlign:
                                      //     //                 TextAlign.center,
                                      //     //             style: TextStyle(
                                      //     //                 fontSize: 9),
                                      //     //           ),
                                      //     //         ),
                                      //     //         SizedBox(height: 5),
                                      //     //         Text('FIBROCIMENTO',
                                      //     //             style: TextStyle(
                                      //     //                 fontSize: 9,
                                      //     //                 fontWeight:
                                      //     //                     FontWeight.bold))
                                      //     //       ],
                                      //     //     ),
                                      //     //     Column(
                                      //     //       children: <Widget>[
                                      //     //         Container(
                                      //     //           color: Color(0xFFFFC000),
                                      //     //           padding: EdgeInsets.only(
                                      //     //               top: 9,
                                      //     //               left: 5,
                                      //     //               right: 5),
                                      //     //           height: 30,
                                      //     //           child: Text(
                                      //     //             'Canal de Entrada',
                                      //     //             textAlign:
                                      //     //                 TextAlign.center,
                                      //     //             style: TextStyle(
                                      //     //                 fontSize: 9),
                                      //     //           ),
                                      //     //         ),
                                      //     //         SizedBox(height: 5),
                                      //     //         Text('TRIFASICO',
                                      //     //             style: TextStyle(
                                      //     //                 fontSize: 9,
                                      //     //                 fontWeight:
                                      //     //                     FontWeight.bold))
                                      //     //       ],
                                      //     //     ),
                                      //     //   ],
                                      //     // ),
                                      //     Chart(),
                                      //   ],
                                      // ),
                                      ,
                                      floatingActionButton:
                                          FloatingActionButton(
                                        onPressed: () async {
                                          writeOnPdf();
                                          await savePdf();

                                          Directory documentDirectory =
                                              await getApplicationDocumentsDirectory();

                                          String documentPath =
                                              documentDirectory.path;

                                          String fullPath =
                                              "$documentPath/example.pdf";

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PdfPreviewScreen(
                                                        path: fullPath,
                                                      )));
                                        },
                                        child: Icon(Icons.save),
                                      ),
                                    );
                                  },
                                ),
                              ));
                      //Navigator.of(context).pop();
                    }).getLarge(),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
