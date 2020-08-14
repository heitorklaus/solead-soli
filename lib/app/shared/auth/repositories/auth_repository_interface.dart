abstract class IAuthRepository {
  Future getUser();
//  Future<FirebaseUser> getGoogleLogin();
  // Future getFacebookLogin();
  Future getEmailPasswordLogin();
  Future getToken(user, pass);
  Future getLogout();
  Future getCitiesPreferences(value);
  Future getDataLogin();
  Future getTax();
}
