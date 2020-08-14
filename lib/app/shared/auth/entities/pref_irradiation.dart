import 'package:mobx/mobx.dart';

part 'pref_irradiation.g.dart';

class PrefIrradiation extends _PrefIrradiation with _$PrefIrradiation {
  PrefIrradiation({
    int id,
    String city,
    String media,
    String price,
  }) : super(
          id: id,
          city: city,
          media: media,
          price: price,
        );

  factory PrefIrradiation.fromJson(Map<String, dynamic> json) {
    return PrefIrradiation(
      id: json['ID'] as int,
      city: json['CITY'] as String,
      media: json['DEF'] as String,
      price: json['PRICE'] as String,
    );
  }
}

abstract class _PrefIrradiation with Store {
  @observable
  int id;
  @observable
  String city;
  @observable
  String media;
  @observable
  String price;

  _PrefIrradiation({
    this.id,
    this.city,
    this.media,
    this.price,
  });
}
