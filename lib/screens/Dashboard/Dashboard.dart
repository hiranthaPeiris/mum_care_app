import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/main.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:mun_care_app/screens/login/Login_comp.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:mun_care_app/widgets/FirebaseMessageWapper.dart';
import 'package:mun_care_app/widgets/Menu_card.dart';
import 'package:mun_care_app/widgets/Menu_linear_card.dart';
import 'package:mun_care_app/widgets/Search_bar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mun_care_app/models/UserReg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

AuthService _authService = AuthService();

class _DashboardState extends State<Dashboard> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //bool onDuty = false;
  AuthService v;
  bool isSwitched = false;
  int notificationCount = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool pending = true;
  UserM _user;
  String role = "";
  String name = "";
  bool compFam = false;
  bool pregMum = false;
  DateTime now;
  @override
  void initState() {
    super.initState();
    //_user = Provider.of<UserM>(context);
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
        compFam = customData['competencyFam'];
        pregMum = customData['PregnanctFam'];

        print(_user.userCustomData);
        pending = false;
      });
    }).catchError((err) => print(err));
    // } else {
    //   setState(() {
    //     pending = false;
    //   });
    // }
  }

  // bool pending = false;
  UserM getRole = new UserM.get();
  UserM n;

  void toggleSwitch(bool value) {
    /*if (onDuty == false) {
      setState(() {
        onDuty = true;
        // onDutyCheck();
      });
      print('Switch Button is ON');
    }*/
    /*if (onDuty == true) {
      setState(() {
        onDuty = false;
        onDutyCheck();
      });
      print('Switch Button is OFF');
    }*/
  }
  Future<void> dutyChecking() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser.uid)
        .update({'onDuty': true})
        .then((value) => print('duty is available'))
        .catchError((err) => print(err));
  }

  Future<void> noDutyChecking() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser.uid)
        .update({'onDuty': false})
        .then((value) => print('duty is not available'))
        .catchError((err) => print(err));
  }

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
                        // onDuty = false;
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
                          Text(name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 36,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w800)),
                          Search_bar(),
                          Row(
                            children: <Widget>[
                              //  Align(
                              // alignment: Alignment.topRight,
                              // ),
                              Text("DUTY"),
                              Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    if (isSwitched = value) {
                                      //onDutyCheck();
                                      dutyChecking();

                                      //  v.onDuty = false;
                                      print(isSwitched);
                                    } else {
                                      noDutyChecking();
                                      print(isSwitched);
                                    }
                                  });
                                  //print("false");

                                  // v.dutyChecking();
                                  //v.onDuty = true;
                                  // onDutyCheck();
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),

                              /*onChanged: (value) {
                                  if (onDuty == false) {
                                    setState(() {
                                      onDuty = true;
                                      //onDutyCheck();
                                    });
                                    print('Switch Button is ON');
                                  }*/
                              /*else {
                                    setState(() {
                                      onDuty = false;
                                      onDutyCheck();
                                    });
                                    print('Switch Button is OFF');
                                  }*/
                              /*setState(() {
                                    isSwitched = value;

                                    onDuty = true;

                                    print(isSwitched);
                                    onDutyCheck();
                                  });*/
                            ],
                          ),
                          Expanded(
                              child: CustomScrollView(
                            slivers: <Widget>[
                              _buildSliverList(),
                              _buildSliverGrid()

                              // SliverGrid(
                              //     delegate: SliverChildListDelegate([
                              //       Menu_card(
                              //         title: "View & Schedule Clinics",
                              //         heading: "Clinic",
                              //         svgSrc: "assets/icons/clinics.svg",
                              //         press: () {
                              //           Navigator.pushNamed(
                              //               context, '/clinicHome',
                              //               arguments: <String, String>{
                              //                 'switchView': 'Clinic',
                              //               });
                              //         },
                              //       ),
                              //       Menu_card(
                              //         title: "View & Schedule Home Visit",
                              //         heading: "Home Visits",
                              //         svgSrc: "assets/icons/home-visits.svg",
                              //         press: () {
                              //           Navigator.pushNamed(
                              //               context, '/clinicHome',
                              //               arguments: <String, String>{
                              //                 'switchView': 'Home Visits',
                              //               });
                              //         },
                              //       ),
                              //       Menu_card(
                              //         title: "Report private medications",
                              //         heading: "Report Medications",
                              //         svgSrc: "assets/icons/yoga.svg",
                              //         press: () {
                              //           Navigator.pushNamed(
                              //               context, '/MedicalReport');
                              //         },
                              //       ),
                              //       Menu_card(
                              //         title: "Report leaving residential area",
                              //         heading: "Report Leaving",
                              //         svgSrc: "assets/icons/yoga.svg",
                              //         press: () {
                              //           Navigator.pushNamed(
                              //               context, '/leavingReport');
                              //         },
                              //       ),
                              //       // Menu_card(
                              //       //   title: "Home visits",
                              //       //   heading: "Schedule Home Visits",
                              //       //   svgSrc:
                              //       //       "assets/icons/home-visits-sch.svg",
                              //       //   press: () {
                              //       //     Navigator.pushNamed(
                              //       //         context, '/sechHomeVisits');
                              //       //   },
                              //       // ),
                              //       // Menu_card(
                              //       //   title: "Clinics",
                              //       //   heading: "Schedule Clinics",
                              //       //   svgSrc: "assets/icons/clinics-sch.svg",
                              //       //   press: () {
                              //       //     Navigator.pushNamed(
                              //       //         context, '/sechClinics');
                              //       //   },
                              //       // )
                              //     ]),
                              //     gridDelegate:
                              //         SliverGridDelegateWithFixedCrossAxisCount(
                              //       crossAxisCount: 2,
                              //       childAspectRatio: .85,
                              //       crossAxisSpacing: 20,
                              //       mainAxisSpacing: 20,
                              //     ))
                              ,
                              getRole.userCustomData['role'] != 'midwife'
                                  ? SliverList(
                                      delegate: SliverChildListDelegate([
                                        Menu_liner_card(
                                            heading: "Mother List",
                                            content: "List of your mothers",
                                            svgSrc:
                                                "assets/icons/Hamburger.svg",
                                            press: () {
                                              print(getRole
                                                  .userCustomData['role']);
                                              Navigator.pushNamed(
                                                  context, '/motherAssign');
                                            }),
                                      ]),
                                    )
                                  : SliverList(
                                      delegate: SliverChildListDelegate([
                                        Menu_liner_card(
                                            heading: "Complete Registration",
                                            content:
                                                "Complete the competency family registration",
                                            svgSrc:
                                                "assets/icons/Hamburger.svg",
                                            press: () {
                                              print(getRole
                                                  .userCustomData['role']);
                                              Navigator.pushNamed(
                                                  context, '/comReg');
                                            }),
                                        Menu_liner_card(
                                            heading: "Pregnancy Registration",
                                            content:
                                                "Complete the pregnancy registration",
                                            svgSrc:
                                                "assets/icons/Hamburger.svg",
                                            press: () {
                                              Navigator.pushNamed(
                                                  context, '/preReg');
                                            }),
                                      ]),
                                    ),
                              SliverGrid(
                                  delegate: SliverChildListDelegate([
                                    Menu_card(
                                      title: "View Upcoming Clinics",
                                      heading: "Clinics",
                                      svgSrc: "assets/icons/clinics.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/UpcomingClinics');
                                      },
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
                                    /*Menu_card(
                                      title: "Home visits",
                                      heading: "Schedule Home Visits",
                                      svgSrc:
                                          "assets/icons/home-visits-sch.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/sechHomeVisits');
                                      },
                                    ),*/
                                    Menu_card(
                                      title: "Clinics",
                                      heading: "Schedule Clinics",
                                      svgSrc: "assets/icons/clinics-sch.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/sechClinics');
                                      },
                                    ),
                                    Menu_card(
                                      title: "Reports",
                                      heading: "Monthly and Daily Report",
                                      svgSrc:
                                          "assets/icons/home-visits-sch.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/searchReport');
                                      },
                                    ),
                                    Menu_card(
                                      title: "Map",
                                      heading: "Geo Loacation",
                                      svgSrc:
                                          "assets/icons/home-visits-sch.svg",
                                      press: () {
                                        Navigator.pushNamed(
                                            context, '/geoLocate');
                                      },
                                    ),
                                    Menu_card(
                                      title: "Duty",
                                      heading: "On Duty Midwives",
                                      // heading: "Geo Loacation",
                                      svgSrc: "assets/icons/Hamburger.svg",
                                      press: () {
                                        // print(getRole.userCustomData['role']);
                                        Navigator.pushNamed(
                                            context, '/dutyChecking');
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
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget _buildSliverList() {
    if (role == 'midwife') {
      return SliverList(
        delegate: SliverChildListDelegate([
          Menu_liner_card(
              heading: "Competency family Reviews",
              content: "You have pending competency family data to review",
              svgSrc: "assets/icons/Hamburger.svg",
              press: () {
                Navigator.pushNamed(context, '/');
              }),
          Menu_liner_card(
              heading: "Pregnancy Mothers",
              content: "You have pending competency family data to review",
              svgSrc: "assets/icons/Hamburger.svg",
              press: () {
                Navigator.pushNamed(context, '/');
              }),
        ]),
      );
    } else {
      if (!pregMum && !compFam) {
        return SliverList(
          delegate: SliverChildListDelegate([
            Menu_liner_card(
                heading: "Complete Registration",
                content: "Complete the competency family registration",
                svgSrc: "assets/icons/Hamburger.svg",
                press: () {
                  Navigator.pushNamed(context, '/comReg');
                }),
            Menu_liner_card(
                heading: "Pregnancy Registration",
                content: "Complete the pregnancy registration",
                svgSrc: "assets/icons/Hamburger.svg",
                press: () {}),
          ]),
        );
      } else if (compFam) {
        return SliverList(
          delegate: SliverChildListDelegate([
            Menu_liner_card(
                heading: "Pregnancy Registration",
                content: "Complete the pregnancy registration",
                svgSrc: "assets/icons/Hamburger.svg",
                press: () {}),
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
            title: "Report private medications",
            heading: "Report Medications",
            svgSrc: "assets/icons/yoga.svg",
            press: () {
              Navigator.pushNamed(context, '/MedicalReport');
            },
          ),
          Menu_card(
            title: "Report leaving residential area",
            heading: "Report Leaving",
            svgSrc: "assets/icons/yoga.svg",
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
    } else if (role == 'user') {
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
                '/UpcomingHome',
              );
            },
          ),
          Menu_card(
            title: "Report private medications",
            heading: "Report Medications",
            svgSrc: "assets/icons/yoga.svg",
            press: () {
              Navigator.pushNamed(context, '/MedicalReport');
            },
          ),
          Menu_card(
            title: "Report leaving residential area",
            heading: "Report Leaving",
            svgSrc: "assets/icons/yoga.svg",
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
