import 'package:mobx/mobx.dart';

part 'cities_irradiation_month.g.dart';

class CitiesData extends _CitiesData with _$CitiesData {
  CitiesData({int id, String inclinacao, String jan, String fev, String mar, String abr, String mai, String jun, String jul, String ago, String sep, String out, String nov, String dez, String media})
      : super(
          id: id,
          inclinacao: inclinacao,
          jan: jan,
          fev: fev,
          mar: mar,
          abr: abr,
          mai: mai,
          jun: jun,
          jul: jul,
          ago: ago,
          sep: sep,
          out: out,
          nov: nov,
          dez: dez,
          media: media,
        );

  toJson() {
    return {
      "id": id,
      "inclinacao": inclinacao,
      "jan": jan,
      "fev": fev,
      "mar": mar,
      "abr": abr,
      "mai": mai,
      "jun": jun,
      "jul": jul,
      "ago": ago,
      "sep": sep,
      "out": out,
      "nov": nov,
      "dez": dez,
      "media": media,
    };
  }

  factory CitiesData.fromJson(Map json) {
    return CitiesData(
      id: json['ID'],
      inclinacao: json['INCLINACAO'],
      jan: json['JAN'],
      fev: json['FEV'],
      mar: json['MAR'],
      abr: json['ABR'],
      mai: json['MAI'],
      jun: json['JUN'],
      jul: json['JUL'],
      ago: json['AGO'],
      sep: json['SEP'],
      out: json['OUT'],
      nov: json['NOV'],
      dez: json['DEZ'],
      media: json['MEDIA'],
    );
  }
}

abstract class _CitiesData with Store {
  @observable
  int id;

  @observable
  String inclinacao;

  @observable
  String jan;

  @observable
  String fev;

  @observable
  String mar;

  @observable
  String abr;

  @observable
  String mai;

  @observable
  String jun;

  @observable
  String jul;

  @observable
  String ago;

  @observable
  String sep;

  @observable
  String out;

  @observable
  String nov;

  @observable
  String dez;

  @observable
  String media;

  _CitiesData({this.id, this.inclinacao, this.jan, this.fev, this.mar, this.abr, this.mai, this.jun, this.jul, this.ago, this.sep, this.out, this.nov, this.dez, this.media});
}
