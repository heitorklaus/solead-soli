// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Auth on _Auth, Store {
  final _$avatarAtom = Atom(name: '_Auth.avatar');

  @override
  String get avatar {
    _$avatarAtom.context.enforceReadPolicy(_$avatarAtom);
    _$avatarAtom.reportObserved();
    return super.avatar;
  }

  @override
  set avatar(String value) {
    _$avatarAtom.context.conditionallyRunInAction(() {
      super.avatar = value;
      _$avatarAtom.reportChanged();
    }, _$avatarAtom, name: '${_$avatarAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_Auth.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$nameAtom = Atom(name: '_Auth.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$tokenTypeAtom = Atom(name: '_Auth.tokenType');

  @override
  String get tokenType {
    _$tokenTypeAtom.context.enforceReadPolicy(_$tokenTypeAtom);
    _$tokenTypeAtom.reportObserved();
    return super.tokenType;
  }

  @override
  set tokenType(String value) {
    _$tokenTypeAtom.context.conditionallyRunInAction(() {
      super.tokenType = value;
      _$tokenTypeAtom.reportChanged();
    }, _$tokenTypeAtom, name: '${_$tokenTypeAtom.name}_set');
  }

  final _$accessTokenAtom = Atom(name: '_Auth.accessToken');

  @override
  String get accessToken {
    _$accessTokenAtom.context.enforceReadPolicy(_$accessTokenAtom);
    _$accessTokenAtom.reportObserved();
    return super.accessToken;
  }

  @override
  set accessToken(String value) {
    _$accessTokenAtom.context.conditionallyRunInAction(() {
      super.accessToken = value;
      _$accessTokenAtom.reportChanged();
    }, _$accessTokenAtom, name: '${_$accessTokenAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_Auth.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$roleAtom = Atom(name: '_Auth.role');

  @override
  String get role {
    _$roleAtom.context.enforceReadPolicy(_$roleAtom);
    _$roleAtom.reportObserved();
    return super.role;
  }

  @override
  set role(String value) {
    _$roleAtom.context.conditionallyRunInAction(() {
      super.role = value;
      _$roleAtom.reportChanged();
    }, _$roleAtom, name: '${_$roleAtom.name}_set');
  }

  final _$usernameAtom = Atom(name: '_Auth.username');

  @override
  String get username {
    _$usernameAtom.context.enforceReadPolicy(_$usernameAtom);
    _$usernameAtom.reportObserved();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.context.conditionallyRunInAction(() {
      super.username = value;
      _$usernameAtom.reportChanged();
    }, _$usernameAtom, name: '${_$usernameAtom.name}_set');
  }
}
