import 'package:mobx/mobx.dart';

part 'power_plants.g.dart';

class PowerPlants extends _PowerPlants with _$PowerPlants {
  PowerPlants({
    int id,
    String area,
    String codigo,
    String dados,
    String inversor,
    String marcaDoModulo,
    int numeroDeModulo,
    String peso,
    String potencia,
    String potenciaDoModulo,
    String valor,
    String potenciaNovo,
  }) : super(
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
    };
  }

  factory PowerPlants.fromJson(Map json) {
    return PowerPlants(
      id: json['id'],
      area: json['area'],
      codigo: json['codigo'],
      dados: json['dados'],
      inversor: json['inversor'],
      marcaDoModulo: json['marcaDoModulo'],
      numeroDeModulo: json['numeroDeModulo'],
      peso: json['peso'],
      potencia: json['potencia'],
      potenciaDoModulo: json['potenciaDoModulo'],
      valor: json['valor'],
      potenciaNovo: json['potencia_novo'],
    );
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
  String potencia;
  @observable
  String potenciaDoModulo;
  @observable
  String valor;
  @observable
  String potenciaNovo;

  _PowerPlants({
    this.id,
    this.area,
    this.codigo,
    this.dados,
    this.inversor,
    this.marcaDoModulo,
    this.numeroDeModulo,
    this.peso,
    this.potencia,
    this.potenciaDoModulo,
    this.valor,
    this.potenciaNovo,
  });
}
