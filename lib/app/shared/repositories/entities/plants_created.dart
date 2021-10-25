import 'package:mobx/mobx.dart';

part 'plants_created.g.dart';
/*

area:"48"
cliente:null
codigo:"2002080015"
consumoEmKw:"999.0"
consumoEmReais:"1097.8021978021977"
dados:""Peso (kg)	611,16
Tipo de Telhado	Telhado Colonial
Potência (kWp)	8.04
Quantidade de Módulos	24
Modelo do Inversor	SG8K3-D
Quant…"
endereco:null
id:12
inversor:"SUNGROW SG8K3-D"
marcaDoModulo:"BYD"
numeroDeModulo:24
peso:"574"
potencia:8.04
potenciaDoModulo:"335"
potenciaNovo:"R$ 29.960,00"
valor:"R$ 29.960,00"
*/

class PlantsCreated extends _PlantsCreated with _$PlantsCreated {
  PlantsCreated({String area, String cliente, String codigo, String consumoEmKw, String consumoEmReais, String dados, String endereco, int id, String inversor, String marcaDoModulo, int numeroDeModulo, String peso, double potencia, String potenciaDoModulo, String potenciaNovo, String valor}) : super(area: area, cliente: cliente, codigo: codigo, consumoEmKw: consumoEmKw, consumoEmReais: consumoEmReais, dados: dados, endereco: endereco, id: id, inversor: inversor, marcaDoModulo: marcaDoModulo, numeroDeModulo: numeroDeModulo, peso: peso, potencia: potencia, potenciaDoModulo: potenciaDoModulo, potenciaNovo: potenciaNovo, valor: valor);

  toJson() {
    return {"area": area, "cliente": cliente, "codigo": codigo, "consumoEmKw": consumoEmKw, "consumoEmReais": consumoEmReais, "dados": dados, "endereco": endereco, "id": id, "inversor": inversor, "marcaDoModulo": marcaDoModulo, "numeroDeModulo": numeroDeModulo, "peso": peso, "potencia": potencia, "potenciaDoModulo": potenciaDoModulo, "potenciaNovo": potenciaNovo, "valor": valor};
  }

  factory PlantsCreated.fromJson(Map json) {
    return PlantsCreated(area: json['area'], cliente: json['cliente'], codigo: json['codigo'], consumoEmKw: json['consumoEmKw'], consumoEmReais: json['consumoEmReais'], dados: json['dados'], endereco: json['endereco'], id: json['id'], inversor: json['inversor'], marcaDoModulo: json['marcaDoModulo'], numeroDeModulo: json['numeroDeModulo'], peso: json['peso'], potencia: json['potencia'], potenciaDoModulo: json['potenciaDoModulo'], potenciaNovo: json['potenciaNovo'], valor: json['valor']);
  }
}

abstract class _PlantsCreated with Store {
  @observable
  String area;
  @observable
  String cliente;
  @observable
  String codigo;
  @observable
  String consumoEmKw;
  @observable
  String consumoEmReais;
  @observable
  String dados;
  @observable
  String endereco;
  @observable
  int id;
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
  String potenciaNovo;
  @observable
  String valor;

  _PlantsCreated({this.area, this.cliente, this.codigo, this.consumoEmKw, this.consumoEmReais, this.dados, this.endereco, this.id, this.inversor, this.marcaDoModulo, this.numeroDeModulo, this.peso, this.potencia, this.potenciaDoModulo, this.potenciaNovo, this.valor});
}
