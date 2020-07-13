import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:login/app/modules/simulator/chart_series.dart';

class ChartChart extends StatefulWidget {
  final List<ChartSubscribers> data;

  ChartChart({Key key, this.data}) : super(key: key);

  @override
  _ChartChartState createState() => _ChartChartState();
}

class _ChartChartState extends State<ChartChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartSubscribers, String>> series = [
      charts.Series(
        id: "Subscribers",
        data: widget.data,
        domainFn: (ChartSubscribers series, _) => series.year,
        measureFn: (ChartSubscribers series, _) => series.subscribers,
        colorFn: (ChartSubscribers series, _) => series.barColor,
      )
    ];

    return Container(
      child: charts.BarChart(series, animate: true),
    );
  }
}
