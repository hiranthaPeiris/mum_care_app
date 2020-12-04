import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/models/UserReg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComFamReg extends StatefulWidget {
  @override
  _ComFamRegState createState() => _ComFamRegState();
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

  TextEditingController myController1 = new TextEditingController();
  TextEditingController myController2 = new TextEditingController();
  TextEditingController myController3 = new TextEditingController();
  TextEditingController myController4 = new TextEditingController();
  TextEditingController myController5 = new TextEditingController();
  TextEditingController myController6 = new TextEditingController();
  TextEditingController myController7 = new TextEditingController();
  TextEditingController myController8 = new TextEditingController();
  TextEditingController myController9 = new TextEditingController();
  TextEditingController myController10 = new TextEditingController();
  TextEditingController myController11 = new TextEditingController();
  bool _validater = false;

  void dispose() {
    super.dispose();
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
    myController6.dispose();
    myController7.dispose();
    myController8.dispose();
    myController9.dispose();
    myController10.dispose();
    myController11.dispose();
  }

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
  bool d11_Yes = false;
  bool d11_No = false;
  bool d12_Yes = false;
  bool d12_No = false;
  bool d13_Yes = false;
  bool d13_No = false;
  bool d14_Yes = false;
  bool d14_No = false;
  bool d15_Yes = false;
  bool d15_No = false;

  String rubellaDropdownValue = 'Yes';
  String formicDropdownValue = 'Yes';
  String conDropdownValue = 'Yes';
  DateTime _dateDOB;
  DateTime _dateMarrage;
  bool _set = false;
  bool allreadyComReg;
  List<String> arr=[
          'Select Area',
          'Ambalangoda',
          'Hikkaduwa',
          'Rathgama',
          'Habaraduwa',
          'Mirissa',
          'Weligama',
          'Dodanduwa',
          'Balapitiya',
          'Ahangama',
          'Thalgaswala'
        ];
  @override
  Widget build(BuildContext context) {
    Widget showTextField(
        String hintText, String inputName, TextEditingController controller) {
      return TextFormField(
        maxLines: 1,
        controller: controller,
        //autofocus: true,
        decoration: InputDecoration(
          //hintText: hintText,
          labelText: hintText,
          errorText: _validater ? 'This can\'t be empty' : null,
        ),
        // ignore: missing_return
        validator: (controller) {
          if (controller.isEmpty) {
            setState(() {
              _validater = true;
            });
          }
        },

        onSaved: (input) => inputName = input,
      );
    }

    Widget mohDropDownMenu() {
      return DropdownButton<String>(
        value: mohDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 36,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        items:arr.map<DropdownMenuItem<String>>((String value) {
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
        items: <String>[
          'Select Area',
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

    stepOneReg() async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      DateTime date = DateTime.now();
      ComRegDB comRegDB = ComRegDB(
        husbandName: myController1.text,
        wifeName: myController2.text,
        address: myController3.text,
        nic: myController4.text,
        mohDropDownValue: mohDropdownValue,
        phmDropDownValue: phmDropdownValue,
        dateDOB: _dateDOB.toString(),
        contactNum: myController5.text,
        email: myController6.text,
        job: myController7.text,
        eduDropDownValue: eduDropdownValue,
        marrageDate: _dateMarrage.toString(),
        md1: d1_Yes,
        md2: d2_Yes,
        md3: d3_Yes,
        md4: d4_Yes,
        md5: d5_Yes,
        md6: d6_Yes,
        md7: d7_Yes,
        md8: d8_Yes,
        md9: d9_Yes,
        md10: d10_Yes,
        md11: d11_Yes,
        md12: d12_Yes,
        md13: d13_Yes,
        md14: d14_Yes,
        md15: d15_Yes,
        wd1: d1_No,
        wd2: d2_No,
        wd3: d3_No,
        wd4: d4_No,
        wd5: d5_No,
        wd6: d6_No,
        wd7: d7_No,
        wd8: d8_No,
        wd9: d9_No,
        wd10: d10_No,
        wd11: d11_No,
        wd12: d12_No,
        wd13: d13_No,
        wd14: d14_No,
        wd15: d15_No,
        rubellaDropDownValue: rubellaDropdownValue,
        formicDropDownValue: formicDropdownValue,
        conDropDownValue: conDropdownValue,
        womenWeight: myController8.text,
        menWeight: myController9.text,
        womenHeight: myController10.text,
        menHeight: myController11.text,
        womenBloodDropDownValue: womenBloodDropdownValue,
        menBloodDropDownValue: menBloodDropdownValue,
        regDate:date.toString(),
      );

      try {
        FirebaseFirestore.instance
            .runTransaction((Transaction transaction) async {
          await FirebaseFirestore.instance
              .collection("ComDatabase")
              .doc(_auth.currentUser.uid)
              .set(comRegDB.toJson());
        });
      } catch (e) {
        print(e.toString());
      }
    }

    comRegComfirm() async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      ComSetState comSetState = ComSetState(allreadyComReg: allreadyComReg);
      try {
        FirebaseFirestore.instance
            .runTransaction((Transaction transaction) async {
          await FirebaseFirestore.instance
              .collection("ComDatabase")
              .doc(_auth.currentUser.uid)
              .collection("State")
              .doc(_auth.currentUser.uid)
              .set(comSetState.toJson());
        });
      } catch (e) {
        print(e.toString());
      }
    }

    Future<void> setCompetencyTrue() async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser.uid)
          .update({
            'competencyFam': true,
          })
          .then((value) => print("Competency true"))
          .catchError((err) => print(err));
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
                        MediaQuery.of(context).size.width * 0.3,
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
                  child: showTextField(
                      "Husbond\'s Name", "_husbondName", myController1),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child:
                      showTextField("Wife\'s Name", "_wifeName", myController2),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Address", "_address", myController3),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("NIC Number", "_nic", myController4),
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
                            width: 60,
                            height: 30,
                            child: RaisedButton(
                                child: Icon(Icons.calendar_today),
                                /* shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Color.fromARGB(500, 21, 166, 211),
                                    )),*/
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
                child: showTextField(
                    "Contact Number", "_contactNumber", myController5),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005),
                child: showTextField("Email", "_email", myController6),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.05),
                child: showTextField("Job", "_job", myController7),
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
                    MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.height * 0.05,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.005),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 45,
                      child: Text(
                        "Marriage Date",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            width: 60,
                            height: 30,
                            child: RaisedButton(
                                child: Icon(Icons.calendar_today),
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
                          "Men's",
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
                        Expanded(flex: 60, child: Text("01.Diabetes")),
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
                        Expanded(flex: 60, child: Text("02.Hypertension")),
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
                        Expanded(flex: 60, child: Text("03.Cardiac Diseases")),
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
                        Expanded(flex: 60, child: Text("04.Renal Diseases")),
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
                        Expanded(flex: 60, child: Text("05.Hepatic Diseases")),
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
                        Expanded(
                            flex: 60, child: Text("06.Psychiatric Illnesses")),
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
                        Expanded(flex: 60, child: Text("07.Epilepsy")),
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
                        Expanded(flex: 60, child: Text("08.Malignancies")),
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
                        Expanded(
                            flex: 60,
                            child: Text("09.Haematological Diseases")),
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
                        Expanded(flex: 60, child: Text("10.Tuberculosis")),
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
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("11.Thyroid Diseases")),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d11_Yes,
                                onChanged: (bool value) {
                                  setState(() {
                                    d11_Yes = value;
                                    print(value);
                                  });
                                })),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d11_No,
                                onChanged: (bool value) {
                                  setState(() {
                                    d11_No = value;
                                    print(value);
                                  });
                                })),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("12.Bronchial Asthma")),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d12_Yes,
                                onChanged: (bool value) {
                                  setState(() {
                                    d12_Yes = value;
                                    print(value);
                                  });
                                })),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d12_No,
                                onChanged: (bool value) {
                                  setState(() {
                                    d12_No = value;
                                    print(value);
                                  });
                                })),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("13.Previous DVT")),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d13_Yes,
                                onChanged: (bool value) {
                                  setState(() {
                                    d13_Yes = value;
                                    print(value);
                                  });
                                })),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d13_No,
                                onChanged: (bool value) {
                                  setState(() {
                                    d13_No = value;
                                    print(value);
                                  });
                                })),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 60,
                            child: Text("14.Surgeries other than LSCS")),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d14_Yes,
                                onChanged: (bool value) {
                                  setState(() {
                                    d14_Yes = value;
                                    print(value);
                                  });
                                })),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d14_No,
                                onChanged: (bool value) {
                                  setState(() {
                                    d14_No = value;
                                    print(value);
                                  });
                                })),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("15.HIV")),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d15_Yes,
                                onChanged: (bool value) {
                                  setState(() {
                                    d15_Yes = value;
                                    print(value);
                                  });
                                })),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: d15_No,
                                onChanged: (bool value) {
                                  setState(() {
                                    d15_No = value;
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
                              child: showTextField(
                                  "", "womenWeight", myController8),
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
                              child:
                                  showTextField("", "menWeight", myController9),
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
                                child: showTextField(
                                    "", "womenHeight", myController10),
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
                                child: showTextField(
                                    "", "menHeight", myController11),
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
  Widget alertBox(){
    return Expanded(
                child: Center(
                child: AlertDialog(
                  title: Row(
                    children: [
                      Icon(Icons.warning,color: Colors.red,),
                      Text("  Warning",style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  content: Text("You have to fill every details",style: TextStyle(color: Colors.blueAccent),),
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
                      ],
                    ),
                  ],
                ),
              ));
  }

  bool validate() {
    if (myController1.text.isEmpty && myController2.text.isEmpty && myController3.text.isEmpty && myController4.text.isEmpty && myController5.text.isEmpty&& myController6.text.isEmpty && myController7.text.isEmpty && myController8.text.isEmpty && myController9.text.isEmpty && myController10.text.isEmpty && myController11.text.isEmpty) {
      print("This cant't be empty");
      return false;
      
    }
    print("not empty");
    return true;
  }
    return new Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        complete
            ? 
            validate() ?
            Expanded(
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
                                allreadyComReg = true;
                              });
                              stepOneReg();
                              comRegComfirm();
                              setCompetencyTrue();
                              Navigator.pushNamed(context, '/dashboard');
                              myController1.clear();
                              myController2.clear();
                              myController3.clear();
                              myController4.clear();
                              myController5.clear();
                              myController6.clear();
                              myController7.clear();
                              myController8.clear();
                              myController9.clear();
                              myController10.clear();
                              myController11.clear();
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
              :alertBox()
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
