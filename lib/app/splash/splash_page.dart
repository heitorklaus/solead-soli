import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:framework/ui/form/buttons/secondary_button.dart';

import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:login/app/shared/auth/entities/pref_irradiation.dart';
import 'package:login/app/shared/repositories/entities/cities_irradiation_month.dart';

import 'package:login/app/shared/styles/main_style.dart';
import 'package:login/app/shared/utils/database_helper.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';

import 'package:login/app/shared/styles/main_colors.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ReactionDisposer disposer;
  Future<Database> get db => DatabaseHelper.getInstance().db;
  bool reload = false;

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    return info;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[400], //or set color with: Color(0xFF0000FF)
    ));

    disposer = autorun((_) async {
      final auth = Modular.get<AuthController>();

      final permissao = await _requestPermission();
      if (permissao == 'PermissionStatus.denied') {
        print(permissao);
      }

      if (permissao == 'PermissionStatus.granted') {
        print(permissao);
      }

      try {
        await DatabaseHelper()
            .downloadFile(
                DatabaseHelper.csvKitsPath, DatabaseHelper.csvKitsFileName)
            .then((value) async {
          if (value.statusCode == 200) {
            print('[ LOADED DATA FROM KLAUSMETAL]');
            loadCitiesIrradiationData();

            final l = await Prefs.getString("TOKEN");

            if (l != "" && permissao == 'PermissionStatus.granted') {
              print("[ LOGGED ]");
             Modular.to.pushReplacementNamed('/home');
            } else if (permissao == 'PermissionStatus.granted') {
              print("[ NOT LOGGED ]");
              Modular.to.pushReplacementNamed('/login');
            } else {
              setState(() {
                reload = true;
              });
            }
          } else {}
          // print(value.statusCode);
        });
      } on TimeoutException catch (e) {
        print('this should not be reached if the exception is raised');
      } on Exception catch (e) {
        print('exception: $e');

        setState(() {
          reload = true;
        });
      }

      final double localVersion = await DatabaseHelper().checkVersionLocal();
      final double onlineVersion = await DatabaseHelper().checkVersion();

      if (onlineVersion > localVersion) {
        final stop = await Prefs.setString("STOP", "TRUE");
        Modular.to.pushNamed('/update');
      }

      // if (auth.status != AuthStatus.login && permissao == 'PermissionStatus.granted') {
      //   print("[ SPLASH ]");

      //   // Modular.to.pushReplacementNamed('/home');
      // } else if (auth.status == AuthStatus.logoff && permissao == 'PermissionStatus.granted') {
      //   Modular.to.pushReplacementNamed('/login');
      // } else {
      //   setState(() {
      //     reload = true;
      //   });
      // }
    });
  }

  Future loadCitiesIrradiationData() async {
    var dbClient = await db;
    final list = await dbClient
        .rawQuery('select * from CITIES_IRRADIATION_MONTH where id = 1');

    if (list.length > 0) {
      final eco = await CitiesData.fromJson(list.first);

      // final data = Auth.fromJson(json.decode(auth.body));
      // Set Token

      List<String> someMap = [
        'inc:${eco.inclinacao}',
        'jan:${eco.jan}',
        'fev:${eco.fev}',
        'mar:${eco.mar}',
        'abr:${eco.abr}',
        'mai:${eco.mai}',
        'jun:${eco.jun}',
        'jul:${eco.jul}',
        'ago:${eco.ago}',
        'sep:${eco.sep}',
        'out:${eco.out}',
        'nov:${eco.nov}',
        'dez:${eco.dez}',
        'media:${eco.media}',
      ];

      Prefs.setStringList("CITIES", someMap);

      final list_citi = await dbClient
          .rawQuery('select * from CITIES_IRRADIATION where id = 1');

      final first = PrefIrradiation.fromJson(list_citi.first);

      // Set Irradiation

      Prefs.setString("IRRADIATION", first.media);
      Prefs.setString("PRICE", first.price);
      // DEFAULT VALUE
      Prefs.setDouble("EFFICIENCY", 0.75);
    }

    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposer();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MainColors.cielo,
       //oset color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      backgroundColor: MainColors.cielo,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Image.asset(
                      'lib/app/shared/assets/images/l.png',
                      width: 70,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      backgroundColor: Colors.blue[500],
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          reload == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SecondaryButton(
                      child: Text(
                        'Tentar novamente...',
                        style: buttonLargeBlue,
                      ),
                      //onPressed:controller.loginWithGoogle,

                      onPressed: () {
                        Modular.to.pushReplacementNamed('/');
                      },
                    ).getLarge(),
                  ],
                )
              : Text('')
        ],
      ),
    );
  }
}
