// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CheckVersion on _CheckVersion, Store {
  final _$versionAtom = Atom(name: '_CheckVersion.version');

  @override
  double get version {
    _$versionAtom.reportRead();
    return super.version;
  }

  @override
  set version(double value) {
    _$versionAtom.reportWrite(value, super.version, () {
      super.version = value;
    });
  }

  @override
  String toString() {
    return '''
version: ${version}
    ''';
  }
}
