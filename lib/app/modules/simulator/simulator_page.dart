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
  const SimulatorPage({Key key, this.title = "Simulator", this.qtd}) : super(key: key);

  @override
  _SimulatorPageState createState() => _SimulatorPageState();
}

class _SimulatorPageState extends ModularState<SimulatorPage, SimulatorController> {
  //use 'controller' variable to access controller
  bool isChecked = false;
  bool isVisible = false;

  static var dateUtility = DateUtil();

// The entire multilevel list displayed by this app.
// final List<Entry> data = <Entry>[
//   Entry(
//     'Geração Kwh/Mês',
//     <Entry>[
//       Entry('Janeiro: ' + dateUtility.daysInMonth(1, 2020).toString()),
//       Entry('Fevereiro: ' + dateUtility.daysInMonth(2, 2020).toString()),
//       Entry('Março: ' + dateUtility.daysInMonth(3, 2020).toString()),
//       Entry('Abril: ' + dateUtility.daysInMonth(4, 2020).toString()),
//       Entry('Maio: ' + dateUtility.daysInMonth(5, 2020).toString()),
//       Entry('Junho: ' + dateUtility.daysInMonth(6, 2020).toString()),
//       Entry('Julho: ' + dateUtility.daysInMonth(7, 2020).toString()),
//       Entry('Agosto: ' + dateUtility.daysInMonth(8, 2020).toString()),
//       Entry('Setembro: ' + dateUtility.daysInMonth(9, 2020).toString()),
//       Entry('Outubro: ' + dateUtility.daysInMonth(10, 2020).toString()),
//       Entry('Novembro: ' + dateUtility.daysInMonth(11, 2020).toString()),
//       Entry('Dezembro: ' + dateUtility.daysInMonth(12, 2020).toString()),
//     ],
//   ),
// ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Simulador de proposta",
          style: ubuntu17WhiteBold500,
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Image.asset(
              'lib/app/shared/assets/images/l.png',
              width: 40,
            ),
            color: Colors.transparent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Observer(builder: (BuildContext context) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedTextEdit(
                            keyboardType: TextInputType.number,
                            onTap: () {
                              controller.clearMoney();
                            },
                            prefixIcon: Icon(Icons.pie_chart),
                            controller: controller.mediaKW,
                            label: "Média KWp",
                          ),
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Expanded(
                          child: OutlinedTextEdit(
                            controller: controller.mediaMoney,
                            prefixIcon: Icon(Icons.monetization_on),
                            keyboardType: TextInputType.number,
                            onTap: () {
                              controller.clearKW();
                            },
                            label: "Média R\$",
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 20),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Text(
                  //         'Tipo de entrada',
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 0),
                  //   child: Row(
                  //     children: <Widget>[
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       Checkbox(
                  //         value: isChecked,
                  //         onChanged: (value) {
                  //           setState(() {
                  //             isChecked = value;
                  //           });
                  //         },
                  //       ),
                  //       Text('Bifasico'),
                  //       SizedBox(
                  //         width: 50,
                  //       ),
                  //       Checkbox(
                  //         value: isChecked,
                  //         onChanged: (value) {
                  //           setState(() {
                  //             isChecked = value;
                  //           });
                  //         },
                  //       ),
                  //       Text('Trifasico'),
                  //     ],
                  //   ),
                  // ),
                  // InkWell(
                  //   child: Text('Geração Mes a Mes'),
                  //   onTap: () {
                  //     setState(() {
                  //       isVisible = !isVisible;
                  //     });
                  //   },
                  // ),
                  // SingleChildScrollView(
                  //   physics: ScrollPhysics(),
                  //   child: Visibility(
                  //     visible: isVisible,
                  //     child: Column(
                  //       children: <Widget>[
                  //         SizedBox(
                  //           height: 20,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  //             Text('Janeiro: Dias '),
                  //             Text(dateUtility
                  //                 .daysInMonth(1, 2020)
                  //                 .toString()),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 20),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Text(
                  //         'Custo KWh / Mês',
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 20),
                  //   child: Row(
                  //     children: <Widget>[
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       Expanded(
                  //         child: OutlinedTextEdit(
                  //           initialValue: 'R\$ 0,91',
                  //           prefixIcon: Icon(Icons.monetization_on),
                  //           keyboardType: TextInputType.number,
                  //           onChanged: (value) => {},
                  //           label: "Custo por KWp",
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 20),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Text(
                  //         'Potência necessária KWp',
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       )
                  //     ],
                  //   ),
                  // ),

                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedTextEdit(
                            controller: controller.potencia,
                            prefixIcon: Icon(Icons.equalizer),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => {},
                            label: "Potência necessária",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Potência/Kit indicado (Opção 1)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 130,
                          child: OutlinedTextEdit(
                            controller: controller.potenciaIndicada1,
                            prefixIcon: Icon(Icons.equalizer),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => {},
                            label: "Potência",
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: OutlinedTextEdit(
                            controller: controller.valorKit1,
                            prefixIcon: Icon(Icons.monetization_on),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => {},
                            label: "R\$ Valor",
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
                                  child: Text(
                                    'Ver',
                                    style: buttonLargeWhite,
                                  ),
                                  onPressed: null,
                                  //onPressed:controller.loginWithGoogle,
                                ).getLarge();
                              } else {
                                return PrimaryButton(
                                  child: Text(
                                    'ver',
                                    style: buttonLargeWhite,
                                  ),
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
                    height: 10,
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Potência/Kit indicado (Opção 2)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 130,
                          child: OutlinedTextEdit(
                            controller: controller.potenciaIndicada2,
                            prefixIcon: Icon(Icons.equalizer),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => {},
                            label: "Potência",
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: OutlinedTextEdit(
                            controller: controller.valorKit2,
                            prefixIcon: Icon(Icons.monetization_on),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => {},
                            label: "R\$ Valor",
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
                                  child: Text(
                                    'Ver',
                                    style: buttonLargeWhite,
                                  ),
                                  onPressed: null,
                                  //onPressed:controller.loginWithGoogle,
                                ).getLarge();
                              } else {
                                return PrimaryButton(
                                  child: Text(
                                    'ver',
                                    style: buttonLargeWhite,
                                  ),
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
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            })),
      ),
      // bottomNavigationBar: PrimaryButton(
      //     child: Text(
      //       'Avançar >>',
      //       style: buttonLargeWhite,
      //     ),
      //     shape: shapeButtonBlock,
      //     //onPressed:controller.loginWithGoogle,

      //     onPressed: () async {
      //       var dateUtility = DateUtil();
      //       var now = new DateTime.now();
      //       var day1 = dateUtility.daysInMonth(2, now.year);

      //       //controller.getCitiesData(1);

      //       // final proposalStrings = ProposalStringsDao();

      //       // final strings = ProposalStrings();

      //       // final token = await AuthRepository().getUser();

      //       // //print(token);

      //       // var dateUtility = DateUtil();
      //       // var day1 = dateUtility.daysInMonth(2, 2019);
      //       // print(day1);

      //       // strings.token = token;
      //       // strings.session = 'Heitor \n Klaus';
      //       // strings.width = 'Fabricio \n Klaus';

      //       // strings.height = 'Oliviera \n Klaus';

      //       // proposalStrings.save(strings);
      //     }).getLarge());
    );
  }
}
