import 'dart:async';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  static Database _db;

  static const String _zipPath = 'http://www.klausmetal.com.br/images_to_pdf.zip';

  static const String _localZipFileName = 'images_to_pdf.zip';

  static const String dbase = "solead-97.db";

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
    print("[ USING DATABASE ] $path");
    var db = await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    print("[ FIRST RUN DATABASE GENERATED]" + db.toString());
    // Dao create tables
    await db.execute('CREATE TABLE PROPOSAL_STRINGS(ID INTEGER PRIMARY KEY, TOKEN TEXT, SESSION TEXT' ', WIDTH TEXT, HEIGHT TEXT)');
    await db.execute('CREATE TABLE CITIES_IRRADIATION(ID INTEGER PRIMARY KEY, CITY TEXT, DEF TEXT , N TEXT, L TEXT, O TEXT, S TEXT, NE TEXT, NO TEXT, SE TEXT, SO TEXT, PRICE TEXT)');
    await db.execute("insert  into CITIES_IRRADIATION (ID,CITY,DEF,N,L,O,S,NE,NO,SE,SO,PRICE) VALUES (1,'CUIABÁ','5,11','5,25','4,95','4,96','4,53','5,21','5,22','4,66','4,68','0,91')");

    await db.execute('CREATE TABLE tb_dados_kits (id int8 NOT NULL, area varchar(255) NULL, codigo varchar(255) NULL,dados text NULL,inversor varchar(255) NULL,marca_do_modulo varchar(255) NULL,numero_de_modulo int4 NULL,peso varchar(255) NULL,potencia varchar(255) NULL,potencia_do_modulo int4 NULL,valor varchar(255) NULL,CONSTRAINT tb_dados_kits_pkey PRIMARY KEY (id))');

    await db.execute("INSERT INTO tb_dados_kits (id,area,codigo,dados,inversor,marca_do_modulo,numero_de_modulo,peso,potencia,potencia_do_modulo,valor) VALUES (200,'0000000','000000000','4 STAUBLI CONECTOR MC4 320016P0001-UR PV-KBT4/6II-UR ACOPLADOR FEMEA 4 STAUBLI CONECTOR MC4 32.0017P0001-UR PV-KST4/6II-UR ACOPLADOR MACHO 1 STRING BOX PROAUTO DEHN 20387 SB-1E/2E-1S-1000DC QUADRO 2 ENTRADAS/1 SAIDA 1 MPPT 50 CABO SOLAR NEXANS 47064 ENERGYFLEX AFITOX 0,6/1KV 1500V DC PRETO 50 CABO SOLAR NEXANS 43221 ENERGYFLEX AFITOX 0,6/1KV 1500V DC VERMELHO 6 PAINEL SOLAR TRINASOLAR TSM-DE15MII TALLMAX 144 CEL. MONO PERC HALF CELL 19,7% EFICIENCIA 2 ESTRUTURA SOLAR GROUP KTHTC420X000MD04 PERFIL THUNDER TELHA COLONIAL 4,20M 2 ESTRUTURA SOLAR GROUP ATHTC420X000MD04 4 PAINEIS FIXADOR GANCHO TELHA COLONIAL 1 INVERSOR SOLAR REFUSOL 801P1K6100 1.6KW MONOFASICO 220V 1MPPT MONITORAMENTO WLAN','REFUSOL 1,6KW','TRINASOLAR',6,'150','2,4',400,' 14.071,36 ') ");

    await db.execute('CREATE TABLE CITIES_IRRADIATION_MONTH (ID int8 NOT NULL, INCLINACAO TEXT, JAN TEXT, FEV TEXT, MAR TEXT, ABR TEXT, MAI TEXT, JUN TEXT, JUL TEXT, AGO TEXT, SEP TEXT, OUT TEXT, NOV TEXT, DEZ TEXT, MEDIA TEXT, CONSTRAINT CITIES_IRRADIATION_MONTH_pkey PRIMARY KEY (ID))');

    await db.execute("INSERT INTO CITIES_IRRADIATION_MONTH (ID,INCLINACAO,JAN,FEV,MAR,ABR,MAI,JUN,JUL,AGO,SEP,OUT,NOV,DEZ,MEDIA) VALUES (1,'0','5.37','5.23','5.02','4.77','4.24','4.14','4.31','5.20','4.93','5.17','5.45','5.54','4.95') ");

    await db.execute("INSERT INTO CITIES_IRRADIATION_MONTH (ID,INCLINACAO,JAN,FEV,MAR,ABR,MAI,JUN,JUL,AGO,SEP,OUT,NOV,DEZ,MEDIA) VALUES (2,'16','5.04','5.11','5.21','5.28','5.03','5.16','5.28','6.01','5.31','5.17','5.17','5.21','5.25') ");
  }

  Future<FutureOr<void>> _onUpgrade(Database db, int oldVersion, int newVersion) async {
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
  Future downloadFile(String url, String filename) async {
    final dio = Dio();

    String tempDir = (await getApplicationDocumentsDirectory()).path;
    String fullPath = tempDir + "/$filename";

    final valueDownloaded = await dio.download(url, fullPath, onReceiveProgress: (received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
        final aa = (received / total * 100).toStringAsFixed(0) + "%";
        return aa;
      }
    });
    // FIM DO PROCESSO DE DOWNLOAD DO CSV

    // MANDO RODAR A ABERTURA DO ARQUIVO QUE FOI BAIXADO
    openFile(filename);

    // VERIFICO SE JA EXISTEM OS ARQUIVOS NA PASTA CACHE PARA PRODUCAO DO PDF
    Directory tempDirImages = await getTemporaryDirectory();
    String tempPathImages = tempDirImages.path + "/img/";
    final needDownloadFiles = await io.Directory(tempPathImages).exists();
    if (!needDownloadFiles) {
      var zippedFile = await _downloadFile(_zipPath, _localZipFileName);
      // SE NAO EXISTIR DESCOMPACTO ELES
      await unarchiveAndSave(zippedFile);
    } else {
      print('[FILES PDF ALREADY EXIST, DO NOT DOWNLOAD AGAIN....]');
    }

    return valueDownloaded;
  }

  void deleteOldData() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbase);
    var db = await openDatabase(path, version: 2);
    await db.rawDelete('delete from tb_dados_kits');
  }

  void populateDadosKits(id, area, codigo, dados, inversor, marca_do_modulo, numero_de_modulo, peso, potencia, potencia_do_modulo, valor) async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbase);
    var db = await openDatabase(path, version: 2);

    try {
      await db.execute("INSERT INTO tb_dados_kits (id,area,codigo,dados,inversor,marca_do_modulo,numero_de_modulo,peso,potencia,potencia_do_modulo,valor) VALUES ($id,'$area','$codigo','$dados','$inversor','$marca_do_modulo',$numero_de_modulo,'$peso','$potencia',$potencia_do_modulo,'$valor')");
    } catch (e) {
      print('[ERROR]');

      //print(e.toString());
    }
  }

  Future<File> _downloadFile(String url, String fileName) async {
    String _dir = (await getApplicationDocumentsDirectory()).path;

    var req = await http.Client().get(Uri.parse(url));
    var file = File('$_dir/$fileName');
    return file.writeAsBytes(req.bodyBytes);
  }

  unarchiveAndSave(var zippedFile) async {
    Directory tempDirImages = await getTemporaryDirectory();
    String tempPathImages = tempDirImages.path + "/img/";

    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var fileName = '$tempPathImages${file.name}';
      if (file.isFile) {
        final data = file.content as List<int>;
        var outFile = File(fileName)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
        print('File:: ' + outFile.path);
      }
    }
  }

  openFile(filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;

    Object dadosKits = new Object();

    final File file = new File('$dir/$filename');

    Stream<List> inputStream = file.openRead();

    inputStream
        .transform(utf8.decoder) // Dezcode bytes to UTF-8.
        .transform(new LineSplitter()) // Convert stream to individual lines.
        .listen((String line) {
      try {
        List row = line.split(';'); // split by ponto e virgula

        String id = row[0].replaceAll('"', '');
        String potencia = row[1].replaceAll(',', '.');
        String dados = row[2].replaceAll('"', '') + '<BR>' + row[3].replaceAll('"', '') + '<BR>' + row[4].replaceAll('"', '') + '<BR>' + row[5].replaceAll('"', '') + '<BR>' + row[6].replaceAll('"', '') + '<BR>' + row[7].replaceAll('"', '') + '<BR>' + row[8].replaceAll('"', '') + '<BR>' + row[9].replaceAll('"', '') + '<BR>' + row[10].replaceAll('"', '') + '<BR>' + row[11].replaceAll('"', '');
        String numero_de_modulo = row[12].replaceAll('"', '');
        String potencia_do_modulo = row[13].replaceAll('"', '');
        String marca_do_modulo = row[14].replaceAll('"', '');
        String inversor = row[15].replaceAll('"', '');
        String area = row[16].replaceAll('"', '');
        String peso = row[17].replaceAll('"', '');
        String codigo = row[18].replaceAll('"', '');

        String valor = row[19].replaceAll('"', '');

        if (id == "id") {
          print('[IDENTIFY AND DELETE OLD DATA TABLE DADOSKITS]');
          DatabaseHelper().deleteOldData();
        } else {
          print('[REFRESH TABLE DADOSKITS]');
          DatabaseHelper().populateDadosKits(id, area, codigo, dados, inversor, marca_do_modulo, numero_de_modulo, peso, potencia, potencia_do_modulo, valor);
        }

        print('[ID: $id] ' + ' [POTÊNCIA: $potencia] ' + ' [CÓD DO PRODUTO: $codigo]  ' + ' [INVERSOR: $inversor]  ' + ' [VALOR: $valor]  ');
      } catch (e) {
        print('[ERROR] ' + e.toString());
        //print('THIS NEVER GETS PRINTED');
      }
    }, onDone: () {
      print('[DATABASE TABLE DADOSKITS REFRESHED.]');
    }, onError: (e) {
      print(e.toString());
    });
  }
}
