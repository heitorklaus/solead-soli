import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:framework/config/styles/button_styles.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
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
  const SimulatorPage({Key key, this.title = "Simulator", this.qtd})
      : super(key: key);

  @override
  _SimulatorPageState createState() => _SimulatorPageState();
}

class _SimulatorPageState
    extends ModularState<SimulatorPage, SimulatorController> {
  //use 'controller' variable to access controller
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Simulador de Proposta"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child:        Observer(builder: (BuildContext context) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[Text('Informe a média de consumo',style: TextStyle(fontWeight: FontWeight.bold),)],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: OutlinedTextEdit(
                            keyboardType: TextInputType.number,
                            onChanged: (value) => {},
                            prefixIcon: Icon(Icons.pie_chart),
                            controller: controller.media,
                            label: "Média KWp",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[Text('Tipo de entrada',style: TextStyle(fontWeight: FontWeight.bold),)],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                            });
                          },
                        ),
                        Text('Bifasico'),
                        SizedBox(width: 50,),
                         Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                            });
                          },
                        ),
                        Text('Trifasico'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[Text('Custo KWh / Mês',style: TextStyle(fontWeight: FontWeight.bold),)],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: OutlinedTextEdit(
                            initialValue: 'R\$ 0,91',
                            prefixIcon: Icon(Icons.monetization_on),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => {},
                            label: "Custo por KWp",
                          ),
                        ),
                      ],
                    ),
                  ),
                         Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[Text('Potência necessária KWp',style: TextStyle(fontWeight: FontWeight.bold),)],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: OutlinedTextEdit(
                            controller: controller.potencia,
                             prefixIcon: Icon(Icons.equalizer),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => {},
                            label: "Custo por KWp",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            })
          ),
        ),
        bottomNavigationBar: PrimaryButton(
            child: Text(
              'Avançar >>',
              style: buttonLargeWhite,
            ),
            shape: shapeButtonBlock,
            //onPressed:controller.loginWithGoogle,

            onPressed: () async {
              final proposalStrings = ProposalStringsDao();

              final strings = ProposalStrings();

              final token = await AuthRepository().getUser();

              //print(token);

              var dateUtility = DateUtil();
              var day1 = dateUtility.daysInMonth(2, 2019);
              print(day1);

              strings.token = token;
              strings.session = 'SESSAO';
              strings.width = '300';
              strings.height = '400';

              proposalStrings.save(strings);
            }).getLarge());
  }
}
