import 'package:flutter/material.dart';
import 'package:mun_care_app/screens/registration/ComFamReg03.dart';

class ComFamRegNext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registration02(),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.blueAccent;

    var rect = Rect.fromLTWH(0, 0, size.width, size.height * 0.7);
    canvas.drawRect(rect, paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Registration02 extends StatefulWidget {
  @override
  _Registration02State createState() => _Registration02State();
}

class _Registration02State extends State<Registration02> {
  String eduDropdownValue = 'Education Level';
  String myearDropdownValue = 'Year';
  String mmonthDropdownValue = 'Mon';
  String mdayDropdownValue = 'Day';
  bool d1_Yes = false;
  bool d1_No = false;
  bool d2_Yes = false;
  bool d2_No = false;
  bool d3_Yes = false;
  bool d3_No = false;
  bool d4_Yes = false;
  bool d4_No = false;
  bool d5_Yes = false;
  bool d5_No = false;
  bool d6_Yes = false;
  bool d6_No = false;
  bool d7_Yes = false;
  bool d7_No = false;
  bool d8_Yes = false;
  bool d8_No = false;
  bool d9_Yes = false;
  bool d9_No = false;
  bool d10_Yes = false;
  bool d10_No = false;

  Widget eduDropDownMenu() {
    return DropdownButton<String>(
      value: eduDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Education Level',
        '1990',
        '1991',
        '1992',
        '1993',
        '1994',
        '1995'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          eduDropdownValue = value;
        });
      },
    );
  }

  Widget yearDropDownMenu() {
    return DropdownButton<String>(
      value: myearDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>['Year', '1990', '1991', '1992', '1993', '1994', '1995']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          myearDropdownValue = value;
        });
      },
    );
  }

  Widget monthDropDownMenu() {
    return DropdownButton<String>(
      value: mmonthDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Mon',
        'Jan',
        'Feb',
        'Mar',
        '',
        'Apr',
        'May',
        'Jun',
        'jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          mmonthDropdownValue = value;
        });
      },
    );
  }

  Widget dayDropDownMenu() {
    return DropdownButton<String>(
      value: mdayDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Day',
        '01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          mdayDropdownValue = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.height * 0.03,
                MediaQuery.of(context).size.width * 0.03,
                MediaQuery.of(context).size.height * 0.03),
            child: Container(
              child: Text(
                "Registration",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(500, 21, 166, 211),
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: CustomPaint(
              painter: ShapePainter(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.016,
                    MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  "Competency Family",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 25,
                            child: Text(
                              "Education  -",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                boxShadow: [
                                  new BoxShadow(
                                      color: Colors.black, blurRadius: 80.0),
                                ],
                                color: Colors.grey[300],
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 0.5)),
                            child: eduDropDownMenu()),
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 37,
                    child: Text("Marriage Date"),
                  ),
                  Expanded(
                    flex: 23,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black, blurRadius: 80.0),
                              ],
                              color: Colors.grey[300],
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0.5)),
                          child: yearDropDownMenu()),
                    ),
                  ),
                  Expanded(
                    flex: 21,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black, blurRadius: 80.0),
                              ],
                              color: Colors.grey[300],
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0.5)),
                          child: monthDropDownMenu()),
                    ),
                  ),
                  Expanded(
                    flex: 19,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black, blurRadius: 80.0),
                              ],
                              color: Colors.grey[300],
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0.5)),
                          child: dayDropDownMenu()),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.height * 0.03,
                MediaQuery.of(context).size.width * 0.03,
                MediaQuery.of(context).size.height * 0.03),
            child: Container(
              child: Text(
                "About Diseases",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Color.fromARGB(500, 21, 166, 211),
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.height * 0.005,
                MediaQuery.of(context).size.width * 0.03,
                MediaQuery.of(context).size.height * 0.005),
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(flex: 60, child: Text("Diseases",style: TextStyle(color: Color.fromARGB(500, 21, 166, 211),fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,)),
                  Expanded(flex: 20, child: Text("Women's",style: TextStyle(color: Color.fromARGB(500, 21, 166, 211),fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,)),
                  Expanded(flex: 20, child: Text("Men's",style: TextStyle(color: Color.fromARGB(500, 21, 166, 211),fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,)),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.height * 0.005,
                MediaQuery.of(context).size.width * 0.03,
                MediaQuery.of(context).size.height * 0.005),
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d1_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d1_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d1_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d1_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d2_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d2_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d2_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d2_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d3_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d3_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d3_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d3_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d4_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d4_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d4_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d4_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d5_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d5_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d5_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d5_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d6_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d6_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d6_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d6_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d7_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d7_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d7_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d7_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d8_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d8_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d8_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d8_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d9_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d9_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d9_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d9_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 60, child: Text("HIV")),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d10_Yes,
                              onChanged: (bool value) {
                                setState(() {
                                  d10_Yes = value;
                                  print(value);
                                });
                              })),
                      Expanded(
                          flex: 20,
                          child: Checkbox(
                              value: d10_No,
                              onChanged: (bool value) {
                                setState(() {
                                  d10_No = value;
                                  print(value);
                                });
                              })),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1,
                MediaQuery.of(context).size.height * 0.005,
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.height * 0.005),
            child: Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 50,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: RaisedButton(
                          color: Colors.white,
                          textColor: Color.fromARGB(500, 21, 166, 211),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Color.fromARGB(500, 21, 166, 211),
                              )),
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(
                                      color: Colors.black, blurRadius: 30.0),
                                ],
                              ),
                              child: Text(
                                "Prev",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      )),
                  Expanded(
                      flex: 50,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          color: Color.fromARGB(500, 21, 166, 211),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.white)),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black, blurRadius: 30.0),
                              ],
                            ),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ComFamRegNext02()));
                          },
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
