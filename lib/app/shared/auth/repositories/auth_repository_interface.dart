abstract class IAuthRepository {
  Future getUser();
//  Future<FirebaseUser> getGoogleLogin();
  // Future getFacebookLogin();
  Future getEmailPasswordLogin();
  Future getToken(user, pass);
  Future getAcessToken();
  Future getLogout();
  Future getIrradiation();
  Future getPrice();
  Future getEfficiency();
  Future getDataLogin();
  Future getTax();
}
