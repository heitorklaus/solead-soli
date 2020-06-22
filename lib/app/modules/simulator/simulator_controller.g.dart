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

  final _$_SimulatorControllerBaseActionController =
      ActionController(name: '_SimulatorControllerBase');

  @override
  dynamic showDialogController(dynamic context) {
    final _$actionInfo = _$_SimulatorControllerBaseActionController.startAction(
        name: '_SimulatorControllerBase.showDialogController');
    try {
      return super.showDialogController(context);
    } finally {
      _$_SimulatorControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
disableAdd: ${disableAdd}
    ''';
  }
}
