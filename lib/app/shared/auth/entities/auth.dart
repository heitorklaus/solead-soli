import 'package:mobx/mobx.dart';

part 'auth.g.dart';

class Auth extends _Auth with _$Auth {
  Auth({String avatar, int id, String email, String name, String cash, String company, String tokenType, String password, String username, dynamic roles, String accessToken}) : super(avatar: avatar, id: id, email: email, name: name, cash: cash, tokenType: tokenType, accessToken: accessToken, roles: roles);

  toJson() {
    return {"avatar": avatar, "id": id, "email": email, "username": username, "name": name, "cash": cash, "company": company, "tokenType": tokenType, "password": password, "roles": roles, "accessToken": accessToken};
  }

  factory Auth.fromJson(Map json) {
    return Auth(avatar: json['avatar'], id: json['id'], email: json['email'], name: json['name'], cash: json['cash'], company: json['company'], tokenType: json['tokenType'], accessToken: json['accessToken'], roles: json['roles']);
  }
}

abstract class _Auth with Store {
  @observable
  String avatar;
  @observable
  int id;
  @observable
  String email;
  @observable
  String name;
  @observable
  String cash;
  @observable
  String company;
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

  _Auth({this.avatar, this.id, this.email, this.name, this.cash, this.company, this.tokenType, this.accessToken, this.password, this.roles, this.username});
}
