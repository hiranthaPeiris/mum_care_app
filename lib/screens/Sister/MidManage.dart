import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:mun_care_app/widgets/Menu_card.dart';

class MidManage extends StatefulWidget {
  MidManage({Key key}) : super(key: key);

  @override
  _MidManageState createState() => _MidManageState();
}

class _MidManageState extends State<MidManage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: Bottom_nav(
        scaffoldKey: _scaffoldKey,
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 50.0),
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Manage Midwives",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                          delegate: SliverChildListDelegate([
                            Menu_card(
                              title: "View midwife leave requests",
                              heading: "Midwife Leaving",
                              svgSrc: "assets/icons/yoga.svg",
                              press: () {
                                Navigator.pushNamed(context, '/midLeaveView');
                              },
                            ),
                            Menu_card(
                              title: "View Midwives Duty",
                              heading: "Midwife Duty",
                              svgSrc: "assets/icons/yoga.svg",
                              press: () {
                                Navigator.pushNamed(context, '/midDuty');
                              },
                            ),
                            Menu_card(
                              title: "Add new midwife to the area",
                              heading: "Add Midwife",
                              svgSrc: "assets/icons/yoga.svg",
                              press: () {
                                Navigator.pushNamed(context, '/addMid');
                              },
                            ),
                          ]),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .85,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ))
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
