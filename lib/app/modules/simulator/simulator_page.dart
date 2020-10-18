import 'package:date_util/date_util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:framework/config/main_colors.dart';
import 'package:framework/config/styles/button_styles.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:framework/ui/form/buttons/secondary_button.dart';
import 'package:framework/ui/form/inputs/input_type.dart';
import 'package:framework/ui/form/inputs/outlined_dropdown.dart';
import 'package:framework/ui/form/inputs/outlined_text_edit.dart';
import 'package:login/app/modules/simulator/simulator_module.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/proposal_strings.dart';
import 'package:login/app/shared/repositories/proposal_strings.dart';

import 'package:login/app/shared/styles/main_colors.dart' as main;
import 'package:login/app/shared/styles/main_style.dart';
import 'simulator_controller.dart';

class SimulatorPage extends StatefulWidget {
  final String title;
  final int qtd;
  final String mode;
  SimulatorPage({Key key, this.title = "Simulator", this.qtd, this.mode}) : super(key: key);

  @override
  _SimulatorPageState createState() => _SimulatorPageState();
}

class _SimulatorPageState extends ModularState<SimulatorPage, SimulatorController> {
  //use 'controller' variable to access controller
  bool isChecked = false;
  bool isVisible = false;

  static var dateUtility = DateUtil();

  @override
  void dispose() {
    super.dispose();
    print('saiu do simulat');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: main.MainColors.cielo, //or set color with: Color(0xFF0000FF)
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.mode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Simulador de proposta",
          style: ubuntu17WhiteBold500,
        ),
      ),
      body: widget.mode == 'insert' ? buildInsert() : buildEdit(),
    );
  }

  Stack buildInsert() {
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
                                                onTap: () {
                                                  controller.clearMoney();
                                                },
                                                controller: controller.mediaKW,
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
                                                controller: controller.mediaMoney,
                                                keyboardType: TextInputType.number,
                                                onTap: () {
                                                  controller.clearKW();
                                                },
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
                                                controller: controller.potencia,
                                                keyboardType: TextInputType.number,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                                label: "Potência ",
                                                inputType: InputType.EXTRA_SMALL,
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
                                                controller: controller.potenciaIndicada1,
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
                                                controller: controller.valorKit1,
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
                                                  if (controller.disableAdd) {
                                                    return PrimaryButton(
                                                      child: Icon(Icons.assignment),
                                                      onPressed: null,
                                                      //onPressed:controller.loginWithGoogle,
                                                    ).getLarge();
                                                  } else {
                                                    return PrimaryButton(
                                                      child: Icon(Icons.assignment),
                                                      onPressed: () {
                                                        controller.showDialogKitMenor(context);
                                                      },
                                                      //onPressed:controller.loginWithGoogle,
                                                    ).getLarge();
                                                  }
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
                                                controller: controller.potenciaIndicada2,
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
                                                controller: controller.valorKit2,
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
                                                  if (controller.disableAdd) {
                                                    return PrimaryButton(
                                                      child: Icon(Icons.assignment),
                                                      onPressed: null,
                                                      //onPressed:controller.loginWithGoogle,
                                                    ).getLarge();
                                                  } else {
                                                    return PrimaryButton(
                                                      child: Icon(Icons.assignment),
                                                      onPressed: () {
                                                        controller.showDialogKitMaior(context);
                                                      },
                                                      //onPressed:controller.loginWithGoogle,
                                                    ).getLarge();
                                                  }
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

  buildEdit() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Propostas Simuladas',
                style: ubuntu16BlackBold500.copyWith(fontSize: 20, color: Colors.black87),
              ),
              Text(
                '45 registros(s)',
                style: ubuntu16BlackBold500.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: new Divider(
            color: Colors.black38,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SecondaryButton(
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.black38),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Filtrar',
                        style: buttonLargeBlue.copyWith(color: Colors.black38),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  //onPressed:controller.loginWithGoogle,

                  onPressed: () {
                    Modular.to.pushReplacementNamed('/');
                  },
                ).getLarge(),
                SizedBox(width: 50),
                SecondaryButton(
                  child: Row(
                    children: [
                      Icon(Icons.vibration, color: Colors.black38),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Ordernar',
                        style: buttonLargeBlue.copyWith(color: Colors.black38),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  //onPressed:controller.loginWithGoogle,

                  onPressed: () {
                    Modular.to.pushReplacementNamed('/');
                  },
                ).getLarge(),
              ],
            )),
        buildItemPlant(),
        buildItemPlant(),
        buildItemPlant(),
        buildItemPlant(),
      ],
    );
  }

  buildItemPlant() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
            child: new Divider(
              color: Colors.black38,
            ),
          ),
          InkWell(
            onTap: () {
              controller.showDialogEditStep1(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.offline_bolt, color: Colors.blue[300]),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Carlos da Silva ',
                    style: buttonLargeBlue.copyWith(color: Colors.black38),
                  ),
                  Spacer(),
                  Text(
                    '12,6 kWp',
                    style: buttonLargeBlue.copyWith(color: Colors.black38),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '10/09/2019',
                  style: buttonLargeBlue.copyWith(color: Colors.black38, fontWeight: FontWeight.normal),
                ),
                Spacer(),
                Text(
                  'R\$ 25.651,12',
                  style: buttonLargeBlue.copyWith(color: Colors.blue[500], fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
