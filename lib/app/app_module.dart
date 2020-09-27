import 'package:login/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:login/app/app_widget.dart';
import 'package:login/app/modules/home/home_module.dart';
import 'package:login/app/modules/simulator/simulator_module.dart';
import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:login/app/shared/repositories/localstorage/local_storage_share.dart';

import 'modules/login/login_module.dart';
import 'shared/auth/repositories/auth_repository_interface.dart';
import 'splash/splash_page.dart';

class AppModule extends MainModule {
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
        ModularRouter('/login', module: LoginModule(), transition: TransitionType.noTransition),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/simulator', module: SimulatorModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject.of();
}
