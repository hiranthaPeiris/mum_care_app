import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/helpers/enums.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:mun_care_app/widgets/FirebaseMessageWapper.dart';
import 'package:mun_care_app/widgets/Menu_card.dart';
import 'package:mun_care_app/widgets/Menu_linear_card.dart';
import 'package:mun_care_app/widgets/Search_bar.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

AuthService _authService = AuthService();

class _DashboardState extends State<Dashboard> {
  int notificationCount = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool pending = true;
  UserM _user;
  String role = "";
  String name = "null";
  bool compApp = false;
  bool pregApp = false;
  bool compFam = false;
  bool pregMum = false;
  DateTime now;

  @override
  void initState() {
    super.initState();
    //_user = Provider.of<UserM>(context);
    //print(compApp);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _user = Provider.of<UserM>(context);

    _authService.getUserCustomData(_user.uid).then((data) {
      setState(() {
        Map<String, dynamic> customData = data;
        UserM.setCustomData(customData: customData);
        role = customData['role'];
        name = customData['name'];
        compApp = customData['compApp'];
        pregApp = customData['pregApp'];
        compFam = customData['competencyFam'];
        pregMum = customData['PregnanctFam'];

        //print(_user.userCustomData);
        pending = false;
      });
    }).catchError((err) => print(err));
    // } else {
    //   setState(() {
    //     pending = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return pending
        ? Loading()
        : Scaffold(
            key: _scaffoldKey,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
              },
              child: Icon(Icons.chat_rounded),
              backgroundColor: kActiveIconColor,
            ),
            endDrawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(child: Text("MUM & CARE")),
                  ListTile(
                    title: Text("Help"),
                    onTap: () async {},
                  ),
                  ListTile(
                    title: Text("Settings"),
                    onTap: () async {},
                  ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                          Text(name,
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
                              _buildSliverList(context),
                              _buildSliverGrid()
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

  Widget _buildSliverList(BuildContext context) {
    if (role == 'midwife') {
      return SliverList(
        delegate: SliverChildListDelegate([
          Menu_liner_card(
              heading: "Eligible family Reviews",
              content: "You have pending eligible family data to review",
              svgSrc: "assets/icons/Hamburger.svg",
              press: () {
                Navigator.pushNamed(context, '/motherList');
              }),
          Menu_liner_card(
              heading: "Pregnancy Mother Reviews",
              content: "You have pending mother pegnancy data to review",
              svgSrc: "assets/icons/Hamburger.svg",
              press: () {
                Navigator.pushNamed(context, '/motherPregReview');
              }),
        ]),
      );
    } else if (role == 'sister') {
      return SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(
            height: 5.0,
          )
        ]),
      );
    } else {
      if (!compFam && !compApp) {
        return SliverList(
          delegate: SliverChildListDelegate([
            Menu_liner_card(
                heading: "Complete Registration",
                content: "Complete the eligble family registration",
                svgSrc: "assets/icons/Hamburger.svg",
                press: () {
                  Navigator.pushNamed(context, '/comReg');
                }),
          ]),
        );
      } else if (!pregApp && !pregMum) {
        return SliverList(
          delegate: SliverChildListDelegate([
            Menu_liner_card(
                heading: "Pregnancy Registration",
                content: "Complete the pregnancy registration",
                svgSrc: "assets/icons/Hamburger.svg",
                press: () {
                  // set up the buttons
                  Widget cancelButton = FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                  Widget continueButton = FlatButton(
                    child: Text("Continue"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/preReg');
                    },
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("Information"),
                    content: Text(
                        "You only need to register once you have confirmed about your pregnancy.\nDo you want to continue?"),
                    actions: [
                      cancelButton,
                      continueButton,
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }),
          ]),
        );
      } else {
        return SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 5.0,
            )
          ]),
        );
      }
    }
  }

  Widget _buildSliverGrid() {
    if (role == 'midwife') {
      return SliverGrid(
        delegate: SliverChildListDelegate([
          Menu_card(
            title: "View & Schedule Clinics",
            heading: "Clinic",
            svgSrc: "assets/icons/clinics.svg",
            press: () {
              Navigator.pushNamed(context, '/clinicHome',
                  arguments: <String, String>{
                    'switchView': 'Clinic',
                  });
            },
          ),
          Menu_card(
            title: "View & Schedule Home Visit",
            heading: "Home Visits",
            svgSrc: "assets/icons/home-visits.svg",
            press: () {
              Navigator.pushNamed(context, '/clinicHome',
                  arguments: <String, String>{
                    'switchView': 'Home Visits',
                  });
            },
          ),
          Menu_card(
            title: "View Medications & Leaving Reports",
            heading: "Medications & Area Leaving",
            svgSrc: "assets/icons/medi-report.svg",
            press: () {
              Navigator.pushNamed(context, '/MediLeaveWap');
            },
          ),
          Menu_card(
            title: "Apply day leave",
            heading: "Apply Leaving",
            svgSrc: "assets/icons/leaving.svg",
            press: () {
              Navigator.pushNamed(context, '/midLeave');
            },
          ),
          Menu_card(
            title: "Reports",
            heading: "Monthly and Daily Report",
            svgSrc: "assets/icons/home-visits-sch.svg",
            press: () {
              Navigator.pushNamed(context, '/searchReport');
            },
          ),
          Menu_card(
            title: "Send Special and Emergancy Notices",
            heading: "Special Notice",
            svgSrc: "assets/icons/yoga.svg",
            press: () {
              Navigator.pushNamed(context, '/specialNotice');
            },
          ),
        ]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .85,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      );
    }

    //User widgets
    else if (role == 'user') {
      return SliverGrid(
        delegate: SliverChildListDelegate([
          Menu_card(
            title: "View Upcoming Clinics",
            heading: "My Clinic",
            svgSrc: "assets/icons/clinics.svg",
            press: () {
              Navigator.pushNamed(context, '/UpcomingClinics');
            },
          ),
          Menu_card(
            title: "View Upcoming Home Visit",
            heading: "My Home Visit",
            svgSrc: "assets/icons/home-visits.svg",
            press: () {
              Navigator.pushNamed(
                context,
                '/viewupcominghomevisit',
              );
            },
          ),
          Menu_card(
            title: "Report private medications",
            heading: "Report Medications",
            svgSrc: "assets/icons/medi-report.svg",
            press: () {
              Navigator.pushNamed(context, '/MedicalReport');
            },
          ),
          Menu_card(
            title: "Report leaving residential area",
            heading: "Report Leaving",
            svgSrc: "assets/icons/leaving.svg",
            press: () {
              Navigator.pushNamed(context, '/leavingReport');
            },
          ),
        ]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .85,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      );
    }

    //Sister widgets
    else if (role == 'sister') {
      return SliverGrid(
        delegate: SliverChildListDelegate([
          Menu_card(
            title: "Manage activites of midwives",
            heading: "Manage Midwives",
            svgSrc: "assets/icons/yoga.svg",
            press: () {
              Navigator.pushNamed(context, '/midManage');
            },
          ),
          Menu_card(
            title: "View leaving residential area reports",
            heading: "View Residential Leaves",
            svgSrc: "assets/icons/yoga.svg",
            press: () {
              Navigator.pushNamed(context, '/midResLeaves');
            },
          ),
          Menu_card(
            title: "Send Special and Emergancy Notices",
            heading: "Special Notice",
            svgSrc: "assets/icons/yoga.svg",
            press: () {
              Navigator.pushNamed(context, '/specialNotice');
            },
          ),
        ]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .85,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      );
    } else {
      return SliverGrid(
        delegate: SliverChildListDelegate([
          SizedBox(
            height: 50.0,
          )
        ]),
        gridDelegate: null,
      );
    }
  }
}
