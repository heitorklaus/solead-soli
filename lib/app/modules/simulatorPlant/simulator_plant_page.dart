import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:framework/ui/form/inputs/input_type.dart';
import 'package:framework/ui/form/inputs/outlined_text_edit.dart';
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
        body: buildFormSimulator());
  }

  Stack buildFormSimulator() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('lib/app/shared/assets/images/bg.jpg'),
            fit: BoxFit.cover,
          )),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3, // has the effect of softening the shadow
                            spreadRadius: 0.2, // has the effect of extending the shadow
                            offset: Offset(
                              0, // horizontal, move right 10
                              -3, // vertical, move down 10
                            ),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(0.0),
                          bottomLeft: Radius.circular(0.0),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisAlignment

                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Observer(builder: (BuildContext context) {
                              return Container(
                                height: 307,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                              width: 100,
                                              height: 50,
                                              child: OutlinedTextEdit(
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(bottom: 10, left: 8),
                                                  hintText: "Média kWp",
                                                  hintStyle: TextStyle(fontSize: 12.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius: const BorderRadius.all(
                                                      const Radius.circular(10.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.teal,
                                                    ),
                                                  ),
                                                ),
                                                keyboardType: TextInputType.number,
                                                onTap: controller.clearKwh,
                                                controller: controller.inputKwh,
                                                inputType: InputType.EXTRA_SMALL,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Container(
                                              width: 100,
                                              height: 50,
                                              child: OutlinedTextEdit(
                                                controller: controller.inputR$,
                                                keyboardType: TextInputType.number,
                                                onTap: controller.clearR$,
                                                inputType: InputType.EXTRA_SMALL,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(bottom: 10, left: 13),
                                                  hintText: "Média R\$",
                                                  hintStyle: TextStyle(fontSize: 12.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius: const BorderRadius.all(
                                                      const Radius.circular(10.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.teal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Container(
                                              width: 125,
                                              child: OutlinedTextEdit(
                                                prefixIcon: Icon(Icons.equalizer),
                                                keyboardType: TextInputType.number,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                                label: "Potência ",
                                                inputType: InputType.EXTRA_SMALL,
                                                controller: controller.inputPotenciaNecessaria,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.equalizer,
                                              size: 20,
                                              textDirection: TextDirection.ltr,
                                            ),
                                            Text(
                                              '  Potência/Kit indicado (Opção 1)',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8, bottom: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                              width: 120,
                                              child: OutlinedTextEdit(
                                                controller: controller.inputPotenciaIndicadaMenor,
                                                keyboardType: TextInputType.number,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                                label: "Potência",
                                                inputType: InputType.EXTRA_SMALL,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 165,
                                              child: OutlinedTextEdit(
                                                controller: controller.inputValorKitMenor,
                                                prefixIcon: Icon(Icons.monetization_on),
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) => {},
                                                label: "R\$ Valor",
                                                readOnly: true,
                                                inputType: InputType.EXTRA_SMALL,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 65,
                                              child: Observer(
                                                builder: (BuildContext context) {
                                                  return PrimaryButton(
                                                    child: Icon(Icons.assignment),
                                                    onPressed: () {},
                                                    //onPressed:controller.loginWithGoogle,
                                                  ).getLarge();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 0, bottom: 0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.equalizer,
                                              size: 20,
                                              textDirection: TextDirection.ltr,
                                            ),
                                            Text(
                                              '  Potência/Kit indicado (Opção 2)',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                              width: 120,
                                              child: OutlinedTextEdit(
                                                controller: controller.inputPotenciaIndicadaMaior,
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) => {},
                                                readOnly: true,
                                                label: "Potência",
                                                inputType: InputType.EXTRA_SMALL,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 165,
                                              child: OutlinedTextEdit(
                                                controller: controller.inputValorKitMaior,
                                                prefixIcon: Icon(Icons.monetization_on),
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) => {},
                                                label: "R\$ Valor",
                                                readOnly: true,
                                                inputType: InputType.EXTRA_SMALL,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 65,
                                              child: Observer(
                                                builder: (BuildContext context) {
                                                  return PrimaryButton(
                                                    child: Icon(Icons.assignment),
                                                    onPressed: () {
                                                      // controller.showDialogKitMaior(context);
                                                    },
                                                    //onPressed:controller.loginWithGoogle,
                                                  ).getLarge();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}