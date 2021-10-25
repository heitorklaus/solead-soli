import 'package:mobx/mobx.dart';

part 'version.g.dart';

class CheckVersion extends _CheckVersion with _$CheckVersion {
  CheckVersion({
    double version,
  }) : super(
          version: version,
        );

  toJson() {
    return {
      "version": version,
    };
  }

  factory CheckVersion.fromJson(Map json) {
    return CheckVersion(version: json['version']);
  }
}

abstract class _CheckVersion with Store {
  @observable
  double version;

  _CheckVersion({this.version});
}
