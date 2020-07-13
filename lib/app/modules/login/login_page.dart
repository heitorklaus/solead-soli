import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:framework/ui/form/inputs/outlined_text_edit.dart';
import 'package:login/app/modules/home/home_controller.dart';
import 'package:login/app/shared/styles/main_style.dart';
//controller.loginWithGoogle

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF3DBAEB),
                      const Color(0xFF2184AA),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Image.asset(
                                'lib/app/shared/assets/images/logo1.png',
                                width: 150,
                              ),
                              color: Colors.transparent,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(0),
                            child: AspectRatio(
                              aspectRatio: 100 / 90,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius:
                                            3, // has the effect of softening the shadow
                                        spreadRadius:
                                            0.2, // has the effect of extending the shadow
                                        offset: Offset(
                                          0, // horizontal, move right 10
                                          -3, // vertical, move down 10
                                        ),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topRight: Radius.circular(33.0),
                                      topLeft: Radius.circular(33.0),
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // mainAxisAlignment

                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 32),
                                            child: Text(
                                              'Entrar no aplicativo',
                                              style: heading16Bold,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 32),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: OutlinedTextEdit(
                                                  controller:
                                                      controller.username,
                                                  onChanged: (value) => {},
                                                  label: "Dígite seu usuário",
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 32),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: OutlinedTextEdit(
                                                  obscureText: true,
                                                  controller:
                                                      controller.password,
                                                  onChanged: (value) => {},
                                                  label: "Dígite sua senha",
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Observer(builder: (BuildContext context) {
                                      if (controller.loading == false) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 32, vertical: 16),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: PrimaryButton(
                                                  child: Text(
                                                    'Entrar',
                                                    style: buttonLargeWhite,
                                                  ),
                                                  //onPressed:controller.loginWithGoogle,

                                                  onPressed:
                                                      controller.disableAdd
                                                          ? null
                                                          : controller.loginApi,
                                                ).getLarge(),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                                    InkWell(
                                      onTap: () async {
                                        HomeController().getDataLogin();
                                      },
                                      child: Container(
                                          child: Text(
                                        'Esqueceu sua senha?',
                                        style: museo14Sky700,
                                      )),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
