import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'simulator_plant_controller.dart';

class SimulatorPlantPage extends StatefulWidget {
  
  final String title;
  const SimulatorPlantPage({Key key, this.title = "SimulatorPlant"}) : super(key: key);

  @override
  _SimulatorPlantPageState createState() => _SimulatorPlantPageState();
}

class _SimulatorPlantPageState extends ModularState<SimulatorPlantPage, SimulatorPlantController> {
  //use 'controller' variable to access controller
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
  