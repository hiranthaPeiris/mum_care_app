import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:mun_care_app/widgets/FirebaseMessageWapper.dart';
import 'package:mun_care_app/widgets/Menu_card.dart';
import 'package:mun_care_app/widgets/Menu_linear_card.dart';
import 'package:mun_care_app/widgets/Search_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

AuthService _authService = AuthService();

class _DashboardState extends State<Dashboard> {
  int notificationCount = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool pending = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return pending
        ? Loading()
        : Scaffold(
            key: _scaffoldKey,
            endDrawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(child: Text("Settings")),
                  ListTile(
                    title: Text("Sign out"),
                    onTap: () async {
                      setState(() {
                        pending = true;
                      });
                      dynamic result = await _authService.SignOut();
                      setState(() {
                        result == null
                            ? pending = false
                            : print("error sign out");
                      });
                    },
                  )
                ],
              ),
            ),
            bottomNavigationBar: Bottom_nav(scaffoldKey: _scaffoldKey),
            body: FirebaseMessageWapper(Center(
              child: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Container(
                      // Here the height of the container is 45% of our total height
                      height: size.height * .45,
                      decoration: BoxDecoration(
                        color: kBackground,
                        image: DecorationImage(
                          alignment: Alignment.centerLeft,
                          image: AssetImage(
                              "assets/images/undraw_pilates_pur.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: Stack(
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        height: 45,
                                        width: 45,
                                        child: SvgPicture.asset(
                                            "assets/icons/bell.svg",
                                            color: Colors.white)),
                                    notificationCount != 0
                                        ? new Positioned(
                                            right: 5,
                                            top: 0,
                                            child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: new BoxDecoration(
                                                    color: Colors.redAccent,
                                                    shape: BoxShape.circle),
                                                constraints: new BoxConstraints(
                                                    minHeight: 16,
                                                    minWidth: 16),
                                                child: Text(
                                                  '$notificationCount',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )))
                                        : new Container()
                                  ],
                                ),
                                onTap: () => {
                                  Navigator.pushNamed(context, '/notification')
                                },
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF8d3edd),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/profile.svg",
                                        height: 30,
                                        width: 30),
                                  ),
                                  onTap: () => {
                                    Navigator.pushNamed(context, '/profile')
                                  },
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Good Morning",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: kTextColor,
                                fontFamily: "Roboto-Light",
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          Text("Elizabeth",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 36,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w800)),
                          Search_bar(),
                          Expanded(
                              child: CustomScrollView(
                            slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildListDelegate([
                                  Menu_liner_card(
                                      heading: "Complete Registration",
                                      content:
                                          "Complete the competency family registration",
                                      svgSrc: "assets/icons/Hamburger.svg",
                                      press: () {
                                        Navigator.pushNamed(context, '/comReg');
                                      }),
                                  Menu_liner_card(
                                      heading: "Pregnancy Registration",
                                      content:
                                          "Complete the pregnancy registration",
                                      svgSrc: "assets/icons/Hamburger.svg",
                                      press: () {}),
                                ]),
                              ),
                              SliverGrid(
                                  delegate: SliverChildListDelegate([
                                    Menu_card(
                                      title: "View Upcoming Clinics",
                                      heading: "Clinics",
                                      svgSrc: "assets/icons/clinics.svg",
                                      press: () {},
                                    ),
                                    Menu_card(
                                      title: "View Upcoming Home Visits",
                                      heading: "Home Visits",
                                      svgSrc: "assets/icons/home-visits.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/upcomingHomeVisit');
                                      },
                                    ),
                                    Menu_card(
                                      title: "Report private medications",
                                      heading: "Report Medications",
                                      svgSrc: "assets/icons/yoga.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/MedicalReport');
                                      },
                                    ),
                                    Menu_card(
                                      title: "Report leaving residential area",
                                      heading: "Report Leaving",
                                      svgSrc: "assets/icons/yoga.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/leavingReport');
                                      },
                                    ),
                                    Menu_card(
                                      title: "Home visits",
                                      heading: "Schedule Home Visits",
                                      svgSrc:
                                          "assets/icons/home-visits-sch.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/sechHomeVisits');
                                      },
                                    ),
                                    Menu_card(
                                      title: "Clinics",
                                      heading: "Schedule Clinics",
                                      svgSrc: "assets/icons/clinics-sch.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/sechClinics');
                                      },
                                    )
                                  ]),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: .85,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                  ))
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
