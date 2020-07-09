import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  static Database _db;

  static const String dbase = "solead-76.db";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();

    return _db;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbase);
    print("db $path");

    var db = await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    // Dao create tables
    await db.execute(
        'CREATE TABLE PROPOSAL_STRINGS(ID INTEGER PRIMARY KEY, TOKEN TEXT, SESSION TEXT'
        ', WIDTH TEXT, HEIGHT TEXT)');
    await db.execute(
        'CREATE TABLE CITIES_IRRADIATION(ID INTEGER PRIMARY KEY, CITY TEXT, DEF TEXT , N TEXT, L TEXT, O TEXT, S TEXT, NE TEXT, NO TEXT, SE TEXT, SO TEXT, PRICE TEXT)');
    await db.execute(
        "insert  into CITIES_IRRADIATION (ID,CITY,DEF,N,L,O,S,NE,NO,SE,SO,PRICE) VALUES (1,'CUIABÁ','5,11','5,25','4,95','4,96','4,53','5,21','5,22','4,66','4,68','0,91')");

    await db.execute(
        'CREATE TABLE tb_dados_kits (id int8 NOT NULL, area varchar(255) NULL, codigo varchar(255) NULL,dados text NULL,inversor varchar(255) NULL,marca_do_modulo varchar(255) NULL,numero_de_modulo int4 NULL,peso varchar(255) NULL,potencia varchar(255) NULL,potencia_do_modulo int4 NULL,valor varchar(255) NULL,potencia_novo numeric(5,2) NULL,CONSTRAINT tb_dados_kits_pkey PRIMARY KEY (id))');

    await db.execute(
        "INSERT INTO tb_dados_kits (id,area,codigo,dados,inversor,marca_do_modulo,numero_de_modulo,peso,potencia,potencia_do_modulo,valor,potencia_novo) VALUES (200,'0000000','000000000','4 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 4 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 1 STRING BOX PROAUTO DEHN 20387 SB-1E/2E-1S-1000DC QUADRO 2 ENTRADAS/1 SAIDA 1 MPPT 50 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 50 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 6 PAINEL SOLAR TRINASOLAR TSM-DE15MII TALLMAX 144 CEL. MONO PERC HALF CELL 19,7% EFICIENCIA 2 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 2 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR REFUSOL 801P1K6100 1.6KW MONOFASICO 220V 1MPPT MONITORAMENTO WLAN','REFUSOL 1,6KW','TRINASOLAR',6,'150','2,4',400,' 14.071,36 ',2.40) ");

    await db.execute(
        'CREATE TABLE CITIES_IRRADIATION_MONTH (ID int8 NOT NULL, INCLINACAO TEXT, JAN TEXT, FEV TEXT, MAR TEXT, ABR TEXT, MAI TEXT, JUN TEXT, JUL TEXT, AGO TEXT, SEP TEXT, OUT TEXT, NOV TEXT, DEZ TEXT, MEDIA TEXT, CONSTRAINT CITIES_IRRADIATION_MONTH_pkey PRIMARY KEY (ID))');

    await db.execute(
        "INSERT INTO CITIES_IRRADIATION_MONTH (ID,INCLINACAO,JAN,FEV,MAR,ABR,MAI,JUN,JUL,AGO,SEP,OUT,NOV,DEZ,MEDIA) VALUES (1,'0','5.37','5.23','5.02','4.77','4.24','4.14','4.31','5.20','4.93','5.17','5.45','5.54','4.95') ");

    await db.execute(
        "INSERT INTO CITIES_IRRADIATION_MONTH (ID,INCLINACAO,JAN,FEV,MAR,ABR,MAI,JUN,JUL,AGO,SEP,OUT,NOV,DEZ,MEDIA) VALUES (2,'16','5.04','5.11','5.21','5.28','5.03','5.16','5.28','6.01','5.31','5.17','5.17','5.21','5.25') ");

    //await db.execute("INSERT INTO tb_dados_kits (id,area,codigo,dados,inversor,marca_do_modulo,numero_de_modulo,peso,potencia,potencia_do_modulo,valor,potencia_novo) VALUES (26,'66','60582-2','8 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 8 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 100 CABO SOLAR NEXANS 59056 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 100 CABO SOLAR NEXANS 40553 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 30 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 1 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 8 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 8 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR GROWATT ON GRID 8000MTL-S 8KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 8KW','BYD HALF CELL',30,'750','10,05',335,' 37.928,01 ',10.05) ,(29,'79,2','60576-5','16 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 16 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 100 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 100 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 36 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 2 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 10 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 10 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL','GROWATT 5KW','BYD HALF CELL',36,'900','12,06',335,' 46.620,68',12.06) ,(30,'88','60577-9','16 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 16 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 100 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 100 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 40 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 2 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 10 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 10 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 2 INVERSOR SOLAR GROWATT ON GRID MIN6000TL-X 6KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 6KW','BYD HALF CELL',40,'1000','13,4',335,' 50.993,34 ',13.40) ,(31,'96,8','60578-3','16 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 16 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 100 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 100 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 44 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 2 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 10 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 10 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 2 INVERSOR SOLAR GROWATT ON GRID MIN6000TL-X 6KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 6KW','BYD HALF CELL',44,'1100','14,74',335,' 55.270,41 ',14.74) ,(34,'114,4','60580-4','16 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 16 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 100 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 100 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 52 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 2 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 14 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 14 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 2 INVERSOR SOLAR GROWATT ON GRID 8000MTL-S 8KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 8KW','BYD HALF CELL',52,'1300','17,42',335,' 64.812,67 ',17.42) ,(35,'123,2','60581-8','16 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 16 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 100 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 100 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 56 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 2 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 14 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 14 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 2 INVERSOR SOLAR GROWATT ON GRID 8000MTL-S 8KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 8KW','BYD HALF CELL',56,'1400','18,76',335,' 69.998,76 ',18.76) ,(37,'132','60582-2','16 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 16 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 100 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 100 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 60 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 2 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 16 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 16 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 2 INVERSOR SOLAR GROWATT ON GRID 8000MTL-S 8KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 8KW','BYD HALF CELL',60,'1500','20,1',335,' 73.667,11 ',20.10) ,(38,'140,8','60583-6','16 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 16 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 200 CABO SOLAR NEXANS 59056 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 200 CABO SOLAR NEXANS 40553 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 64 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 2 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 16 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 16 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 2 INVERSOR SOLAR GROWATT ON GRID 8000MTL-S 8KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 8KW','BYD HALF CELL',64,'1600','21,44',335,' 76.895,05 ',21.44) ,(39,'149,6','62288-2','20 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 20 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 200 CABO SOLAR NEXANS 59056 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 200 CABO SOLAR NEXANS 40553 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 68 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 17 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 17 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR REFUSOL 850P033200 33K-2T 33KW TRIF380V OU 17.1KW TRIF220V 2MPPT MONITORAMENTO 1 COMBINER BOX PROAUTO DEHN CFB-6E-6S-1100DC QUADRO 6 ENTRADAS/6 SAIDAS 1100V 2MPPT','REFUSOL 17.1KW','BYD HALF CELL',68,'1700','22,78',335,' 83.695,10 ',22.78) ,(40,'158,4','62289-6','20 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 20 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 200 CABO SOLAR NEXANS 59056 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 200 CABO SOLAR NEXANS 40553 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 72 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 18 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 18 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR REFUSOL 850P033200 33K-2T 33KW TRIF380V OU 17.1KW TRIF220V 2MPPT MONITORAMENTO 1 COMBINER BOX PROAUTO DEHN CFB-6E-6S-1100DC QUADRO 6 ENTRADAS/6 SAIDAS 1100V 2MPPT','REFUSOL 17.1KW','BYD HALF CELL',72,'1800','24,12',335,'  90.741,80 ',24.12)");

    //await db.execute("INSERT INTO tb_dados_kits (id,area,codigo,dados,inversor,marca_do_modulo,numero_de_modulo,peso,potencia,potencia_do_modulo,valor,potencia_novo) VALUES (41,'176','60577-9','32 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 32 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 200 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 200 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 80 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 4 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 20 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 20 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 4 INVERSOR SOLAR GROWATT ON GRID MIN6000TL-X 6KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 6KW','BYD HALF CELL',80,'2000','26,8',335,' 97.320,77 ',26.80) ,(27,'61,6','60581-8','8 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 8 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 100 CABO SOLAR NEXANS 59056 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 100 CABO SOLAR NEXANS 40553 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 28 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 1 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 7 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 7 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR GROWATT ON GRID 8000MTL-S 8KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 8KW','BYD HALF CELL',28,'700','9,38',335,' 36.130,24 ',9.38) ,(42,'193,6','60578-3','32 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 32 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 200 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 200 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 88 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 4 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 24 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 24 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 4 INVERSOR SOLAR GROWATT ON GRID MIN6000TL-X 6KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 6KW','BYD HALF CELL',88,'2200','29,48',335,' 105.844,82 ',29.48) ,(36,'127,6','62284-6','20 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 20 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 200 CABO SOLAR NEXANS 59056 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 200 CABO SOLAR NEXANS 40553 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 58 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 15 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 15 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR REFUSOL 850P033200 33K-2T 33KW TRIF380V OU 17.1KW TRIF220V 2MPPT MONITORAMENTO 1 COMBINER BOX PROAUTO DEHN CFB-6E-6S-1100DC QUADRO 6 ENTRADAS/6 SAIDAS 1100V 2MPPT','REFUSOL 17.1KW','BYD HALF CELL',58,'1450','19,43',335,' 71.816,93 ',19.43) ,(1,'13,2','60425-4','4 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 4 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 1 STRING BOX PROAUTO DEHN 20387 SB-1E/2E-1S-1000DC QUADRO 2 ENTRADAS/1 SAIDA 1 MPPT 50 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 50 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 6 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 2 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 2 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR REFUSOL 801P1K6100 1.6KW MONOFASICO 220V 1MPPT MONITORAMENTO WLAN','REFUSOL 1,6KW','BYD HALF CELL',6,'150','2,01',335,' 12.927,99',2.01) ,(21,'39,6','60576-5','8 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 8 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 50 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 50 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 18 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 1 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 5 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 5 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR GROWATT ON GRID MIN5000TL-X 5KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 5KW','BYD HALF CELL',18,'450','6,03',335,' 25.183,53 ',6.03) ,(25,'57,2','60580-4','8 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 8 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 100 CABO SOLAR NEXANS 59056 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 100 CABO SOLAR NEXANS 40553 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 26 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 1 STRING BOX ABB 1SLM400200A0000BRA QUADRO 4 ENTRADAS 2 SAIDAS 1000V (2 MPPT) 7 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 7 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR GROWATT ON GRID 8000MTL-S 8KW MONOFASICO 220V 2MPPT MONITORAMENTO','GROWATT 8KW','BYD HALF CELL',26,'650','8,71',335,' 33.551,03 ',8.71) ,(32,'101,2','62278-9','10 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 10 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 200 CABO SOLAR NEXANS 59056 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 200 CABO SOLAR NEXANS 40553 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 46 PAINEL SOLAR BYD 335PHK-36 POLICRISTALINO 144 CEL. 335W HALF CELL 17% EFICIENCIA 12 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 12 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR REFUSOL 850P025200 25K-2T 25KW TRIF380V OU 13KW TRIF220V 2MPPT MONITORAMENTO 1 COMBINER BOX PROAUTO DEHN CFB-6E-6S-1100DC QUADRO 6 ENTRADAS/6 SAIDAS 1100V 2MPPT','REFUSOL 13KW','BYD HALF CELL',46,'1150','15,41',335,' 57.571,00 ',15.41)");
  }

  void deleteOldData() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbase);
    var db = await openDatabase(path, version: 2);
    await db.rawDelete('delete from tb_dados_kits');
  }

  void populateDadosKits(
      id,
      area,
      codigo,
      dados,
      inversor,
      marca_do_modulo,
      numero_de_modulo,
      peso,
      potencia,
      potencia_do_modulo,
      valor,
      potencia_novo) async {
    print('[Populate data on tb_dados_kits]');
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbase);
    var db = await openDatabase(path, version: 2);

    try {
      await db.execute(
          "INSERT INTO tb_dados_kits (id,area,codigo,dados,inversor,marca_do_modulo,numero_de_modulo,peso,potencia,potencia_do_modulo,valor,potencia_novo) VALUES ($id,'$area','$codigo','$dados','$inversor','$marca_do_modulo',$numero_de_modulo,'$peso','$potencia',$potencia_do_modulo,'$valor',$potencia_novo)");
    } catch (e) {
      print('[ERROR]');

      print(e.toString());
    }
  }

  Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion: $newVersion");

    if (oldVersion == 1 && newVersion == 2) {
      await db.execute("alter PROPOSAL_STRINGS carro add column NOVA TEXT");
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  // DOWNLOAD CSV TO DEVICE
  var httpClient = new HttpClient();
  downloadFile(String url, String filename) async {
    await DatabaseHelper.getInstance().db;

    print('[CALL DOWNLOAD FILE FUNCTION]');
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);

    print('[OK!... open File Downloaded..]');
    openFile(filename);
    return file;
  }

  openFile(filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;

    final File file = new File('$dir/$filename');

    Stream<List> inputStream = file.openRead();

    inputStream
        .transform(utf8.decoder) // Dezcode bytes to UTF-8.
        .transform(new LineSplitter()) // Convert stream to individual lines.
        .listen((String line) {
      try {
        List row = line.split(';'); // split by ponto e virgula

        String id = row[0].replaceAll('"', '');
        String area = row[1].replaceAll('"', '');
        String codigo = row[2].replaceAll('"', '');
        String dados = row[3].replaceAll('"', '');

        print(dados);

        String inversor = row[4].replaceAll('"', '');
        String marca_do_modulo = row[5].replaceAll('"', '');
        String numero_de_modulo = row[6].replaceAll('"', '');
        String peso = row[7].replaceAll('"', '');
        String potencia = row[8].replaceAll('"', '').replaceAll(',', '.');
        String potencia_do_modulo = row[9].replaceAll('"', '');
        String valor = row[10].replaceAll('"', '');
        String potencia_novo = row[11].replaceAll('"', '');

        if (id == "id") {
          print('[DELETING OLD DATA]');
          DatabaseHelper().deleteOldData();
        } else {
          DatabaseHelper().populateDadosKits(
              id,
              area,
              codigo,
              dados,
              inversor,
              marca_do_modulo,
              numero_de_modulo,
              peso,
              potencia,
              potencia_do_modulo,
              valor,
              potencia_novo);
        }
        print('[EXECUTED LINE]');
        print('[$codigo] ' + ' [$potencia] ' + ' [$potencia_novo] ');
      } catch (e) {
        print('[ERROR] ' + e.toString());
        //print('THIS NEVER GETS PRINTED');
      }
    }, onDone: () {
      print('File is now closed.');
    }, onError: (e) {
      print(e.toString());
    });
  }
}
