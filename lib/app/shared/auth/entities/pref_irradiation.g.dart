// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pref_irradiation.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrefIrradiation on _PrefIrradiation, Store {
  final _$idAtom = Atom(name: '_PrefIrradiation.id');

  @override
  int get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$cityAtom = Atom(name: '_PrefIrradiation.city');

  @override
  String get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(String value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  final _$mediaAtom = Atom(name: '_PrefIrradiation.media');

  @override
  String get media {
    _$mediaAtom.reportRead();
    return super.media;
  }

  @override
  set media(String value) {
    _$mediaAtom.reportWrite(value, super.media, () {
      super.media = value;
    });
  }

  final _$priceAtom = Atom(name: '_PrefIrradiation.price');

  @override
  String get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(String value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  @override
  String toString() {
    return '''
id: ${id},
city: ${city},
media: ${media},
price: ${price}
    ''';
  }
}
