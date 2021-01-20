import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:framework/ui/bottomnavigation/fab_bottom_app_bar.dart';
import 'package:framework/ui/bottomnavigation/fab_with_icons.dart';
import 'package:framework/ui/bottomnavigation/layout.dart';
import 'package:login/app/app_module.dart';
import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/styles/main_colors.dart';
import 'package:login/app/shared/styles/main_style.dart';
import 'package:login/app/shared/utils/database_helper.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> with SingleTickerProviderStateMixin {
  void _selectedTab(int index) {
    tabController.animateTo(index);

    if (index == 2) Modular.to.pushNamed('/simulator-edit');
  }

  static TabController tabController;
  Future<Database> get db => DatabaseHelper.getInstance().db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    controller.getBudgets();
    controller.getLeads();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MainColors.cielo, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      body: DefaultTabController(
          length: 4,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: LayoutBuilder(
                        builder: (context, constraint) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //#HEADER
                                  Container(
                                    //   margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: AspectRatio(
                                      aspectRatio: 100 / 45,
                                      child: Container(
                                        decoration: BoxDecoration(color: Color(0XFF2184AA), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          // mainAxisAlignment
                                          children: <Widget>[
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                Text('Solead', style: ubuntu16WhiteBold500.copyWith(color: Colors.white, fontSize: 18)),
                                                FutureBuilder(
                                                  future: DatabaseHelper().checkVersionLocal(),
                                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                                    switch (snapshot.connectionState) {
                                                      case ConnectionState.waiting:
                                                        return CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                        );
                                                      default:
                                                        if (snapshot.hasError)
                                                          return Text('${snapshot.error}');
                                                        else
                                                          return Text(
                                                            '  ( versão: ${snapshot.data.toString()} )',
                                                            style: ubuntu16WhiteBold500.copyWith(fontSize: 10),
                                                          );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 16, top: 5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(top: 15),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            FutureBuilder<String>(
                                                              future: AuthRepository().getName(),
                                                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                                switch (snapshot.connectionState) {
                                                                  case ConnectionState.waiting:
                                                                    return CircularProgressIndicator(
                                                                      strokeWidth: 1,
                                                                    );
                                                                  default:
                                                                    if (snapshot.hasError)
                                                                      return Text('${snapshot.error}');
                                                                    else
                                                                      return Text(
                                                                        'Olá, ${snapshot.data.toString()}!',
                                                                        style: ubuntu16WhiteBold500,
                                                                      );
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(right: 13),
                                                        alignment: Alignment.centerRight,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.all(5),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  border: Border.all(
                                                                    color: Colors.white,
                                                                  ),
                                                                  borderRadius: BorderRadius.all(Radius.circular(100))),
                                                              child: Image.asset(
                                                                'lib/app/shared/assets/images/l.png',
                                                                width: 34,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    'Saldo em comissões',
                                                    style: ubuntu16WhiteBold500,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          FutureBuilder(
                                                            future: AuthRepository().getDataUser(),
                                                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                                                              switch (snapshot.connectionState) {
                                                                case ConnectionState.waiting:
                                                                  return Container(
                                                                    margin: EdgeInsets.only(top: 7),
                                                                    width: 22,
                                                                    height: 22,
                                                                    child: CircularProgressIndicator(
                                                                      strokeWidth: 2,
                                                                      backgroundColor: Colors.white,
                                                                    ),
                                                                  );
                                                                default:
                                                                  if (snapshot.hasError)
                                                                    return Text(
                                                                      'R\$ 0,00',
                                                                      style: ubuntu35WhiteLight100,
                                                                    );
                                                                  else
                                                                    return Container(
                                                                      margin: EdgeInsets.only(top: 5),
                                                                      child: Text(
                                                                        '${snapshot.data.cash}',
                                                                        style: ubuntu35WhiteLight100,
                                                                      ),
                                                                    );
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        children: [
                                                          SizedBox(height: 8),
                                                          Text(
                                                            'Transferir',
                                                            style: TextStyle(fontSize: 10, color: Colors.green[200]),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: controller.logoff,
                                                            child: Icon(
                                                              Icons.exit_to_app,
                                                              color: Colors.white,
                                                              size: 22,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 25),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //# CLIENT STATUS
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Modular.to.pushNamed('/simulator-edit', arguments: {'tipo': 'budgets'});
                                            },
                                            child: AspectRatio(
                                              aspectRatio: 3 / 3,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                    // Box decoration takes a gradient
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 4, // has the effect of softening the shadow
                                                        spreadRadius: 0.2, // has the effect of extending the shadow
                                                        offset: Offset(
                                                          -1, // horizontal, move right 10
                                                          1, // vertical, move down 10
                                                        ),
                                                      ),
                                                    ]),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text('Orçamentos'),
                                                    SizedBox(
                                                      height: 18,
                                                    ),
                                                    Icon(
                                                      Icons.description,
                                                      color: MainColors.cielo[400],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Observer(builder: (BuildContext context) {
                                                      if (controller.loadingBudgets == '0') {
                                                        return Center(
                                                          child: Container(
                                                            height: 10,
                                                            width: 10,
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 1,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Text(
                                                          controller.loadingBudgets.toString(),
                                                          style: heading16Bold.copyWith(fontSize: 15),
                                                        );
                                                      }
                                                    }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 3 / 3,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  // Box decoration takes a gradient
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4, // has the effect of softening the shadow
                                                      spreadRadius: 0.2, // has the effect of extending the shadow
                                                      offset: Offset(
                                                        -1, // horizontal, move right 10
                                                        1, // vertical, move down 10
                                                      ),
                                                    ),
                                                  ]),
                                              child: InkWell(
                                                onTap: () {
                                                  DateTime now = DateTime.now();
                                                  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

                                                  print(formattedDate);
                                                },
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text('Negociando'),
                                                    SizedBox(
                                                      height: 18,
                                                    ),
                                                    Icon(
                                                      Icons.whatshot,
                                                      color: MainColors.danger[300],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Observer(builder: (BuildContext context) {
                                                      if (controller.loadingLeads == '0') {
                                                        return Center(
                                                          child: Container(
                                                            height: 10,
                                                            width: 10,
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 1,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Text(
                                                          controller.loadingLeads.toString(),
                                                          style: heading16Bold.copyWith(fontSize: 15),
                                                        );
                                                      }
                                                    }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 3 / 3,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4, // has the effect of softening the shadow
                                                      spreadRadius: 0.2, // has the effect of extending the shadow
                                                      offset: Offset(
                                                        -1, // horizontal, move right 10
                                                        1, // vertical, move down 10
                                                      ),
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Fechados'),
                                                  SizedBox(
                                                    height: 18,
                                                  ),
                                                  Icon(
                                                    Icons.wb_sunny,
                                                    color: Colors.yellow[600],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Observer(builder: (BuildContext context) {
                                                    if (controller.loadingLeads == '0') {
                                                      return Center(
                                                        child: Container(
                                                          height: 10,
                                                          width: 10,
                                                          child: CircularProgressIndicator(
                                                            strokeWidth: 1,
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                        controller.loadingLeads.toString(),
                                                        style: heading16Bold.copyWith(fontSize: 15),
                                                      );
                                                    }
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  FutureBuilder(
                                    future: Prefs.getString("ROLE"),
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return CircularProgressIndicator(
                                            strokeWidth: 1,
                                          );
                                        default:
                                          if (snapshot.hasError)
                                            return Text('${snapshot.error}');
                                          else if (snapshot.data == 'ROLE_ADMIN')
                                            return Container(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Modular.to.pushNamed('/plants', arguments: {'tipo': 'leads'});
                                                      },
                                                      child: AspectRatio(
                                                        aspectRatio: 3.2 / 3.2,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(20.0),
                                                              ),
                                                              color: Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors.black12,
                                                                  blurRadius: 4, // has the effect of softening the shadow
                                                                  spreadRadius: 0.2, // has the effect of extending the shadow
                                                                  offset: Offset(
                                                                    -1, // horizontal, move right 10
                                                                    1, // vertical, move down 10
                                                                  ),
                                                                ),
                                                              ]),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Text('Leads Vendas'),
                                                              SizedBox(
                                                                height: 18,
                                                              ),
                                                              Icon(
                                                                Icons.wysiwyg,
                                                                color: Colors.black,
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Observer(builder: (BuildContext context) {
                                                                if (controller.loadingLeads == '0') {
                                                                  return Center(
                                                                    child: Container(
                                                                      height: 10,
                                                                      width: 10,
                                                                      child: CircularProgressIndicator(
                                                                        strokeWidth: 1,
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                    controller.loadingLeads.toString(),
                                                                    style: heading16Bold.copyWith(fontSize: 15),
                                                                  );
                                                                }
                                                              }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  //  Spacer(),
                                                  Spacer(),
                                                  Spacer(),
                                                ],
                                              ),
                                            );
                                          else
                                            return Spacer();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                ],
              ),
              Text('teste'),

              //# INICIO DOS LEADS PAGINA
              Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: LayoutBuilder(
                        builder: (context, constraint) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                children: <Widget>[
                                  //#HEADER
                                  Container(
                                    //   margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: AspectRatio(
                                      aspectRatio: 100 / 45,
                                      child: Container(
                                        decoration: BoxDecoration(color: Color(0XFF2184AA), borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          // mainAxisAlignment
                                          children: <Widget>[
                                            SizedBox(
                                              height: 60,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'App Soleads',
                                                  style: heading16Bold.copyWith(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 30),
                                                Text(
                                                  'Suas Plantas Orçadas',
                                                  style: heading16Bold.copyWith(color: Colors.white, fontSize: 25),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //# CLIENT STATUS
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 3 / 3,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  // Box decoration takes a gradient
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4, // has the effect of softening the shadow
                                                      spreadRadius: 0.2, // has the effect of extending the shadow
                                                      offset: Offset(
                                                        -1, // horizontal, move right 10
                                                        1, // vertical, move down 10
                                                      ),
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Leads'),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.account_box,
                                                      color: Colors.blue,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '0',
                                                    style: heading16Bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 3 / 3,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  // Box decoration takes a gradient
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4, // has the effect of softening the shadow
                                                      spreadRadius: 0.2, // has the effect of extending the shadow
                                                      offset: Offset(
                                                        -1, // horizontal, move right 10
                                                        1, // vertical, move down 10
                                                      ),
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Negociando'),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.whatshot,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '0',
                                                    style: heading16Bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 3 / 3,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4, // has the effect of softening the shadow
                                                      spreadRadius: 0.2, // has the effect of extending the shadow
                                                      offset: Offset(
                                                        -1, // horizontal, move right 10
                                                        1, // vertical, move down 10
                                                      ),
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Fechados'),
                                                  IconButton(
                                                    icon: Icon(Icons.wb_sunny, color: Colors.yellow[700]),
                                                    onPressed: () {},
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '0',
                                                    style: heading16Bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                ],
              ),
              Text('teste')
            ],
          )),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'A',
        color: Colors.grey,
        selectedColor: Theme.of(context).primaryColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'home'),
          FABBottomAppBarItem(iconData: Icons.calendar_today, text: 'agenda'),
          FABBottomAppBarItem(iconData: Icons.people, text: 'leads'),
          FABBottomAppBarItem(iconData: Icons.menu, text: 'menu'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Modular.to.pushNamed('/simulator');
        },
        tooltip: 'Simulator',
        child: Icon(Icons.add),
        elevation: 2.0,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          print('ACTION');
        },
        tooltip: 'Incrsdement',
        child: Icon(Icons.hot_tub),
        elevation: 2.0,
      ),
    );
  }
}
