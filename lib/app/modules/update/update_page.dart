import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:framework/ui/form/buttons/secondary_button.dart';
import 'package:login/app/shared/styles/main_style.dart';
import 'package:login/app/shared/utils/database_helper.dart';

import 'update_controller.dart';
import 'package:login/app/shared/styles/main_colors.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePage extends StatefulWidget {
  final String title;
  const UpdatePage({Key key, this.title = "Update"}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends ModularState<UpdatePage, UpdateController> {
  //use 'controller' variable to access controller

  Future<bool> _onWillPop() async {
    print('no');
  }

  _launchURL() async {
    const url = DatabaseHelper.updateAppPath;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final stop = Prefs.setString("STOP", "TRUE");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: MainColors.cielo,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 60),
                child: Image.asset(
                  'lib/app/shared/assets/images/l.png',
                  width: 70,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 240,
                    child: Text(
                      'Existe uma nova vesão mais atualizada e com correções para o App Solead!',
                      textAlign: TextAlign.center,
                      style: ubuntu16WhiteBold500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SecondaryButton(
                    child: Text(
                      'Atualizar App...',
                      style: buttonLargeBlue,
                    ),
                    //onPressed:controller.loginWithGoogle,

                    onPressed: () {
                      _launchURL();
                    },
                  ).getLarge(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}