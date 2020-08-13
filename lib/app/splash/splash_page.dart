import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:framework/ui/form/buttons/ghost_button.dart';
import 'package:framework/ui/form/buttons/light_button.dart';
import 'package:framework/ui/form/buttons/light_ghost_button.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:framework/ui/form/buttons/secondary_button.dart';
import 'package:framework/ui/form/buttons/success_button.dart';
import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:login/app/shared/repositories/entities/cities_irradiation_month.dart';
import 'package:login/app/shared/styles/main_style.dart';
import 'package:login/app/shared/utils/database_helper.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

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
    print(info);
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
    disposer = autorun((_) async {
      final auth = Modular.get<AuthController>();

      try {
        await DatabaseHelper().downloadFile("http://www.klausmetal.com.br/file56.csv", "file56.csv").then((value) {
          if (value.statusCode == 200) {
            print('[ LOADED DATA FROM KLAUSMETAL]');
            loadCitiesIrradiationData();
            if (auth.status == AuthStatus.login) {
              print("[ LOGGED ]");
              Modular.to.pushReplacementNamed('/home');
            } else {
              print("[ NOT LOGGED ]");
              Modular.to.pushReplacementNamed('/login');
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

      if (auth.status == AuthStatus.login) {
        print("[ SPLASH ]");

        // Modular.to.pushReplacementNamed('/home');
      } else if (auth.status == AuthStatus.logoff) {
        Modular.to.pushReplacementNamed('/login');
      }
    });
  }

  Future loadCitiesIrradiationData() async {
    var dbClient = await db;
    final list = await dbClient.rawQuery('select * from CITIES_IRRADIATION_MONTH where id = 1');

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
    return Scaffold(
      backgroundColor: Colors.blue[400],
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
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF)),
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
