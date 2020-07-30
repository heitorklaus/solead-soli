import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'model-chart.dart';

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
        domainFn: (ChartSubscribers series, _) => series.mes,
        measureFn: (ChartSubscribers series, _) => series.geracao,
        colorFn: (ChartSubscribers series, _) => series.barColor,
      )
    ];

    return Container(
      height: 400,
      width: 200,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "World of Warcraft Subscribers by Year",
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
