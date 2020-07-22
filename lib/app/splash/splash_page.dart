import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:login/app/shared/repositories/entities/cities_irradiation_month.dart';
import 'package:login/app/shared/utils/database_helper.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:mobx/mobx.dart';
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

  @override
  void initState() {
    super.initState();
    disposer = autorun((_) async {
      final auth = Modular.get<AuthController>();
      if (auth.status == AuthStatus.login) {
        print("[ SPLASH ]");

        final getCity = await auth.getCitiesIrradiation();
        print(' [CITY NAME AND DATA IRRADIATION] ' +
            getCity.city +
            ' ' +
            getCity.data);

        await DatabaseHelper().downloadFile(
            "http://www.klausmetal.com.br/file55.csv", "file57.csv");

        loadCitiesIrradiationData();

        Modular.to.pushReplacementNamed('/home');
      } else if (auth.status == AuthStatus.logoff) {
        Modular.to.pushReplacementNamed('/login');
      }
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
      body: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: Image.asset(
                'lib/app/shared/assets/images/l.png',
                width: 70,
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
    );
  }
}
