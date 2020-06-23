import 'dart:async';

import 'package:login/app/shared/repositories/entities/dados_kits.dart';
import 'package:login/app/shared/repositories/entities/proposal_strings.dart';
import 'package:login/app/shared/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
class ProposalStringsDao {
  Future<Database> get db => DatabaseHelper.getInstance().db;

  Future<int> save(ProposalStrings strings) async {
    var dbClient = await db;
    var id = await dbClient.insert("PROPOSAL_STRINGS", strings.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<ProposalStrings>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from PROPOSAL_STRINGS');

    final strings = list
        .map<ProposalStrings>((json) => ProposalStrings.fromJson(json))
        .toList();

    return strings;
  }

  Future findPotenciaKitMenor(tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery(
        "select * from tb_dados_kits where potencia_novo < '$tipo' order by potencia_novo DESC limit 1");

    if (list.length > 0) {
      final valor = new DadosKits.fromJson(list.first);

      return valor;
    }

    return null;
  }

  Future findPotenciaKit(tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery(
        "select * from tb_dados_kits where potencia_novo > '$tipo' order by potencia_novo asc limit 1");

    if (list.length > 0) {
      final valor = new DadosKits.fromJson(list.first);


      print("RETORNO AQUI: "+ valor.id.toString());

      return valor;
    }

    return null;
  }

  Future<ProposalStrings> findById(int id) async {
    var dbClient = await db;
    final list = await dbClient
        .rawQuery('select * from PROPOSAL_STRINGS where id = ?', [id]);

    if (list.length > 0) {
      return new ProposalStrings.fromJson(list.first);
    }

    return null;
  }

  Future<bool> exists(ProposalStrings strings) async {
    ProposalStrings c = await findById(strings.id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list =
        await dbClient.rawQuery('select count(*) from PROPOSAL_STRINGS');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('delete from PROPOSAL_STRINGS where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from PROPOSAL_STRINGS');
  }
}
