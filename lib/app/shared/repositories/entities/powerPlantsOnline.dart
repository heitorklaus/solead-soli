import 'package:mobx/mobx.dart';
import 'usuario.dart';

part 'powerPlantsOnline.g.dart';
//    await db.execute('CREATE TABLE PLANTS_BUDGET (ID int8 NOT NULL, CPF TEXT, CEP TEXT, BAIRRO TEXT, NUMERO INT AREA TEXT, CODIGO TEXT, DADOS TEXT, INVERSOR TEXT, MARCADOMODULO TEXT, NUMERODEMODULO INT, PESO TEXT, POTENCIA TEXT, POTENCIADOMODULO TEXT, VALOR TEXT, POTENCIANOVO TEXT, CONSUMOEMREAIS TEXT, CONSUMOEMKW TEXT, CLIENTE TEXT,ENDERECO TEXT, CONSTRAINT PLANTS_BUDGET_pkey PRIMARY KEY (ID))');

class PowerPlantsOnline extends _PowerPlantsOnline with _$PowerPlantsOnline {
  PowerPlantsOnline({int id, String usuario_id, String data_cadastroUnused, String geracao, String cpf, String cep, String bairro, String numero, String area, String codigo, String dados, String inversor, String marcaDoModulo, int numeroDeModulo, String peso, String potencia, String potenciaDoModulo, String valor, String potenciaNovo, String consumoEmReais, String consumoEmKw, String cliente, String endereco, Usuario usuario})
      : super(id: id, data_cadastroUnused: data_cadastroUnused, usuario_id: usuario_id, geracao: geracao, cpf: cpf, cep: cep, bairro: bairro, numero: numero, area: area, codigo: codigo, dados: dados, inversor: inversor, marcaDoModulo: marcaDoModulo, numeroDeModulo: numeroDeModulo, peso: peso, potencia: potencia, potenciaDoModulo: potenciaDoModulo, valor: valor, potenciaNovo: potenciaNovo, consumoEmReais: consumoEmReais, consumoEmKw: consumoEmKw, cliente: cliente, endereco: endereco, usuario: usuario);

  toJson() {
    return {
      "id": id,
      "data_cadastroUnused": data_cadastroUnused,
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

  factory PowerPlantsOnline.fromJson(Map json) {
    return PowerPlantsOnline(
        // id: json['id'],
        usuario_id: json['usuario_id'],
        data_cadastroUnused: json['data_cadastro'],
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
        potencia: '${json['potencia']}',
        potenciaDoModulo: json['potenciaDoModulo'],
        valor: json['valor'],
        consumoEmReais: json['consumoemreais'],
        consumoEmKw: json['consumoemkw'],
        cliente: json['cliente'],
        endereco: json['endereco'],
        usuario: Usuario.fromJson(json['usuario']));
  }
}

abstract class _PowerPlantsOnline with Store {
  @observable
  int id;
  @observable
  String data_cadastroUnused;
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
  String potencia;
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
  @observable
  Usuario usuario;
  _PowerPlantsOnline({this.id, this.data_cadastroUnused, this.usuario_id, this.geracao, this.area, this.cpf, this.cep, this.bairro, this.numero, this.codigo, this.dados, this.inversor, this.marcaDoModulo, this.numeroDeModulo, this.peso, this.potencia, this.potenciaDoModulo, this.valor, this.potenciaNovo, this.consumoEmReais, this.consumoEmKw, this.cliente, this.endereco, this.usuario});
}
