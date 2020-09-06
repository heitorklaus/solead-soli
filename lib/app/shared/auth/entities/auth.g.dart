// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Auth on _Auth, Store {
  final _$avatarAtom = Atom(name: '_Auth.avatar');

  @override
  String get avatar {
    _$avatarAtom.reportRead();
    return super.avatar;
  }

  @override
  set avatar(String value) {
    _$avatarAtom.reportWrite(value, super.avatar, () {
      super.avatar = value;
    });
  }

  final _$emailAtom = Atom(name: '_Auth.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$nameAtom = Atom(name: '_Auth.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$tokenTypeAtom = Atom(name: '_Auth.tokenType');

  @override
  String get tokenType {
    _$tokenTypeAtom.reportRead();
    return super.tokenType;
  }

  @override
  set tokenType(String value) {
    _$tokenTypeAtom.reportWrite(value, super.tokenType, () {
      super.tokenType = value;
    });
  }

  final _$accessTokenAtom = Atom(name: '_Auth.accessToken');

  @override
  String get accessToken {
    _$accessTokenAtom.reportRead();
    return super.accessToken;
  }

  @override
  set accessToken(String value) {
    _$accessTokenAtom.reportWrite(value, super.accessToken, () {
      super.accessToken = value;
    });
  }

  final _$passwordAtom = Atom(name: '_Auth.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$rolesAtom = Atom(name: '_Auth.roles');

  @override
  dynamic get roles {
    _$rolesAtom.reportRead();
    return super.roles;
  }

  @override
  set roles(dynamic value) {
    _$rolesAtom.reportWrite(value, super.roles, () {
      super.roles = value;
    });
  }

  final _$usernameAtom = Atom(name: '_Auth.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  @override
  String toString() {
    return '''
avatar: ${avatar},
email: ${email},
name: ${name},
tokenType: ${tokenType},
accessToken: ${accessToken},
password: ${password},
roles: ${roles},
username: ${username}
    ''';
  }
}
