import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:mun_care_app/widgets/Menu_card.dart';

class MediLeaveWapper extends StatefulWidget {
  MediLeaveWapper({Key key}) : super(key: key);

  @override
  _MediLeaveWapperState createState() => _MediLeaveWapperState();
}

class _MediLeaveWapperState extends State<MediLeaveWapper> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: Bottom_nav(
        scaffoldKey: _scaffoldKey,
      ),
      body: Builder(
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
                height: 150.0,
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
                                "Mother Medication & Area Leave \nReport",textAlign: TextAlign.center,
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
                            title: "View reports on private medications",
                            heading: "View Mother Medications",
                            svgSrc: "assets/icons/yoga.svg",
                            press: () {
                              Navigator.pushNamed(
                                  context, '/ViewMedicalReport');
                            },
                          ),
                          Menu_card(
                            title: "View reports on leaving residential area",
                            heading: "View Leaving Report",
                            svgSrc: "assets/icons/yoga.svg",
                            press: () {
                              Navigator.pushNamed(
                                  context, '/ViewleavingReport');
                            },
                          ),
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
      ),
    );
  }
}
