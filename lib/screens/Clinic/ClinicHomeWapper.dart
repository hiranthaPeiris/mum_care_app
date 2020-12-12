import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:mun_care_app/widgets/Menu_card.dart';

class ClinicHomeWapper extends StatefulWidget {
  final String viewSwitch;

  const ClinicHomeWapper({Key key, this.viewSwitch}) : super(key: key);

  @override
  _ClinicHomeWapperState createState() => _ClinicHomeWapperState();
}

class _ClinicHomeWapperState extends State<ClinicHomeWapper> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: Bottom_nav(
        scaffoldKey: _scaffoldKey,
      ),
      body: Container(
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
              height: 110.0,
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
                              widget.viewSwitch,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
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
                      delegate: SliverChildListDelegate((widget.viewSwitch ==
                              "Clinic")
                          ? [
                              Menu_card(
                                title: "View your upcoming clinic",
                                heading: "View Clinics",
                                svgSrc: "assets/icons/clinics.svg",
                                press: () {
                                  Navigator.pushNamed(
                                      context, '/UpcomingClinics');
                                },
                              ),
                              Menu_card(
                                title: "Schedule a new clinic",
                                heading: "Schedule Clinic",
                                svgSrc: "assets/icons/clinics-sch.svg",
                                press: () {
                                  Navigator.pushNamed(context, '/sechClinics');
                                },
                              ),
                            ]
                          : [
                              Menu_card(
                                title: "View Upcoming Home Visits",
                                heading: "View\nHome Visit",
                                svgSrc: "assets/icons/home-visits.svg",
                                press: () {
                                  Navigator.pushNamed(context, '/viewupcominghomevisit');
                                },
                              ),
                              Menu_card(
                                title: "Schedule a new home visits",
                                heading: "Schedule\nHome Visit",
                                svgSrc: "assets/icons/home-visits-sch.svg",
                                press: () {
                                  Navigator.pushNamed(
                                      context, '/sechHomeVisits');
                                },
                              )
                            ]),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
