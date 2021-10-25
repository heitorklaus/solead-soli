import 'package:mobx/mobx.dart';

part 'usuario.g.dart';

class Usuario extends _Usuario with _$Usuario {
  Usuario({
    String name,
    String email,
    String foto,
    String avatar,
  }) : super(name: name, email: email, foto: foto, avatar: avatar);

  toJson() {
    return {
      "name": name,
      "email": email,
      "foto": foto,
      "avatar": avatar,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> map) {
    return Usuario(
      name: map['name'],
      email: map['email'],
      foto: map['foto'],
      avatar: map['avatar'],
    );
  }
}

abstract class _Usuario with Store {
  @observable
  String name;
  @observable
  String email;
  @observable
  String foto;
  @observable
  String avatar;

  _Usuario({this.name, this.email, this.foto, this.avatar});
}
