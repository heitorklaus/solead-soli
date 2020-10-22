import 'package:mobx/mobx.dart';

part 'power_plants.g.dart';
//    await db.execute('CREATE TABLE PLANTS_BUDGET (ID int8 NOT NULL, CPF TEXT, CEP TEXT, BAIRRO TEXT, NUMERO INT AREA TEXT, CODIGO TEXT, DADOS TEXT, INVERSOR TEXT, MARCADOMODULO TEXT, NUMERODEMODULO INT, PESO TEXT, POTENCIA TEXT, POTENCIADOMODULO TEXT, VALOR TEXT, POTENCIANOVO TEXT, CONSUMOEMREAIS TEXT, CONSUMOEMKW TEXT, CLIENTE TEXT,ENDERECO TEXT, CONSTRAINT PLANTS_BUDGET_pkey PRIMARY KEY (ID))');

class PowerPlants extends _PowerPlants with _$PowerPlants {
  PowerPlants({int id, String usuario_id, String data_cadastro, String geracao, String cpf, String cep, String bairro, String numero, String area, String codigo, String dados, String inversor, String marcaDoModulo, int numeroDeModulo, String peso, double potencia, String potenciaDoModulo, String valor, String potenciaNovo, String consumoEmReais, String consumoEmKw, String cliente, String endereco})
      : super(
          id: id,
          data_cadastro: data_cadastro,
          usuario_id: usuario_id,
          geracao: geracao,
          cpf: cpf,
          cep: cep,
          bairro: bairro,
          numero: numero,
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
      "usuario_id": usuario_id,
      "geracao": geracao,
      "cpf": cpf,
      "cep": cep,
      "bairro": bairro,
      "numero": numero,
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
    return PowerPlants(
        // id: json['id'],
        usuario_id: json['usuario_id'],
        data_cadastro: json['data_cadastro'],
        geracao: json['geracao'],
        area: json['area'],
        cpf: json['cpf'],
        cep: json['cep'],
        bairro: json['bairro'],
        numero: '${json['numero']}',
        codigo: json['codigo'],
        dados: json['dados'],
        inversor: json['inversor'],
        marcaDoModulo: json['marca_do_modulo'],
        numeroDeModulo: json['numero_de_modulo'],
        peso: json['peso'],
        potencia: json['potencia'],
        potenciaDoModulo: json['potenciaDoModulo'],
        valor: json['valor'],
        consumoEmReais: json['consumoemreais'],
        consumoEmKw: json['consumoemkw'],
        cliente: json['cliente'],
        endereco: json['endereco']);
  }
}

abstract class _PowerPlants with Store {
  @observable
  int id;
  @observable
  String data_cadastro;
  @observable
  String usuario_id;
  @observable
  String geracao;
  @observable
  String area;
  @observable
  String cpf;
  @observable
  String cep;
  @observable
  String bairro;
  @observable
  String numero;
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
  _PowerPlants({this.id, this.data_cadastro, this.usuario_id, this.geracao, this.area, this.cpf, this.cep, this.bairro, this.numero, this.codigo, this.dados, this.inversor, this.marcaDoModulo, this.numeroDeModulo, this.peso, this.potencia, this.potenciaDoModulo, this.valor, this.potenciaNovo, this.consumoEmReais, this.consumoEmKw, this.cliente, this.endereco});
}
