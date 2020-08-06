import 'package:date_util/date_util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:framework/config/styles/button_styles.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:framework/ui/form/inputs/input_type.dart';
import 'package:framework/ui/form/inputs/outlined_dropdown.dart';
import 'package:framework/ui/form/inputs/outlined_text_edit.dart';
import 'package:login/app/modules/simulator/simulator_module.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/proposal_strings.dart';
import 'package:login/app/shared/repositories/proposal_strings.dart';
import 'package:login/app/shared/styles/main_style.dart';
import 'simulator_controller.dart';

class SimulatorPage extends StatefulWidget {
  final String title;
  final int qtd;
  const SimulatorPage({Key key, this.title = "Simulator", this.qtd}) : super(key: key);

  @override
  _SimulatorPageState createState() => _SimulatorPageState();
}

class _SimulatorPageState extends ModularState<SimulatorPage, SimulatorController> {
  //use 'controller' variable to access controller
  bool isChecked = false;
  bool isVisible = false;

  static var dateUtility = DateUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Simulador de proposta",
          style: ubuntu17WhiteBold500,
        ),
        // actions: <Widget>[
        //   Container(
        //     margin: EdgeInsets.only(right: 15),
        //     child: Image.asset(
        //       'lib/app/shared/assets/images/l.png',
        //       width: 40,
        //     ),
        //     color: Colors.transparent,
        //   ),
        // ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: new AssetImage('lib/app/shared/assets/images/bg.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 200),
                width: 250,
                child: Image.asset('lib/app/shared/assets/images/logo1.png'),
              ),
            ],
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
                                                child: OutlinedTextEdit(
                                                  keyboardType: TextInputType.number,
                                                  onTap: () {
                                                    controller.clearMoney();
                                                  },
                                                  controller: controller.mediaKW,
                                                  label: "Média kWp",
                                                  inputType: InputType.EXTRA_SMALL,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                width: 100,
                                                child: OutlinedTextEdit(
                                                  controller: controller.mediaMoney,
                                                  keyboardType: TextInputType.number,
                                                  onTap: () {
                                                    controller.clearKW();
                                                  },
                                                  inputType: InputType.EXTRA_SMALL,
                                                  label: "Média R\$",
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
                                                'Potência/Kit indicado (Opção 1)',
                                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                                width: 90,
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
                                                width: 170,
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
                                                'Potência/Kit indicado (Opção 2)',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: 90,
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
                                                width: 170,
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
      ),
    );
  }
}
