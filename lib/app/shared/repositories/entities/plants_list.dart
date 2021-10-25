import 'package:mobx/mobx.dart';

part 'plants_list.g.dart';

class PlantsList extends _PlantsList with _$PlantsList {
  PlantsList({
    String cliente,
    String title,
  }) : super(
          cliente: cliente,
          title: title,
        );

  toJson() {
    return {"cliente": cliente, "title": title};
  }

  factory PlantsList.fromJson(Map json) {
    return PlantsList(cliente: json['cliente'], title: json['title']);
  }
}

abstract class _PlantsList with Store {
  @observable
  String cliente;
  String title;

  _PlantsList({this.cliente, this.title});
}
