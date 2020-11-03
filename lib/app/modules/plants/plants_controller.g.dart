// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plants_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlantsController on _PlantsControllerBase, Store {
  final _$listaAtom = Atom(name: '_PlantsControllerBase.lista');

  @override
  ObservableFuture<dynamic> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableFuture<dynamic> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  final _$lista2Atom = Atom(name: '_PlantsControllerBase.lista2');

  @override
  ObservableFuture<dynamic> get lista2 {
    _$lista2Atom.reportRead();
    return super.lista2;
  }

  @override
  set lista2(ObservableFuture<dynamic> value) {
    _$lista2Atom.reportWrite(value, super.lista2, () {
      super.lista2 = value;
    });
  }

  final _$editClienteControllerAtom =
      Atom(name: '_PlantsControllerBase.editClienteController');

  @override
  TextEditingController get editClienteController {
    _$editClienteControllerAtom.reportRead();
    return super.editClienteController;
  }

  @override
  set editClienteController(TextEditingController value) {
    _$editClienteControllerAtom.reportWrite(value, super.editClienteController,
        () {
      super.editClienteController = value;
    });
  }

  final _$_PlantsControllerBaseActionController =
      ActionController(name: '_PlantsControllerBase');

  @override
  dynamic getAll() {
    final _$actionInfo = _$_PlantsControllerBaseActionController.startAction(
        name: '_PlantsControllerBase.getAll');
    try {
      return super.getAll();
    } finally {
      _$_PlantsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic fillEditText(dynamic id) {
    final _$actionInfo = _$_PlantsControllerBaseActionController.startAction(
        name: '_PlantsControllerBase.fillEditText');
    try {
      return super.fillEditText(id);
    } finally {
      _$_PlantsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lista: ${lista},
lista2: ${lista2},
editClienteController: ${editClienteController}
    ''';
  }
}
