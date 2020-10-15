import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:mun_care_app/widgets/Menu_card.dart';
import 'package:mun_care_app/widgets/Menu_linear_card.dart';
import 'package:mun_care_app/widgets/Search_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: Bottom_nav(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              // Here the height of the container is 45% of our total height
              height: size.height * .45,
              decoration: BoxDecoration(
                color: kBackground,
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: AssetImage("assets/images/undraw_pilates_pur.png"),
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
                      Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: 45,
                          child: SvgPicture.asset("assets/icons/bell.svg",
                              color: Colors.white)),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Color(0xFF8d3edd),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/icons/profile.svg",
                              height: 30, width: 30),
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
                              press: () {}),
                          Menu_liner_card(
                              heading: "Pregnancy Registration",
                              content: "Complete the pregnancy registration",
                              svgSrc: "assets/icons/Hamburger.svg",
                              press: () {}),
                        ]),
                      ),
                      SliverGrid(
                          delegate: SliverChildListDelegate([
                            Menu_card(
                              title: "View Upcoming Clinics",
                              svgSrc: "assets/icons/Hamburger.svg",
                              press: () {},
                            ),
                            Menu_card(
                              title: "View Upcoming Home Visits",
                              svgSrc: "assets/icons/Excrecises.svg",
                              press: () {},
                            ),
                            Menu_card(
                              title: "Report Medications",
                              svgSrc: "assets/icons/Meditation.svg",
                              press: () {},
                            ),
                            Menu_card(
                              title: "Report Leaving Residential Area",
                              svgSrc: "assets/icons/yoga.svg",
                              press: () {},
                            ),
                            Menu_card(
                              title: "Meditation",
                              svgSrc: "assets/icons/Meditation.svg",
                              press: () {},
                            ),
                            Menu_card(
                              title: "Yoga",
                              svgSrc: "assets/icons/yoga.svg",
                              press: () {},
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

                  /*Expanded(
                    child: Column(
                      children: [
                        Menu_liner_card(
                            content: "Test",
                            svgSrc: "assets/icons/Hamburger.svg",
                            press: () {}),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: .85,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            children: <Widget>[
                              Menu_card(
                                title: "Diet Recommendation",
                                svgSrc: "assets/icons/Hamburger.svg",
                                press: () {},
                              ),
                              Menu_card(
                                title: "Kegel Exercises",
                                svgSrc: "assets/icons/Excrecises.svg",
                                press: () {},
                              ),
                              Menu_card(
                                title: "Meditation",
                                svgSrc: "assets/icons/Meditation.svg",
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return null;
                                    }),
                                  );
                                },
                              ),
                              Menu_card(
                                title: "Yoga",
                                svgSrc: "assets/icons/yoga.svg",
                                press: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*

* */
