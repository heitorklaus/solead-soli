import 'package:login/app/modules/plants/plants_interface.dart';
import 'package:login/app/shared/repositories/entities/plants_list.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../plants_repository.dart';

part 'plants_controller.g.dart';

class PlantsController = _PlantsControllerBase with _$PlantsController;

abstract class _PlantsControllerBase with Store {
  //final  repository;
  final IPlantsRepository repository;

  @observable
  ObservableFuture lista;

  _PlantsControllerBase(this.repository) {
    getAll();
  }

  @action
  getAll() {
    lista = repository.fetchPost().asObservable();
  }
}
