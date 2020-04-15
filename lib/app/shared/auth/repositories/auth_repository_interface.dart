import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future getUser();
  Future<FirebaseUser> getGoogleLogin();
  Future getFacebookLogin();
  Future getEmailPasswordLogin();
  Future getToken(user, pass);
  Future getLogout();
  Future getCitiesIrradiation();
  Future getDataLogin();
}
