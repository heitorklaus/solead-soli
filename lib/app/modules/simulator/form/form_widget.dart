import 'package:flutter/material.dart';
import 'package:framework/config/styles/button_styles.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:framework/ui/form/inputs/outlined_dropdown.dart';
import 'package:framework/ui/form/inputs/outlined_text_edit.dart';
import 'package:login/app/shared/styles/main_style.dart';

class FormWidget extends StatelessWidget {
  final int qtd;

  const FormWidget({Key key, this.qtd}) : super(key: key);

  Widget formGeneratedFields(
    qtd,
  ) {
    List<Widget> list = new List<Widget>();

    for (var i = 1; i < qtd + 1; i++) {
      var controllerComprimento = new TextEditingController();
      var controllerLargura = new TextEditingController();

      list.add(Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedTextEdit(
                      controller: controllerComprimento,
                      label: "Comprimento",
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: OutlinedTextEdit(
                      controller: controllerLargura,
                      onChanged: (value) => {},
                      label: "Largura",
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  width: 200,
                  child: OutlinedDropdown<String>(
                    hint: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Direção',
                      ),
                    ),
                    items: <String>[
                      'NORTE',
                      'NORDESTE',
                      'NOROESTE',
                      'SUL',
                      'SUDESTE',
                      'SUDOESTE',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    child: PrimaryButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Registrar',
                            style: buttonLargeWhite,
                          ),
                          Icon(Icons.add_circle_outline)
                        ],
                      ),

                      //onPressed:controller.loginWithGoogle,

                      onPressed: () {
                        print(controllerComprimento.text);
                      },
                    ).getLarge(),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ));
    }
    return Column(
      children: <Widget>[
        new Column(children: list),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        formGeneratedFields(qtd),
      ],
    );
  }
}
