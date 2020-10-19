 import 'package:flutter/material.dart';

class ComFamRegNext02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registration03(),
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

class Registration03 extends StatefulWidget {
  @override
  _Registration03State createState() => _Registration03State();
}

class _Registration03State extends State<Registration03> {
  String rubellaDropdownValue = null;
  String formicDropdownValue = null;
  String conDropdownValue = null;
  String bloodDropdownValue = null;

  Widget rubellaDropDownMenu() {
    return DropdownButton<String>(
      value: rubellaDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Yes',
        'No'
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
          rubellaDropdownValue = value;
        });
      },
    );
  }
  Widget formicDropDownMenu() {
    return DropdownButton<String>(
      value: formicDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Yes',
        'No'
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
          formicDropdownValue = value;
        });
      },
    );
  }
  Widget conDropDownMenu() {
    return DropdownButton<String>(
      value: conDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Yes',
        'No'
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
          conDropdownValue = value;
        });
      },
    );
  }
  Widget bloodDropDownMenu() {
    return DropdownButton<String>(
      value: bloodDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Yes',
        'No'
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
          bloodDropdownValue = value;
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
                        flex: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 25,
                            child: Text(
                              "* Have you got Rubella Immunization..?",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16),
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 17,
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
                            child: rubellaDropDownMenu()),
                      ),
                    ),
                    Expanded(flex: 3, child: Container()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 25,
                            child: Text(
                              "* Have you got formic acids in everyday..?",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16),
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 17,
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
                            child: formicDropDownMenu()),
                      ),
                    ),
                    Expanded(flex: 3, child: Container()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 25,
                            child: Text(
                              "* Consanguinity",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16),
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 17,
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
                            child: conDropDownMenu()),
                      ),
                    ),
                    Expanded(flex: 3, child: Container()),
                  ],
                ),
              ],
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
                              "Submit",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
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
