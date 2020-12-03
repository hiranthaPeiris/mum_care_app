import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mun_care_app/models/Medi&LeaveModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicationReport extends StatefulWidget {
  @override
  _MedicationReportState createState() => new _MedicationReportState();
}

class _MedicationReportState extends State<MedicationReport> {
  TextEditingController myController1 = new TextEditingController();
  TextEditingController myController2 = new TextEditingController();
  TextEditingController myController3 = new TextEditingController();
  TextEditingController myController4 = new TextEditingController();
  TextEditingController myController5 = new TextEditingController();
  bool _validater = false;

  void dispose() {
    super.dispose();
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
  }

  DateTime _date;

  @override
  Widget build(BuildContext context) {
    Widget showTextField(
        String hintText, String inputName, TextEditingController controller) {
      return TextFormField(
        maxLines: 1,
        controller: controller,
        autofocus: true,
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

    inserting() async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      DateTime date = DateTime.now();
      String dateConvert = date.year.toString() +
          "/" +
          date.month.toString() +
          "/" +
          date.day.toString();
      MediData medi = MediData(
        name: myController1.text,
        nic: myController2.text,
        eligibleFamNumber: myController3.text,
        doctorName: myController4.text,
        date: _date.toString(),
        regDate: dateConvert,
      );

      try {
        FirebaseFirestore.instance
            .runTransaction((Transaction transaction) async {
          await FirebaseFirestore.instance
              .collection("FromMother")
              .doc(_auth.currentUser.uid)
              .collection("informMedical")
              .doc(_auth.currentUser.uid)
              .set(medi.toJson());
        });
      } catch (e) {
        print(e.toString());
      }
    }

    /*var dateFormat_1 = new Column(
      children: <Widget>[
        new SizedBox(
          height: 30.0,
        ),
        selected != null
            ? new Text(
                new DateFormat('yyyy-MMMM-dd').format(selected),
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              )
            : new SizedBox(
                width: 0.0,
                height: 0.0,
              ),
      ],
    );*/

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).copyWith().size.height / 6,
                  width: MediaQuery.of(context).copyWith().size.width,
                  color: Colors.lightBlue,
                  child: Container(
                    child: Text(
                      'Private Medication Report',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.2,
                        MediaQuery.of(context).size.height * 0.06,
                        MediaQuery.of(context).size.width * 0.2,
                        MediaQuery.of(context).size.height * 0.02),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height:
                      MediaQuery.of(context).copyWith().size.height * (5 / 6),
                  width: MediaQuery.of(context).copyWith().size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.05,
                                  MediaQuery.of(context).size.height * 0.005,
                                  MediaQuery.of(context).size.width * 0.05,
                                  MediaQuery.of(context).size.height * 0.005),
                              child:
                                  showTextField("Name", "_Name", myController1),
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
                                  "NIC Number", "_NICnumber", myController2),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.05,
                                  MediaQuery.of(context).size.height * 0.005,
                                  MediaQuery.of(context).size.width * 0.05,
                                  MediaQuery.of(context).size.height * 0.005),
                              child: showTextField("Eligible Family Number",
                                  "_EFsnumber", myController3),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.1,
                                MediaQuery.of(context).size.height * 0.05,
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.05),
                            child: Text(
                              'About Medication',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.005,
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.005),
                            child: showTextField("Doctor's Name",
                                "_Doctor's_name", myController4),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.005,
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.005),
                            child: showTextField("Vaccines Name",
                                "_Vacciness_name", myController5),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.05,
                                  MediaQuery.of(context).size.height * 0.005,
                                  MediaQuery.of(context).size.width * 0.05,
                                  MediaQuery.of(context).size.height * 0.005),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 20,
                                    child: Text(
                                      "Date",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(_date == null
                                            ? "Select Date"
                                            : _date.year.toString() +
                                                "/" +
                                                _date.month.toString() +
                                                "/" +
                                                _date.day.toString()),
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
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1980),
                                                        lastDate:
                                                            DateTime(2021))
                                                    .then((date) {
                                                  setState(() {
                                                    _date = date;
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
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.1,
                                MediaQuery.of(context).size.height * 0.005,
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Back'),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      child: Text('Submit'),
                                      onPressed: () {
                                        inserting();
                                        Navigator.pushNamed(
                                            context, '/dashboard');
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
