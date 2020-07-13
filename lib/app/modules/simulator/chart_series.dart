import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class ChartSubscribers {
  final String year;
  final int subscribers;
  final charts.Color barColor;

  ChartSubscribers(
      {@required this.year,
      @required this.subscribers,
      @required this.barColor});
}
