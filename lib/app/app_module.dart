import 'dart:async';
import 'dart:convert';

import 'package:login/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:login/app/app_widget.dart';
import 'package:login/app/modules/home/home_module.dart';
import 'package:login/app/modules/simulator/simulator_module.dart';
import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/power_plants.dart';
import 'package:login/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:login/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:login/app/shared/utils/database_helper.dart';

import 'modules/login/login_module.dart';
import 'shared/auth/repositories/auth_repository_interface.dart';
import 'splash/splash_page.dart';

class AppModule extends MainModule {
  final timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
    DatabaseHelper().saveBudgetOnline().then((value) async {
      print(value.length);
      if (value.length > 0) {
        Map<String, String> headers = await AuthRepository.getHeaders();
        headers["Content-Type"] = "application/json";

        final encodedResults = jsonEncode(value).replaceAll("\n", "");

        print('chamada para API');
        final auth = await http
            .post('https://soleadapp.herokuapp.com/api/posts/',
                headers: headers, body: encodedResults)
            .then((value) {
          if (value.statusCode == 200) DatabaseHelper().updateBudgetLocal();
        });
      }
    });
  });

  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind<ILocalStorage>((i) => LocalStorageShared()),
        Bind<IAuthRepository>((i) => AuthRepository()),
        Bind((i) => AuthController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => SplashPage()),
        ModularRouter('/login',
            module: LoginModule(), transition: TransitionType.noTransition),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/simulator', module: SimulatorModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject.of();
}
