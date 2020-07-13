import 'package:flutter/material.dart';
import 'package:login/app/modules/simulator/chart_chart.dart';
import 'package:login/app/modules/simulator/chart_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatefulWidget {
  final List<ChartSubscribers> data = [
    ChartSubscribers(
        year: "2008",
        subscribers: 10000,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
    ChartSubscribers(
        year: "2008",
        subscribers: 10500,
        barColor: charts.ColorUtil.fromDartColor(Colors.orange)),
    ChartSubscribers(
        year: "2008",
        subscribers: 10900,
        barColor: charts.ColorUtil.fromDartColor(Colors.red))
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
