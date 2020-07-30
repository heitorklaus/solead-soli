import 'package:flutter/material.dart';
import 'chart_chart.dart';
import 'model-chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatefulWidget {
  final List<ChartSubscribers> data = [

  ChartSubscribers(mes: "JAN", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "JAN ", geracao: 1313, barColor: charts.ColorUtil.fromDartColor(Colors.green)),
  
  ChartSubscribers(mes: "FEV", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "FEV ", geracao: 1197, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "MAR", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "MAR ", geracao: 1241, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "ABR", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "ABR ", geracao: 1076, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "MAI", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "MAI ", geracao: 937, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "JUN", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "JUN ", geracao: 848, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "AGO", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "AGO ", geracao: 911, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "SET", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "SET ", geracao: 1115, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "OUT", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "OUT ", geracao: 1266, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "NOV", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "NOV ", geracao: 1325, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "DEZ", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "DEZ ", geracao: 1437, barColor: charts.ColorUtil.fromDartColor(Colors.green)),

ChartSubscribers(mes: "MAI", geracao: 2200, barColor: charts.ColorUtil.fromDartColor(Colors.blue)), 
  ChartSubscribers(mes: "MAI ", geracao: 1148, barColor: charts.ColorUtil.fromDartColor(Colors.green)),



  ];

  Chart({Key key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChartChart(data: widget.data),
    );
  }
}
