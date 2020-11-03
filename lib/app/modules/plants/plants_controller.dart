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
      editClienteController.text = value.cliente;
      return value;
    });
  }
}
