import 'package:mobx/mobx.dart';

part 'dados_kits.g.dart';

class DadosKits extends _DadosKits with _$DadosKits {
  DadosKits({
    int id,
    String area,
    String codigo,
    String dados,
    String inversor,
    String marca_do_modulo,
    int numero_de_modulo,
    String peso,
    double potencia,
    int potencia_do_modulo,
    String valor,
    double potencia_novo,
  }) : super(id: id, area: area, codigo: codigo, dados: dados, inversor: inversor, marca_do_modulo: marca_do_modulo, numero_de_modulo: numero_de_modulo, peso: peso, potencia: potencia, potencia_do_modulo: potencia_do_modulo, valor: valor, potencia_novo: potencia_novo);

  toJson() {
    return {"id": id, "area": area, "codigo": codigo, "dados": dados, "inversor": inversor, "marca_de_modulo": marca_do_modulo, "numero_de_modulo": numero_de_modulo, "peso": peso, "potencia": potencia, "potencia_do_modulo": potencia_do_modulo, "valor": valor, "potencia_novo": potencia_novo};
  }

  factory DadosKits.fromJson(Map json) {
    return DadosKits(
      id: json['id'],
      area: json['area'],
      codigo: json['codigo'],
      dados: json['dados'],
      inversor: json['inversor'],
      marca_do_modulo: json['marca_do_modulo'],
      numero_de_modulo: json['numero_de_modulo'],
      peso: json['peso'],
      potencia: json['potencia'],
      potencia_do_modulo: json['potencia_do_modulo'],
      valor: json['valor'],
      potencia_novo: json['potencia_novo'],
    );
  }
}

abstract class _DadosKits with Store {
  @observable
  int id;
  @observable
  String area;
  @observable
  String codigo;
  @observable
  String dados;
  @observable
  String inversor;
  @observable
  String marca_do_modulo;
  @observable
  int numero_de_modulo;
  @observable
  double potencia;
  @observable
  String peso;
  @observable
  int potencia_do_modulo;
  @observable
  String valor;
  @observable
  double potencia_novo;

  _DadosKits({this.id, this.area, this.codigo, this.dados, this.inversor, this.marca_do_modulo, this.numero_de_modulo, this.peso, this.potencia, this.potencia_do_modulo, this.valor, this.potencia_novo});
}
