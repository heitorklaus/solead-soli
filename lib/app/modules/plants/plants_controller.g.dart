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
  String toString() {
    return '''
lista: ${lista}
    ''';
  }
}
