import 'package:flutter/material.dart';

class ViewPlantSimulatedWidget extends StatefulWidget {
  final Widget equipamento;

  ViewPlantSimulatedWidget({this.equipamento});

  @override
  _ViewPlantSimulatedState createState() => _ViewPlantSimulatedState();
}

class _ViewPlantSimulatedState extends State<ViewPlantSimulatedWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [widget.equipamento],
            ),
            Container(
              width: 200,
              height: 1200,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
