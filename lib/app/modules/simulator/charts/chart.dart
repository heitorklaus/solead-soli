import 'package:flutter/material.dart';
import 'chart_chart.dart';
import 'model-chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatefulWidget {
  final meses;
  final consumo;

  Chart({this.meses, this.consumo});

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  get meses => widget.meses;
  get consumo => widget.consumo;

  @override
  List<ChartSubscribers> data;
  void initState() {
    // TODO: implement initState
    super.initState();

    data = [
      ChartSubscribers(mes: "JAN", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "JAN ", geracao: meses[0]["JAN"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "FEV", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "FEV ", geracao: meses[1]["FEV"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "MAR", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "MAR ", geracao: meses[2]["MAR"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "ABR", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "ABR ", geracao: meses[3]["ABR"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "MAI", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "MAI ", geracao: meses[4]["MAI"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "JUN", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "JUN ", geracao: meses[5]["JUN"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "JUL", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "JUL ", geracao: meses[6]["JUL"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "AGO", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "AGO ", geracao: meses[7]["AGO"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "SET", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "SET ", geracao: meses[8]["SET"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "OUT", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "OUT ", geracao: meses[9]["OUT"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "NOV", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "NOV ", geracao: meses[10]["NOV"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartSubscribers(mes: "DEZ", geracao: consumo, barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartSubscribers(mes: "DEZ ", geracao: meses[11]["DEZ"], barColor: charts.ColorUtil.fromDartColor(Colors.green)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChartChart(data: this.data),
    );
  }
}
