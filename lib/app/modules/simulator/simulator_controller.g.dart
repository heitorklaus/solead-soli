// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulator_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SimulatorController on _SimulatorControllerBase, Store {
  final _$disableAddAtom = Atom(name: '_SimulatorControllerBase.disableAdd');

  @override
  bool get disableAdd {
    _$disableAddAtom.reportRead();
    return super.disableAdd;
  }

  @override
  set disableAdd(bool value) {
    _$disableAddAtom.reportWrite(value, super.disableAdd, () {
      super.disableAdd = value;
    });
  }

  final _$typePlantAtom = Atom(name: '_SimulatorControllerBase.typePlant');

  @override
  String get typePlant {
    _$typePlantAtom.reportRead();
    return super.typePlant;
  }

  @override
  set typePlant(String value) {
    _$typePlantAtom.reportWrite(value, super.typePlant, () {
      super.typePlant = value;
    });
  }

  final _$_SimulatorControllerBaseActionController =
      ActionController(name: '_SimulatorControllerBase');

  @override
  dynamic showDialogKitMenor(dynamic context) {
    final _$actionInfo = _$_SimulatorControllerBaseActionController.startAction(
        name: '_SimulatorControllerBase.showDialogKitMenor');
    try {
      return super.showDialogKitMenor(context);
    } finally {
      _$_SimulatorControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showDialogKitMaior(dynamic context) {
    final _$actionInfo = _$_SimulatorControllerBaseActionController.startAction(
        name: '_SimulatorControllerBase.showDialogKitMaior');
    try {
      return super.showDialogKitMaior(context);
    } finally {
      _$_SimulatorControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
disableAdd: ${disableAdd},
typePlant: ${typePlant}
    ''';
  }
}
