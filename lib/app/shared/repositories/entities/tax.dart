import 'package:mobx/mobx.dart';

part 'tax.g.dart';

class Tax extends _Tax with _$Tax {
  Tax({
    int id,
    String banco,
    String tax3x,
    String tax6x,
    String tax12x,
    String tax24x,
    String tax36x,
    String tax48x,
    String tax60x,
    String tax72x,
    String tax,
  }) : super(id: id, banco: banco, tax3x: tax3x, tax6x: tax6x, tax12x: tax12x, tax24x: tax24x, tax36x: tax36x, tax48x: tax48x, tax60x: tax60x, tax72x: tax72x, tax: tax);

  toJson() {
    return {
      "id": id,
      "banco": banco,
      "tax3x": tax3x,
      "tax6x": tax6x,
      "tax12x": tax12x,
      "tax24x": tax24x,
      "tax36x": tax36x,
      "tax48x": tax48x,
      "tax60x": tax60x,
      "tax72x": tax72x,
      "tax": tax,
    };
  }

  factory Tax.fromJson(Map<String, dynamic> map) {
    return Tax(
      id: map['ID'],
      banco: map['BANCO'],
      tax3x: map['TAX3X'],
      tax6x: map['TAX6X'],
      tax12x: map['TAX12X'],
      tax24x: map['TAX24X'],
      tax36x: map['TAX36X'],
      tax48x: map['TAX48X'],
      tax60x: map['TAX60X'],
      tax72x: map['TAX72X'],
      tax: map['TAX'],
    );
  }
}

abstract class _Tax with Store {
  @observable
  int id;
  String banco;
  String tax3x;
  String tax6x;
  String tax12x;
  String tax24x;
  String tax36x;
  String tax48x;
  String tax60x;
  String tax72x;
  String tax;

  _Tax({this.id, this.banco, this.tax3x, this.tax6x, this.tax12x, this.tax24x, this.tax36x, this.tax48x, this.tax60x, this.tax72x, this.tax});
}
