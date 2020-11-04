import 'package:flutter/material.dart';
import 'package:login/app/modules/plants/plants_interface.dart';
import 'package:login/app/shared/repositories/entities/plants_list.dart';
import 'package:login/app/shared/repositories/entities/powerPlantsOnline.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'plants_repository.dart';

part 'plants_controller.g.dart';

class PlantsController = _PlantsControllerBase with _$PlantsController;

abstract class _PlantsControllerBase with Store {
  //final  repository;
  final IPlantsRepository repository;

  @observable
  ObservableFuture lista;

  @observable
  ObservableFuture lista2;

  @observable
  var editClienteController = TextEditingController();
  @observable
  var editCPFController = TextEditingController();
  @observable
  var editCEPController = TextEditingController();
  @observable
  var editBairroController = TextEditingController();
  @observable
  var editEnderecoController = TextEditingController();
  @observable
  var editNumeroController = TextEditingController();
  @observable
  var editInversorController = TextEditingController();
  @observable
  var editGarantiaController = TextEditingController();
  @observable
  var editPotenciaController = TextEditingController();
  @observable
  var editModulosController = TextEditingController();
  @observable
  var editQuantidadeController = TextEditingController();
  @observable
  var editGeracaoController = TextEditingController();
  @observable
  var editAreaController = TextEditingController();
  @observable
  var editCodigoController = TextEditingController();
  @observable
  var editValorController = TextEditingController();
  @observable
  var editDadosController = TextEditingController();

  _PlantsControllerBase(this.repository) {
    getAll();
    //  fillEditText();
  }

  @action
  getAll() {
    lista = repository.getAllLeads().asObservable();
  }

  @action
  fillEditText(id) {
    lista2 = repository.getLeadSelected(id).asObservable().then((value) {
      PowerPlantsOnline model = value;
      editClienteController.text = model.cliente;
      editCEPController.text = model.cep;
      editAreaController.text = model.area;
      editBairroController.text = model.bairro;
      editCPFController.text = model.cpf;
      editDadosController.text = model.dados;
      editCodigoController.text = model.codigo;
      editEnderecoController.text = model.endereco;
      editGarantiaController.text = '';
      editGeracaoController.text = model.geracao;
      editInversorController.text = model.inversor;
      editModulosController.text = model.marcaDoModulo;
      editNumeroController.text = model.numero;
      editPotenciaController.text = model.potencia;

      editQuantidadeController.text = model.numeroDeModulo.toString();
      editValorController.text = model.valor;

      return model;
    });
  }
}