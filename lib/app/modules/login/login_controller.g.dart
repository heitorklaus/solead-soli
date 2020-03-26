// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginBase, Store {
  final _$disableAddAtom = Atom(name: '_LoginBase.disableAdd');

  @override
  bool get disableAdd {
    _$disableAddAtom.context.enforceReadPolicy(_$disableAddAtom);
    _$disableAddAtom.reportObserved();
    return super.disableAdd;
  }

  @override
  set disableAdd(bool value) {
    _$disableAddAtom.context.conditionallyRunInAction(() {
      super.disableAdd = value;
      _$disableAddAtom.reportChanged();
    }, _$disableAddAtom, name: '${_$disableAddAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_LoginBase.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$loginWithGoogleAsyncAction = AsyncAction('loginWithGoogle');

  @override
  Future<dynamic> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  final _$loginApiAsyncAction = AsyncAction('loginApi');

  @override
  Future<dynamic> loginApi() {
    return _$loginApiAsyncAction.run(() => super.loginApi());
  }
}
