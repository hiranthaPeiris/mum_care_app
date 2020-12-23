import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/helpers/smoothDots/src/effects/worm_effect.dart';
import 'package:mun_care_app/helpers/smoothDots/src/smooth_page_indicator.dart';
import 'package:mun_care_app/widgets/Welcome_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool pending = true;

  PageController _controller = PageController(
    initialPage: 0,
  );
  String btnText = "Next";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  _onPageViewChange(int page) {
    print("current page $page");
    setState(() {
      //Todo: change if to check for page number 4
      if (page == 3) {
        btnText = "Let's get started";
      } else {
        btnText = "Next";
      }
    });
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {   
      setState(() {
        Navigator.pushNamed(context, '/');
        //pending = false;
      });
    } else {
      setState(() {
        pending = false;
      });
      prefs.setBool('seen', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return pending
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Plasma(
                particles: 10,
                foregroundColor: Color(0x97009fff),
                backgroundColor: Color(0xe7ed149b),
                size: 0.87,
                speed: 3.31,
                offset: 0.00,
                blendMode: BlendMode.hardLight,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _controller,
                        onPageChanged: _onPageViewChange,
                        children: [
                          InitPageOne(),
                          //Todo Appearance and Language page view goes here
                          InitPageTwo(),
                          InitPageThree(),
                          InitPageFour()
                        ],
                      ),
                    ),
                    Container(
                      child: SmoothPageIndicator(
                          controller: _controller,
                          count: 5,
                          effect: WormEffect()),
                      padding: EdgeInsets.all(20.0),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 70.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40.0),
                        child: RaisedButton(
                          onPressed: () {
                            int currentPage = _controller.page.toInt();
                            if (currentPage < 3) {
                              _controller.animateToPage(currentPage + 1,
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.linearToEaseOut);
                            } else {
                              Navigator.pushNamed(context, '/');
                            }
                          },
                          child: Text(
                            "$btnText",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0),
                          ),
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

//Page 1
class InitPageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Image(image: AssetImage('assets/icons/Hamburger.svg'))),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Welcome to",
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center),
                  Text("Mum&Care",
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          color: Colors.white,
                          fontSize: 46.0,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 28.0, 0, 0),
                    child: Text(
                      "The best way to manage Midwife & Mother intercations.",
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          color: Colors.white70,
                          fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "From X-wings studios.",
                    style: TextStyle(color: Colors.white70, fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

//Todo: implement Appearance and Language page view

//Page 2
class InitPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //welcome card from widgets
        WelcomeCard(title_1: "About", title_2: "Mum&Care"),
        Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "grantha is a collective effort of a bunch of literature enthusiasts to preserve and promote library appreciation.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ))
      ],
    );
  }
}

//Page 3
class InitPageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //welcome card from widgets
        WelcomeCard(
          title_1: "Our",
          title_2: "Vision",
        ),
        Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Get access to hundreds of audiobook collections from gartha library",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ))
      ],
    );
  }
}

//Page 4
class InitPageFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //welcome card from widgets
        WelcomeCard(
          title_2: "Enjoy",
          title_1: "",
        ),
        Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Get access to hundreds of audiobook collections from gartha library",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ))
      ],
    );
  }
}
