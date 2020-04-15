import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/shared/auth/entities/auth.dart';
import 'package:login/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:mobx/mobx.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final IAuthRepository _authRepository = Modular.get();

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  FirebaseUser user;

  @observable
  String token;

  @action
  setUser(FirebaseUser value) {
    user = value;
    status = AuthStatus.login;
  }

  @action
  auth(value) {
    token = value;
    status = token == null ? AuthStatus.logoff : AuthStatus.login;
  }

  _AuthControllerBase() {
    _authRepository.getUser().then(auth).catchError((e) {
      print('ERRORRRRRR');
    });
  }

  @action
  Future loginWithGoogle() async {
    user = await _authRepository.getGoogleLogin();
  }

  @action
  Future login(String user, String pass) async {
    final r = await _authRepository.getToken(user, pass);

    //final response = Auth.fromJson(respose);

    //print(r.accessToken);
    return r;
  }

  
  @action
  Future getCitiesIrradiation() async {
    final r = await _authRepository.getCitiesIrradiation();
    return r;
  }



  

  Future logout() {
    return _authRepository.getLogout();
  }

  Future getDataLogin() {
    return _authRepository.getDataLogin();
  }


  
}

enum AuthStatus { loading, login, logoff }
