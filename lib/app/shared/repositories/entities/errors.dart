import 'package:mobx/mobx.dart';

part 'errors.g.dart';

class Errors extends _Errors with _$Errors {
  Errors({
    String message,
  }) : super(
          message: message,
        );

  toJson() {
    return {
      "message": message,
    };
  }

  factory Errors.fromJson(Map json) {
    return Errors(message: json['message']);
  }
}

abstract class _Errors with Store {
  @observable
  String message;

  _Errors({this.message});
}
