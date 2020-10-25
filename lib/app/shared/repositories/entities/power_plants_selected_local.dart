import 'package:mobx/mobx.dart';

part 'power_plants_selected_local.g.dart';
//    await db.execute('CREATE TABLE PLANTS_BUDGET (ID int8 NOT NULL, CPF TEXT, CEP TEXT, BAIRRO TEXT, NUMERO INT AREA TEXT, CODIGO TEXT, DADOS TEXT, INVERSOR TEXT, MARCADOMODULO TEXT, NUMERODEMODULO INT, PESO TEXT, POTENCIA TEXT, POTENCIADOMODULO TEXT, VALOR TEXT, POTENCIANOVO TEXT, CONSUMOEMREAIS TEXT, CONSUMOEMKW TEXT, CLIENTE TEXT,ENDERECO TEXT, CONSTRAINT PLANTS_BUDGET_pkey PRIMARY KEY (ID))');

class PowerPlantsSelectedLocal extends _PowerPlantsSelectedLocal with _$PowerPlantsSelectedLocal {
  PowerPlantsSelectedLocal({int id, String usuario_id, String data_cadastro, String geracao, String cpf, String cep, String bairro, String numero, String area, String codigo, String dados, String inversor, String marcaDoModulo, String numeroDeModulo, String peso, double potencia, String potenciaDoModulo, String valor, String potenciaNovo, String consumoEmReais, String consumoEmKw, String cliente, String endereco})
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

  factory PowerPlantsSelectedLocal.fromJson(Map json) {
    return PowerPlantsSelectedLocal(
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
        marcaDoModulo: json['marcaDoModulo'],
        numeroDeModulo: json['numeroDeModulo'],
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

/*
{"id":960,"geracao":null,"cpf":"011.594.445-54","cep":"78065848","bairro":"Boa Esperança","numero":"null","area":"36","codigo":"2002080011","inversor":"SGROW, REFUSOL, GROWATT SG5K-D","marcaDoModulo":"BYD","numeroDeModulo":"18","peso":"429","potencia":"6.03","potenciaDoModulo":null,"valor":"R$ 23.700,00","potenciaNovo":null,"consumoEmReais":"636.0","consumoEmKw":"698.9010989010989","cliente":"Patrícia Silveirw","endereco":"Rua 46 777","data_cadastro":"2020-10-22T16:20:18.783+0000","dados":"Peso kg\t462 57\nTipo de Telhado\tTelhado Colonial\nPotncia kWp\t603\nQuantidade de Mdulos\t18\nModelo do Inversor\tSG5KD\nQuantidade de Cabo\t40m Preto  40m Vermelho\nQuantidade de Grampo Final\t12\nQuantidade de Grampo Intermedirio\t30\nMonitoramento Incluso\tSim\nrea Necessria Aproximada m\t36\nPeso Sobre o Telhado Aproximado kg\t429\nPar Conector MC4\t2\nQuantidade de Perfil 4 2m\t8\nQuantidade de Perfil 2 1m\t2\nQuantidade de Juno de Perfil\t4\nQuantidade de Bases de Fixao\t28\nString Box\tString Box 2x2\nFabricante do Mdulo\tBYD\nPotncia do Mdulo Wp\t335","usuario":{"id":1,"name":"Heitor Klaus","username":"heitorklaus@hotmail.com","company":"Soli Energia Solar","email":"heitorklaus@hotmail.com","foto":null,"avatar":null,"roles":[{"id":1,"name":"ROLE_ADMIN"}]}}

 */
abstract class _PowerPlantsSelectedLocal with Store {
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
  String numeroDeModulo;
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
  _PowerPlantsSelectedLocal({this.id, this.data_cadastro, this.usuario_id, this.geracao, this.area, this.cpf, this.cep, this.bairro, this.numero, this.codigo, this.dados, this.inversor, this.marcaDoModulo, this.numeroDeModulo, this.peso, this.potencia, this.potenciaDoModulo, this.valor, this.potenciaNovo, this.consumoEmReais, this.consumoEmKw, this.cliente, this.endereco});
}
