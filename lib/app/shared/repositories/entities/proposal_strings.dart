import 'package:mobx/mobx.dart';

part 'proposal_strings.g.dart';

class ProposalStrings extends _ProposalStrings with _$ProposalStrings {
  ProposalStrings(
      {
      int id, 
      String token,
      String session,
      String width,
      String height,})
      : super(
            id:id,
            token: token,
            session: session,
            width: width,
            height: height);

  toJson() {
    return {
      "id": id,
      "token": token,
      "session": session,
      "width": width,
      "height": height,
    };
  }

  factory ProposalStrings.fromJson(Map json) {
    return ProposalStrings(
        id: json['id'],
        token: json['token'],
        session: json['session'],
        width: json['width'],
        height: json['height']);
  }
}

abstract class _ProposalStrings with Store {
  @observable
  int id;
  @observable
  String token;
  @observable
  String session;
  @observable
  String width;
  @observable
  String height;
 
  _ProposalStrings(
      {
      this.id,
      this.token,
      this.session,
      this.width,
      this.height
});
}
