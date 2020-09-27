import 'package:mobx/mobx.dart';

part 'power_plants.g.dart';

class PowerPlants extends _PowerPlants with _$PowerPlants {
  PowerPlants({int id, String area, String codigo, String dados, String inversor, String marcaDoModulo, int numeroDeModulo, String peso, double potencia, String potenciaDoModulo, String valor, String potenciaNovo, String consumoEmReais, String consumoEmKw, String cliente, String endereco})
      : super(
          id: id,
          area: area,
          codigo: codigo,
          dados: dados,
          inversor: inversor,
          marcaDoModulo: marcaDoModulo,
          numeroDeModulo: numeroDeModulo,
          peso: peso,
          potencia: potencia,
          potenciaDoModulo: potenciaDoModulo,
          valor: valor,
          potenciaNovo: potenciaNovo,
          consumoEmReais: consumoEmReais,
          consumoEmKw: consumoEmKw,
          cliente: cliente,
          endereco: endereco,
        );

  toJson() {
    return {
      "id": id,
      "area": area,
      "codigo": codigo,
      "dados": dados,
      "inversor": inversor,
      "marcaDoModulo": marcaDoModulo,
      "numeroDeModulo": numeroDeModulo,
      "peso": peso,
      "potencia": potencia,
      "potenciaDoModulo": potenciaDoModulo,
      "valor": valor,
      "potenciaNovo": potenciaNovo,
      "consumoEmReais": consumoEmReais,
      "consumoEmKw": consumoEmKw,
      "cliente": cliente,
      "endereco": endereco,
    };
  }

  factory PowerPlants.fromJson(Map json) {
    return PowerPlants(id: json['id'], area: json['area'], codigo: json['codigo'], dados: json['dados'], inversor: json['inversor'], marcaDoModulo: json['marcaDoModulo'], numeroDeModulo: json['numeroDeModulo'], peso: json['peso'], potencia: json['potencia'], potenciaDoModulo: json['potenciaDoModulo'], valor: json['valor'], consumoEmReais: json['consumoEmReais'], consumoEmKw: json['consumoEmKw'], cliente: json['cliente'], endereco: json['endereco']);
  }
}

abstract class _PowerPlants with Store {
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
  String marcaDoModulo;
  @observable
  int numeroDeModulo;
  @observable
  String peso;
  @observable
  double potencia;
  @observable
  String potenciaDoModulo;
  @observable
  String valor;
  @observable
  String potenciaNovo;
  @observable
  String consumoEmReais;

  @observable
  String consumoEmKw;

  @observable
  String cliente;
  @observable
  String endereco;
  _PowerPlants({this.id, this.area, this.codigo, this.dados, this.inversor, this.marcaDoModulo, this.numeroDeModulo, this.peso, this.potencia, this.potenciaDoModulo, this.valor, this.potenciaNovo, this.consumoEmReais, this.consumoEmKw, this.cliente, this.endereco});
}
