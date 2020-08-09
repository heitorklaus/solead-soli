import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class ChartSubscribers {
  final String mes;
  final double geracao;
  final charts.Color barColor;

  ChartSubscribers({@required this.mes, @required this.geracao, @required this.barColor});
}
