import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComFamReg extends StatefulWidget {
  @override
  _ComFamRegState createState() => _ComFamRegState();
}

Widget showTextField(String hintText, String inputName) {
  return TextFormField(
    maxLines: 1,
    decoration: InputDecoration(
      hintText: hintText,
    ),
    // ignore: missing_return
    validator: (input) {
      if (input.isEmpty) {
        return 'This can\'t be empty';
      }
    },
    onSaved: (input) => inputName = input,
  );
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

class _ComFamRegState extends State<ComFamReg> {
  int currentStep = 0;
  bool complete = false;
  bool isActive = false;
  //StepState stepState=StepState.editing;
  String mohDropdownValue = 'Select Area';
  String phmDropdownValue = 'Select Area';
  String eduDropdownValue = 'Education Level';
  String womenBloodDropdownValue = 'A+';
  String menBloodDropdownValue = 'A+';

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
  String rubellaDropdownValue = null;
  String formicDropdownValue = null;
  String conDropdownValue = null;
  String bloodDropdownValue = null;
  DateTime _dateDOB;
  DateTime _dateMarrage;
  bool _set = false;

  @override
  Widget build(BuildContext context) {
    Widget mohDropDownMenu() {
      return DropdownButton<String>(
        value: mohDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 36,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        items: <String>[
          'Select Area',
          'One',
          'Two',
          'Happy New Year mmmmmm',
          'Four'
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
            mohDropdownValue = value;
          });
        },
      );
    }

    Widget phmDropDownMenu() {
      return DropdownButton<String>(
        value: phmDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 36,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        items: <String>['Select Area', 'Five', 'Six', 'Seven', 'Eight']
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
            phmDropdownValue = value;
          });
        },
      );
    }

////////////////////////////////////////////////step 02 widgets////////////////
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

//////////////////////////////////step 04 widgets///////////////////////

    Widget rubellaDropDownMenu() {
      return DropdownButton<String>(
        value: rubellaDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 36,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        items:
            <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
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
        items:
            <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
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
        items:
            <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
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

    Widget womenBloodDropDownMenu() {
      return DropdownButton<String>(
        value: womenBloodDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 36,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        items: <String>['A+', 'A-', 'AB', 'O+', 'O-']
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
            womenBloodDropdownValue = value;
          });
        },
      );
    }

    Widget menBloodDropDownMenu() {
      return DropdownButton<String>(
        value: menBloodDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 36,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        items: <String>['A+', 'A-', 'AB', 'O+', 'O-']
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
            menBloodDropdownValue = value;
          });
        },
      );
    }

    List<Step> steps = [
      Step(
          title: const Text(
            "Step  1",
            style: TextStyle(
                fontSize: 10, color: Color.fromARGB(500, 21, 166, 211)),
          ),
          isActive: currentStep >= 0,
          state: StepState.indexed,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.001,
                    MediaQuery.of(context).size.height * 0.01,
                    MediaQuery.of(context).size.width * 0.4,
                    MediaQuery.of(context).size.height * 0.03),
                child: Container(
                  child: Text(
                    "Registration",
                    textAlign: TextAlign.start,
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
                        MediaQuery.of(context).size.width * 0.4,
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
                        Expanded(flex: 10, child: Container()),
                        Expanded(
                            flex: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 25,
                                child: Text(
                                  "MOH Area  -",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 10.0),
                                    ],
                                    color: Colors.grey[300],
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 0.5)),
                                child: mohDropDownMenu()),
                          ),
                        ),
                        Expanded(flex: 5, child: Container()),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 10, child: Container()),
                        Expanded(
                            flex: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 25,
                                child: Text(
                                  "PHM Area  -",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 10.0),
                                    ],
                                    color: Colors.grey[300],
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 0.5)),
                                child: phmDropDownMenu()),
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
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Husbond\'s Name", "_husbondName"),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Wife\'s Name", "_wifeName"),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Address", "_address"),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("NIC Number", "_nic"),
                ),
              ),
            ],
          )),
      Step(
        title: const Text(
          "Step 2",
          style:
              TextStyle(fontSize: 10, color: Color.fromARGB(500, 21, 166, 211)),
        ),
        isActive: currentStep >= 1,
        state: StepState.indexed,
        //content: ComFamRegNext(),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005,
                    MediaQuery.of(context).size.width * 0.005,
                    MediaQuery.of(context).size.height * 0.005),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 30,
                      child: Text(
                        "Date of Birth",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(_dateDOB == null
                              ? "Select DOB"
                              : _dateDOB.year.toString() +
                                  "/" +
                                  _dateDOB.month.toString() +
                                  "/" +
                                  _dateDOB.day.toString()),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 20,
                            height: 30,
                            child: RaisedButton(
                                child: Text(
                                  ".",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 35),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Color.fromARGB(500, 21, 166, 211),
                                    )),
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1980),
                                          lastDate: DateTime(2021))
                                      .then((date) {
                                    setState(() {
                                      _dateDOB = date;
                                    });
                                  });
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005),
                child: showTextField("Contact Number", "_contactNumber"),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005),
                child: showTextField("Email", "_email"),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.05),
                child: showTextField("Job", "_job"),
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
                    MediaQuery.of(context).size.height * 0.05,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 37,
                      child: Text(
                        "Marriage Date",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(_dateMarrage == null
                              ? "Select Marriage Date"
                              : _dateMarrage.year.toString() +
                                  "/" +
                                  _dateMarrage.month.toString() +
                                  "/" +
                                  _dateMarrage.day.toString()),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 20,
                            height: 30,
                            child: RaisedButton(
                                child: Text(
                                  ".",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 35),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Color.fromARGB(500, 21, 166, 211),
                                    )),
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1980),
                                          lastDate: DateTime(2021))
                                      .then((date) {
                                    setState(() {
                                      _dateMarrage = date;
                                      _set = true;
                                    });
                                  });
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Step(
        title: const Text(
          "Step 3",
          style:
              TextStyle(fontSize: 10, color: Color.fromARGB(500, 21, 166, 211)),
        ),
        isActive: currentStep >= 2,
        state: StepState.indexed,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.001,
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
                    Expanded(
                        flex: 60,
                        child: Text(
                          "Diseases",
                          style: TextStyle(
                              color: Color.fromARGB(500, 21, 166, 211),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                    Expanded(
                        flex: 20,
                        child: Text(
                          "Women's",
                          style: TextStyle(
                              color: Color.fromARGB(500, 21, 166, 211),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                    Expanded(
                        flex: 20,
                        child: Text(
                          "Men's",
                          style: TextStyle(
                              color: Color.fromARGB(500, 21, 166, 211),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
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
          ],
        ),
      ),
      Step(
          title: const Text(
            "Step 4",
            style: TextStyle(
                fontSize: 10, color: Color.fromARGB(500, 21, 166, 211)),
          ),
          isActive: currentStep >= 3,
          state: StepState.indexed,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 8, 2, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 25,
                      child: Text(
                        "Special information about women",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
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
                              padding: const EdgeInsets.fromLTRB(2, 8, 2, 10),
                              child: Container(
                                height: 25,
                                child: Text(
                                  "* Have you got Rubella Immunization..?",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 17,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 80.0),
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
                              padding: const EdgeInsets.fromLTRB(2, 15, 2, 10),
                              child: Container(
                                height: 40,
                                child: Text(
                                  "* Have you got formic acids in everyday..?",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 17,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 80.0),
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
                              padding: const EdgeInsets.fromLTRB(2, 15, 2, 10),
                              child: Container(
                                height: 25,
                                child: Text(
                                  "* Consanguinity",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 17,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 80.0),
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
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.05,
                    MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.height * 0.005),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(flex: 10, child: Container()),
                      Expanded(
                          flex: 15,
                          child: Text(
                            "Women's",
                            style: TextStyle(
                                color: Color.fromARGB(500, 21, 166, 211),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                          flex: 20,
                          child: Text(
                            "Men's",
                            style: TextStyle(
                                color: Color.fromARGB(500, 21, 166, 211),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.025,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 25,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 25,
                                child: Text(
                                  "Weight -",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              child: showTextField("", "kgWeight"),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.grey[300],
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 0.5)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text("Kg")),
                        ),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              child: showTextField("", "gWeight"),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.grey[300],
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 0.5)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text("Kg"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.025,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex: 25,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 25,
                                  child: Text(
                                    "Height -",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 15,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: showTextField("", "womenHeight"),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.grey[300],
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 0.5)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text("cm")),
                          ),
                          Expanded(
                            flex: 15,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: showTextField("", "menHeight"),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.grey[300],
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 0.5)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text("cm"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.025,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 25,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 25,
                                child: Text(
                                  "Blood Type -",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 80.0),
                                    ],
                                    color: Colors.grey[300],
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 0.5)),
                                child: womenBloodDropDownMenu()),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 80.0),
                                    ],
                                    color: Colors.grey[300],
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 0.5)),
                                child: menBloodDropDownMenu()),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ))
    ];

    goto(int step) {
      setState(() {
        currentStep = step;
        //isActive=true;
      });
    }

    next() {
      currentStep + 1 != steps.length
          ? goto(currentStep + 1)
          : setState(() {
              complete = true;
            });
    }

    cancel() {
      if (currentStep > 0) {
        goto(currentStep - 1);
      }
    }

    return new Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        complete
            ? Expanded(
                child: Center(
                child: AlertDialog(
                  title: Text("Competency Registration Succesfully"),
                  content: Text("Congratulation"),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              setState(() {
                                complete = false;
                              });
                            }),
                        FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              setState(() {
                                complete = false;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ))
            : Expanded(
                flex: 80,
                child: Stepper(
                  steps: steps,
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepContinue: next,
                  onStepCancel: cancel,
                  onStepTapped: (step) => goto(step),
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Padding(
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
                                    textColor:
                                        Color.fromARGB(500, 21, 166, 211),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color:
                                              Color.fromARGB(500, 21, 166, 211),
                                        )),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            new BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 30.0),
                                          ],
                                        ),
                                        child: Text(
                                          "Prev",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                    onPressed: onStepCancel,
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
                                            color: Colors.black,
                                            blurRadius: 30.0),
                                      ],
                                    ),
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onPressed: onStepContinue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    ));
  }
}
