// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginBase, Store {
  final _$disableAddAtom = Atom(name: '_LoginBase.disableAdd');

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

  final _$loadingAtom = Atom(name: '_LoginBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$loginWithGoogleAsyncAction =
      AsyncAction('_LoginBase.loginWithGoogle');

  @override
  Future<dynamic> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  final _$loginApiAsyncAction = AsyncAction('_LoginBase.loginApi');

  @override
  Future<dynamic> loginApi() {
    return _$loginApiAsyncAction.run(() => super.loginApi());
  }

  @override
  String toString() {
    return '''
disableAdd: ${disableAdd},
loading: ${loading}
    ''';
  }
}
