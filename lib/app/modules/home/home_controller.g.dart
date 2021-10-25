// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeBase, Store {
  final _$loadingLeadsAtom = Atom(name: '_HomeBase.loadingLeads');

  @override
  String get loadingLeads {
    _$loadingLeadsAtom.reportRead();
    return super.loadingLeads;
  }

  @override
  set loadingLeads(String value) {
    _$loadingLeadsAtom.reportWrite(value, super.loadingLeads, () {
      super.loadingLeads = value;
    });
  }

  final _$loadingBudgetsAtom = Atom(name: '_HomeBase.loadingBudgets');

  @override
  String get loadingBudgets {
    _$loadingBudgetsAtom.reportRead();
    return super.loadingBudgets;
  }

  @override
  set loadingBudgets(String value) {
    _$loadingBudgetsAtom.reportWrite(value, super.loadingBudgets, () {
      super.loadingBudgets = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_HomeBase.init');

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$getLeadsAsyncAction = AsyncAction('_HomeBase.getLeads');

  @override
  Future<dynamic> getLeads() {
    return _$getLeadsAsyncAction.run(() => super.getLeads());
  }

  final _$getBudgetsAsyncAction = AsyncAction('_HomeBase.getBudgets');

  @override
  Future<dynamic> getBudgets() {
    return _$getBudgetsAsyncAction.run(() => super.getBudgets());
  }

  @override
  String toString() {
    return '''
loadingLeads: ${loadingLeads},
loadingBudgets: ${loadingBudgets}
    ''';
  }
}
