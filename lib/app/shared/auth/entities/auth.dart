import 'package:mobx/mobx.dart';

part 'auth.g.dart';

class Auth extends _Auth with _$Auth {
  Auth({String avatar, String email, String name, String tokenType, String password, String username, dynamic roles, String accessToken}) : super(avatar: avatar, email: email, name: name, tokenType: tokenType, accessToken: accessToken, roles: roles);

  toJson() {
    return {"avatar": avatar, "email": email, "username": username, "name": name, "tokenType": tokenType, "password": password, "roles": roles, "accessToken": accessToken};
  }

  factory Auth.fromJson(Map json) {
    return Auth(avatar: json['avatar'], email: json['email'], name: json['name'], tokenType: json['tokenType'], accessToken: json['accessToken'], roles: json['roles']);
  }
}

abstract class _Auth with Store {
  @observable
  String avatar;
  @observable
  String email;
  @observable
  String name;
  @observable
  String tokenType;
  @observable
  String accessToken;
  @observable
  String password;
  @observable
  dynamic roles;
  @observable
  String username;

  _Auth({this.avatar, this.email, this.name, this.tokenType, this.accessToken, this.password, this.roles, this.username});
}
