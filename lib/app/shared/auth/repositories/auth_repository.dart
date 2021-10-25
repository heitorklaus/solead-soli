import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/app/shared/auth/entities/auth.dart';
import 'package:login/app/shared/auth/entities/pref_irradiation.dart';
import 'package:login/app/shared/repositories/entities/cities_irradiation_month.dart';
import 'package:login/app/shared/utils/database_helper.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:sqflite/sqflite.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Database> get db => DatabaseHelper.getInstance().db;

  @override
  Future getEmailPasswordLogin() {
    // TODO: implement getEmailPasswordLogin
    throw UnimplementedError();
  }

  @override
  Future getAcessToken() async {
    var token = await Prefs.getString("TOKEN");
    return token;
  }

  @override
  Future getFacebookLogin() {
    // TODO: implement getFacebookLogin
    throw UnimplementedError();
  }

  static Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = Map();
    return headers;
  }

  @override
  Future getToken(user, pass) async {
    Map<String, String> headers = await getHeaders();

    var body = jsonEncode({'username': user, 'password': pass});

    headers["Content-Type"] = "application/json";
    final auth = await http.post('https://soleadapp.herokuapp.com/api/auth/signin', headers: headers, body: body);

    final data = Auth.fromJson(json.decode(auth.body));

    // Set Token
    Prefs.setString("TOKEN", data.accessToken);
    // Set UserId
    Prefs.setInt("USERID", data.id);

    // Set ROle
    Prefs.setString("ROLE", data.roles[0]["name"]);
    // Set Token
    Prefs.setString("NAME", data.name);

    return data;
  }

  Future getDataUser() async {
    Map<String, String> headers = await getHeaders();

    var idUsuario = await Prefs.getInt("USERID");

    headers["Content-Type"] = "application/json";
    final auth = await http.get('https://soleadapp.herokuapp.com/api/cash/get/$idUsuario', headers: headers);

    final data = Auth.fromJson(json.decode(auth.body));
    return data;
  }

  @override
  Future getIrradiation() async {
    final val = await Prefs.getString("IRRADIATION");

    return val;
  }

  @override
  Future getEfficiency() async {
    final val = await Prefs.getDouble("EFFICIENCY");

    return val;
  }

  @override
  Future getPrice() async {
    final val = await Prefs.getString("PRICE");

    return val;
  }

  @override
  Future<List<Map<String, dynamic>>> getTax() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery('select * from TAX');
    return result;
  }

  @override
  getGoogleLogin() async {
    // final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // final AuthCredential credential = GoogleAuthProvider.getCredential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );

    // final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    // return user;
  }

  @override
  Future getUser() async {
    final valor = await Prefs.getString("TOKEN");
    return valor;
  }

  Future<String> getName() async {
    final valor = await Prefs.getString("NAME");
    return valor.toString();
  }

  @override
  Future getLogout() {
    Prefs.setString("TOKEN", null);
    Prefs.setString("USER1", null);
    Prefs.setString("PASS1", null);
    // return _auth.signOut();
  }

  @override
  Future getDataLogin() async {
    final valor = await Prefs.getString("IRRADIATION");

    //2 print(valor);

    return valor;
  }
}
