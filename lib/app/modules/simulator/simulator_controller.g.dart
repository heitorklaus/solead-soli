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

  @override
  ObservableFuture clearKW() {
    final _$future = super.clearKW();
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture calcMediaKW() {
    final _$future = super.calcMediaKW();
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture calcMediaMoney() {
    final _$future = super.calcMediaMoney();
    return ObservableFuture(_$future);
  }

  final _$showDialogKitMenorAsyncAction =
      AsyncAction('_SimulatorControllerBase.showDialogKitMenor');

  @override
  Future showDialogKitMenor(dynamic context) {
    return _$showDialogKitMenorAsyncAction
        .run(() => super.showDialogKitMenor(context));
  }

  final _$showDialogKitMaiorAsyncAction =
      AsyncAction('_SimulatorControllerBase.showDialogKitMaior');

  @override
  Future showDialogKitMaior(dynamic context) {
    return _$showDialogKitMaiorAsyncAction
        .run(() => super.showDialogKitMaior(context));
  }

  @override
  String toString() {
    return '''
disableAdd: ${disableAdd},
typePlant: ${typePlant}
    ''';
  }
}
