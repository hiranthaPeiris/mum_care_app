import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleHomeVisits.dart';
import 'package:mun_care_app/models/UserM.dart';

class DairlyReport extends StatefulWidget {
  @override
  _DairlyReportState createState() => new _DairlyReportState();
}

class _DairlyReportState extends State<DairlyReport> {
  String searchPara = "";
  CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  UserM _userM = UserM.get();
  DateTime selected;
  DateTime _date;
  DateTime _date1;
  DateTime _date2;
  DateTime _date3;

  TextEditingController name = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController newMothers = TextEditingController();
  TextEditingController visiting = TextEditingController();
  TextEditingController registerdMothers = TextEditingController();

  String mohDropdownValue = 'Select Area';
  String phmDropdownValue = 'Select Area';
  String ageDropdownValue = '<16';
  _showDateTimePicker() async {
    selected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).copyWith().size.height / 7,
                  width: MediaQuery.of(context).copyWith().size.width,
                  color: Colors.lightBlue,
                  child: Container(
                    child: Text(
                      'Dairly Report',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  height:
                      MediaQuery.of(context).copyWith().size.height * (6 / 7),
                  width: MediaQuery.of(context).copyWith().size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Date:             ",
                                  style: TextStyle(fontSize: 18.0),
                                  textAlign: TextAlign.left,
                                ),
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
                                RaisedButton.icon(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: new DateTime.now(),
                                            firstDate: DateTime(1980),
                                            lastDate: DateTime(2021))
                                        .then((date) {
                                      setState(() {
                                        _date = date;
                                      });
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  label: Text(
                                    '',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: Icon(
                                    Icons.event_available,
                                    color: Colors.white,
                                  ),
                                  textColor: Colors.white,
                                  splashColor: Colors.red,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 200,
                                      height: 50,
                                      color: Colors.white,
                                      child: RaisedButton(
                                        child: Text(
                                          "Search",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        onPressed: () {},
                                        color: Colors.blue,
                                        textColor: Colors.white,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        splashColor: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
