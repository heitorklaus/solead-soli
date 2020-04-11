import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
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
import 'form/form_widget.dart';
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

  List<Widget> _children = [];
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simulador de Proposta"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (widget.qtd == 0)
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Quantidade de STRINGS?',
                          style: heading16Bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: PrimaryButton(
                                  child: Text(
                                    '1',
                                    style: buttonLargeWhite,
                                  ),
                                  //onPressed:controller.loginWithGoogle,

                                  onPressed: () {})
                              .getLarge(),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                                  child: Text(
                                    '2',
                                    style: buttonLargeWhite,
                                  ),
                                  //onPressed:controller.loginWithGoogle,

                                  onPressed: () {})
                              .getLarge(),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                                  child: Text(
                                    '3',
                                    style: buttonLargeWhite,
                                  ),
                                  //onPressed:controller.loginWithGoogle,

                                  onPressed: () {})
                              .getLarge(),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                              child: Text(
                                '4',
                                style: buttonLargeWhite,
                              ),
                              //onPressed:controller.loginWithGoogle,

                              onPressed: () {
                                Modular.to.push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SimulatorPage(
                                          qtd: 4,
                                        )));
                              }).getLarge(),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                              child: Text(
                                '5',
                                style: buttonLargeWhite,
                              ),
                              //onPressed:controller.loginWithGoogle,

                              onPressed: () {
                                Modular.to.push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SimulatorPage(
                                          qtd: 5,
                                        )));
                              }).getLarge(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: PrimaryButton(
                                  child: Text(
                                    '6',
                                    style: buttonLargeWhite,
                                  ),
                                  //onPressed:controller.loginWithGoogle,

                                  onPressed: () {})
                              .getLarge(),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                                  child: Text(
                                    '7',
                                    style: buttonLargeWhite,
                                  ),
                                  //onPressed:controller.loginWithGoogle,

                                  onPressed: () {})
                              .getLarge(),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                                  child: Text(
                                    '8',
                                    style: buttonLargeWhite,
                                  ),
                                  //onPressed:controller.loginWithGoogle,

                                  onPressed: () {})
                              .getLarge(),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                                  child: Text(
                                    '9',
                                    style: buttonLargeWhite,
                                  ),
                                  //onPressed:controller.loginWithGoogle,

                                  onPressed: () {})
                              .getLarge(),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                                  child: Text(
                                    '10',
                                    style: buttonLargeWhite,
                                  ),
                                  //onPressed:controller.loginWithGoogle,

                                  onPressed: () {})
                              .getLarge(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: OutlinedTextEdit(
                  //           onChanged: (value) => {},
                  //           label: "Comprimento",
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       Expanded(
                  //         child: OutlinedTextEdit(
                  //           onChanged: (value) => {},
                  //           label: "Largura",
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  //   child: Expanded(
                  //     child: OutlinedDropdown<String>(
                  //       hint: Padding(
                  //         padding: EdgeInsets.only(left: 8),
                  //         child: Text(
                  //           'Direção',
                  //         ),
                  //       ),
                  //       items: <String>[
                  //         'NORTE',
                  //         'NORDESTE',
                  //         'NOROESTE',
                  //         'SUL',
                  //         'SUDESTE',
                  //         'SUDOESTE',
                  //       ].map((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //       onChanged: (value) {},
                  //     ),
                  //   ),
                  // )
                ],
              ),
            FormWidget(
              qtd: widget.qtd,
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.qtd > 0
          ? PrimaryButton(
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
              }).getLarge()
          : null,
    );
  }
}
