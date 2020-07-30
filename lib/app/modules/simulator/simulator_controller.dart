import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/power_plants.dart';
import 'package:login/app/shared/styles/main_style.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:mobx/mobx.dart';

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

      final irradiation = await AuthRepository().getCitiesPreferences('irradiation');

      final result = (int.parse(mediaKW.text).toInt() / 30) / double.parse(irradiation.replaceAll(',', '.')).toDouble() / .75;

      potencia.text = result.toStringAsFixed(2);

      var potenciaProximaMaior = await ProposalStringsDao().findPotenciaKit(result.toStringAsFixed(2));
      var potenciaProximaMenor = await ProposalStringsDao().findPotenciaKitMenor(result.toStringAsFixed(2));

      //  print(valor.id.toString());
      //  print(valor.potencia);

      potenciaIndicada1.text = potenciaProximaMenor.potencia;
      valorKit1.text = potenciaProximaMenor.valor;
      potenciaIndicada2.text = potenciaProximaMaior.potencia;
      valorKit2.text = potenciaProximaMaior.valor;

      final mediaNova = double.parse((mediaKW.text));
      powerPlantsMenor.consumoEmReais = (mediaNova / 0.91).toString();
      powerPlantsMaior.consumoEmReais = (mediaNova / 0.91).toString();

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

      final irradiation = await AuthRepository().getCitiesPreferences('irradiation');
      final tarifa = await AuthRepository().getCitiesPreferences('price');

      final result = (int.parse(mediaMoney.text).toInt() * double.parse(tarifa.replaceAll(',', '.')).toDouble() / (30)) / double.parse(irradiation.replaceAll(',', '.')).toDouble() / .75;

      potencia.text = result.toStringAsFixed(2);

      var potenciaProximaMaior = await ProposalStringsDao().findPotenciaKit(result.toStringAsFixed(2));
      var potenciaProximaMenor = await ProposalStringsDao().findPotenciaKitMenor(result.toStringAsFixed(2));

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
      powerPlantsMenor.potenciaDoModulo = potenciaProximaMenor.potencia_do_modulo.toString();
      powerPlantsMenor.potenciaNovo = powerPlantsMenor.valor = potenciaProximaMenor.valor;
      powerPlantsMenor.dados = potenciaProximaMenor.dados;

      final mediaNova = double.parse((mediaMoney.text));

      powerPlantsMenor.consumoEmReais = (mediaNova).toString();
      powerPlantsMaior.consumoEmReais = (mediaNova).toString();

      final mediaNovaKw = double.parse((mediaMoney.text));

      powerPlantsMenor.consumoEmKw = (mediaNovaKw * 0.91).toString();
      powerPlantsMaior.consumoEmKw = (mediaNovaKw * 0.91).toString();

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
    // RETORNA A GERACAO MES A MES
    final valor = await Prefs.getStringList("CITIES");

    var jan = double.parse(valor[1].split(":")[1]);
    var janValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(1) * jan * .75;

    var fev = double.parse(valor[2].split(":")[1]);
    var fevValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(2) * fev * .75;

    var mar = double.parse(valor[3].split(":")[1]);
    var marValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(3) * mar * .75;

    var abr = double.parse(valor[4].split(":")[1]);
    var abrValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(4) * abr * .75;

    var mai = double.parse(valor[5].split(":")[1]);
    var maiValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(5) * mai * .75;

    var jun = double.parse(valor[6].split(":")[1]);
    var junValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(6) * jun * .75;

    var jul = double.parse(valor[7].split(":")[1]);
    var julValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(7) * jul * .75;

    var ago = double.parse(valor[8].split(":")[1]);
    var agoValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(8) * ago * .75;

    var sep = double.parse(valor[9].split(":")[1]);
    var sepValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(9) * sep * .75;

    var out = double.parse(valor[10].split(":")[1]);
    var outValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(10) * out * .75;

    var nov = double.parse(valor[11].split(":")[1]);
    var novValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(11) * nov * .75;

    var dez = double.parse(valor[12].split(":")[1]);
    var dezValue = double.parse(powerPlantsMenor.potencia) * returnDaysOfMonth(12) * dez * .75;

    final mediaGeracaoKwpMenor = (janValue + fevValue + marValue + abrValue + maiValue + junValue + julValue + agoValue + sepValue + outValue + novValue + dezValue) / 12;

    print('[ MEDIA MENOR ] ' + mediaGeracaoKwpMenor.toString());

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  return SingleChildScrollView(
                    child: buildDialog(context, powerPlantsMenor, mediaGeracaoKwpMenor.round()),
                  );
                },
              ),
            ));
  }

  @action
  showDialogKitMaior(context) async {
    final valor = await Prefs.getStringList("CITIES");

    var jan = double.parse(valor[1].split(":")[1]);
    var janValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(1) * jan * .75;

    var fev = double.parse(valor[2].split(":")[1]);
    var fevValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(2) * fev * .75;

    var mar = double.parse(valor[3].split(":")[1]);
    var marValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(3) * mar * .75;

    var abr = double.parse(valor[4].split(":")[1]);
    var abrValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(4) * abr * .75;

    var mai = double.parse(valor[5].split(":")[1]);
    var maiValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(5) * mai * .75;

    var jun = double.parse(valor[6].split(":")[1]);
    var junValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(6) * jun * .75;

    var jul = double.parse(valor[7].split(":")[1]);
    var julValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(7) * jul * .75;

    var ago = double.parse(valor[8].split(":")[1]);
    var agoValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(8) * ago * .75;

    var sep = double.parse(valor[9].split(":")[1]);
    var sepValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(9) * sep * .75;

    var out = double.parse(valor[10].split(":")[1]);
    var outValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(10) * out * .75;

    var nov = double.parse(valor[11].split(":")[1]);
    var novValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(11) * nov * .75;

    var dez = double.parse(valor[12].split(":")[1]);
    var dezValue = double.parse(powerPlantsMaior.potencia) * returnDaysOfMonth(12) * dez * .75;

    final mediaGeracaoKwpMaior = (janValue + fevValue + marValue + abrValue + maiValue + junValue + julValue + agoValue + sepValue + outValue + novValue + dezValue) / 12;

    print('[ MEDIA MAIOR ] ' + mediaGeracaoKwpMaior.toString());

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SingleChildScrollView(
                    child: buildDialog(context, powerPlantsMaior, mediaGeracaoKwpMaior.round()),
                  );
                },
              ),
            ));
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
Widget buildDialog(context, pw, mediaGeracaoKwp) {
  final pdf = pwa.Document();

  final List<Map<String, double>> valorEconomiaMensal = [
    {"valorPaga": double.parse(pw.consumoEmReais), "valorIraPagar": 91.00, "tarifaCidade": 0.91}
  ];

  final double valorEconomiaMensalTotal = valorEconomiaMensal[0]["valorPaga"].toDouble() + valorEconomiaMensal[0]["valorIraPagar"].toDouble();

  final double parc2 = (valorEconomiaMensal[0]["valorIraPagar"].toDouble() / valorEconomiaMensalTotal * 100);

  final val = new NumberFormat("#,##0.00", "pt_BR");

  final double valor_paga_ano = (valorEconomiaMensal[0]["valorPaga"].toDouble()) * 12.toDouble();
  final double valor_ira_pagar_ano = (valorEconomiaMensal[0]["valorIraPagar"].toDouble()) * 12.toDouble();

// Economia em MES
  final valQuantoPagaBR = val.format(valorEconomiaMensal[0]["valorPaga"].toDouble());

  final valQuantoIraPagarBR = val.format(valorEconomiaMensal[0]["valorIraPagar"].toDouble());

  // economia 25 vanos
  final double economia_25_anos_paga = (valor_paga_ano - valor_ira_pagar_ano) * 111.346;

  final double economia_25_anos_pagara = ((91 * 12 * 25).toDouble() * 3.82);

  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();

  Future<Uint8List> runChart2() async {
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return runChart2();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void runChart1(String nameChart1) async {
    var pngBytes = await runChart2();
    var bs64 = base64Encode(pngBytes);
    print(pngBytes);
    print(bs64);

    Uint8List bytes = base64.decode(bs64);
    String dir = (await getTemporaryDirectory()).path;
    String fullPath = '$dir/img/$nameChart1.png';
    print("local file full path ${fullPath}");
    File file = File(fullPath);
    await file.writeAsBytes(bytes);
    print(file.path);
  }

  // GRAFICO 2

  Future<Uint8List> runChart4() async {
    RenderRepaintBoundary boundary = globalKey2.currentContext.findRenderObject();
    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return runChart4();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void runChart3(String nameChart2) async {
    var pngBytes = await runChart4();
    var bs64 = base64Encode(pngBytes);
    print(pngBytes);
    print(bs64);

    Uint8List bytes = base64.decode(bs64);
    String dir = (await getTemporaryDirectory()).path;
    String fullPath = '$dir/img/$nameChart2.png';
    print("local file full path ${fullPath}");
    File file = File(fullPath);
    await file.writeAsBytes(bytes);
    print(file.path);
  }

  writeOnPdf(String nameFile) async {
    // GENERATE CHART GRAPH
    runChart1("grafico-1");
    runChart3("grafico-2");
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    returnImg(img) {
      final image = PdfImage.file(
        pdf.document,
        bytes: File('$tempPath/img/$img.png').readAsBytesSync(),
      );

      return image;
    }

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


    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/$nameFile.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  /////////////////////// PDF //////////////////////////////////////

// DIALOG DE VISUALIZACAO DA USINA

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
                    TextSpan(text: pw.codigo, style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: pw.inversor, style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: pw.marcaDoModulo, style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: pw.numeroDeModulo.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: pw.area.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: pw.potencia.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: mediaGeracaoKwp.toString() + ' KWp', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    TextSpan(text: pw.valor.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
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
                TextSpan(text: pw.dados.replaceAll('<BR>', '\n'), style: TextStyle(fontSize: 12)),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                content: Builder(
                                  builder: (context) {
                                    // Get available height and width of the build area of this widget. Make a choice depending on the size.

                                    return Scaffold(
                                      body: Stack(
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
                                                            color: Colors.red,
                                                            child: Chart(),
                                                            height: 700,
                                                            width: 1500,
                                                          ),
                                                        ),
                                                        RepaintBoundary(
                                                          key: globalKey2,
                                                          child: Container(
                                                            color: Colors.blue,
                                                            child: Text("pt_BR"),
                                                            height: 700,
                                                            width: 1500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                            // Container(
                                            //   width: 5300,
                                            //   height: 5300,
                                            //    color: Colors.white,
                                            // ),
                                        ],
                                      ),
                                      floatingActionButton: FloatingActionButton(
                                        onPressed: () async {
                                          await writeOnPdf("projeto-solar");

                                          Directory documentDirectory = await getApplicationDocumentsDirectory();

                                          String documentPath = documentDirectory.path;

                                          String fullPath = "$documentPath/projeto-solar.pdf";

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => PdfPreviewScreen(
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
