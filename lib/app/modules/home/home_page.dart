import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:framework/ui/bottomnavigation/fab_bottom_app_bar.dart';
import 'package:framework/ui/bottomnavigation/fab_with_icons.dart';
import 'package:framework/ui/bottomnavigation/layout.dart';
import 'package:login/app/shared/styles/main_style.dart';

import 'components/item/item_widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    tabController.animateTo(index);

    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }

  static TabController tabController;
  static int tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
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
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                children: <Widget>[
                                  //#HEADER
                                  Container(
                                    //   margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: AspectRatio(
                                      aspectRatio: 100 / 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0XFF2184AA),
                                            borderRadius: new BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0))),
                                        child: Column(
                                          // mainAxisAlignment
                                          children: <Widget>[
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Text(
                                              'App Soleads',
                                              style: heading16Bold.copyWith(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Olá, Heitor Klaus!',
                                                    style: ubuntu16WhiteBold500,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'S.Klaus Serviços Elétricos - Integrador Premium',
                                                    style:
                                                        ubuntu14WhiteLight100,
                                                  )
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 3 / 3,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  // Box decoration takes a gradient
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius:
                                                          4, // has the effect of softening the shadow
                                                      spreadRadius:
                                                          0.2, // has the effect of extending the shadow
                                                      offset: Offset(
                                                        -1, // horizontal, move right 10
                                                        1, // vertical, move down 10
                                                      ),
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'lib/app/shared/assets/icons/hammer.png',
                                                    width: 32,
                                                  ),
                                                  Text(
                                                    'Leads',
                                                    style: museo14Sky700,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '142',
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  // Box decoration takes a gradient
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius:
                                                          4, // has the effect of softening the shadow
                                                      spreadRadius:
                                                          0.2, // has the effect of extending the shadow
                                                      offset: Offset(
                                                        -1, // horizontal, move right 10
                                                        1, // vertical, move down 10
                                                      ),
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'lib/app/shared/assets/icons/negociating.png',
                                                    width: 32,
                                                  ),
                                                  Text(
                                                    'Negociando ',
                                                    style: museo14Sky700,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '15',
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius:
                                                          4, // has the effect of softening the shadow
                                                      spreadRadius:
                                                          0.2, // has the effect of extending the shadow
                                                      offset: Offset(
                                                        -1, // horizontal, move right 10
                                                        1, // vertical, move down 10
                                                      ),
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'lib/app/shared/assets/icons/closed.png',
                                                    width: 32,
                                                  ),
                                                  Text(
                                                    'Fechados ',
                                                    style: museo14Sky700,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '15',
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
              Text('teste'),
              Text('teste'),
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
        onPressed: () {
          Navigator.pushNamed(context, '/simulator');
        },
        tooltip: 'Incrsdement',
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
            onIconTapped: _selectedFab,
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
