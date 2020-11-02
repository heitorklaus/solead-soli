import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/shared/repositories/entities/plants_list.dart';
import 'plants_controller.dart';

class PlantsPage extends StatefulWidget {
  final String title;
  const PlantsPage({Key key, this.title = "Plants"}) : super(key: key);

  @override
  _PlantsPageState createState() => _PlantsPageState();
}

class _PlantsPageState extends ModularState<PlantsPage, PlantsController> {
  //use 'controller' variable to access controller

  final controller = Modular.get<PlantsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              controller.getAll();
            },
          ),
        ],
        title: Text(widget.title),
      ),
      body: Observer(builder: (BuildContext context) {
        List<PlantsList> list = controller.lista.value;

        if (list == null) {
          return Center(child: Container(child: CircularProgressIndicator()));
        } else {
          return Container(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) {
                  var item = list[index];
                  return ListTile(title: Text(item.title));
                }),
          );
        }
      }),
    );
  }
}
