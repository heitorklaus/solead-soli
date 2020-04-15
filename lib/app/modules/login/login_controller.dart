import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:login/app/shared/auth/entities/auth.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginBase with _$LoginController;

abstract class _LoginBase with Store {
  AuthController auth = Modular.get();

  final username = TextEditingController(text: 'heitorklaus@hotmail.com');
  final password = TextEditingController(text: 'amesma');

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

  @action
  Future loginApi() async {

       
    try {
      loading = true;
      final respose = await auth.login(username.text, password.text);
      print('[RESPONSTA PARA LOGIN CONTROLLER]');

      
      if (respose.accessToken != null) {
        print('[RESPONSE] CITY, IRRADIATION');
      final getCity = await auth.getCitiesIrradiation();
         print(getCity.city +' '+ getCity.data);
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
