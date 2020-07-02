import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:login/app/shared/auth/entities/auth.dart';
import 'package:login/app/shared/auth/entities/pref_irradiation.dart';
import 'package:login/app/shared/utils/database_helper.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:sqflite/sqflite.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Database> get db => DatabaseHelper.getInstance().db;

  @override
  Future getEmailPasswordLogin() {
    // TODO: implement getEmailPasswordLogin
    throw UnimplementedError();
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
    final auth = await http.post(
        'https://buracosapp2020.herokuapp.com/api/auth/signin',
        headers: headers,
        body: body);

    final data = Auth.fromJson(json.decode(auth.body));

    // Set Token
    Prefs.setString("TOKEN", data.accessToken);

    return data;
  }

  @override
  Future getCitiesIrradiation() async {
    var dbClient = await db;
    final list = await dbClient
        .rawQuery('select * from CITIES_IRRADIATION where id = 1');

    final first = PrefIrradiation.fromJson(list.first);

    // Set Irradiation
    Prefs.setString("IRRADIATION", first.data);

    return first;
  }

  @override
  Future<FirebaseUser> getGoogleLogin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  @override
  Future getUser() async {
    final valor = await Prefs.getString("TOKEN");
    return valor;
  }

  @override
  Future getLogout() {
    Prefs.setString("TOKEN", "");
    return _auth.signOut();
  }

  @override
  Future getDataLogin() async {
    final valor = await Prefs.getString("IRRADIATION");

    //2 print(valor);

    return valor;
  }
}
