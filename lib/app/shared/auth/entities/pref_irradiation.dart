import 'package:mobx/mobx.dart';

part 'pref_irradiation.g.dart';

class PrefIrradiation extends _PrefIrradiation with _$PrefIrradiation {
  PrefIrradiation(
      {int id,
      String city,
      String data})
      : super(
            id: id,
            city: city,
            data: data);


  factory PrefIrradiation.fromJson(Map<String, dynamic> json) {
    return PrefIrradiation(
      id: json['ID'] as int,
      city: json['CITY'] as String,
      data: json['DEF'] as String,
    );
  }
}

abstract class _PrefIrradiation with Store {
  @observable
  int id;
  @observable
  String city;
  @observable
  String data;
 

  _PrefIrradiation(
      {this.id,
      this.city,
      this.data});
}
