import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:login/app/shared/auth/entities/auth.dart';
import 'package:login/app/shared/utils/database_helper.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginBase with _$LoginController;

abstract class _LoginBase with Store {
  AuthController auth = Modular.get();

  final username = TextEditingController();
  final password = TextEditingController();

  @observable
  bool disableAdd = true;

  @observable
  bool loading = false;

  final textController = TextEditingController();

  _LoginBase() {
    username.addListener(() {
      if (username.text.length > 3 && password.text.length > 3) {
        disableAdd = false;
      } else {
        disableAdd = true;
      }
    });

    password.addListener(() {
      if (password.text.length > 3 && password.text.length > 3) {
        disableAdd = false;
      } else {
        disableAdd = true;
      }
    });
  }

  @action
  Future loginWithGoogle() async {
    try {
      loading = true;
      await auth.loginWithGoogle();
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      loading = false;
    }
  }

  Future reLogin() async {
    try {
      final wasLoggedBeforeUser = await Prefs.getString("USER1");
      final wasLoggedBeforePass = await Prefs.getString("PASS1");

      final respose = await auth.login(wasLoggedBeforeUser.toString(), wasLoggedBeforePass.toString());
      print('[TRY RELOGIN]');

      if (respose.accessToken != null) {
        return respose.accessToken;
      } else {
        print('FALHA!');
      }
      return respose;
    } catch (e) {}
  }

  @action
  Future loginApi() async {
    try {
      loading = true;

      final respose = await auth.login(username.text, password.text);
      print('[RESPONSE PARA LOGIN CONTROLLER]');

      if (respose.accessToken != null) {
        print('[RESPONSE] CITY, IRRADIATION');
        // await DatabaseHelper().downloadFile("http://www.klausmetal.com.br/file55.csv", "file55.csv");
        // final getCity = await auth.getCitiesIrradiation();
        // print(getCity.city + ' ' + getCity.data);
        // setando login e pass pro futuro

        Prefs.setString("USER1", username.text);
        Prefs.setString("PASS1", password.text);

        Modular.to.pushReplacementNamed('/home');
      } else {
        print('FALHA!');
        loading = false;
      }
      return respose;
    } catch (e) {
      loading = false;
    }
  }
}
