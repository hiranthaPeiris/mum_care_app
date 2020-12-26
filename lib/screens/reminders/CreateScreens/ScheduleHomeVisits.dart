import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/services/HomeVisitService.dart';

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ScheduleHomeVisits extends StatefulWidget {
  //String
  final DocumentSnapshot document;
  final String midwifeId;
  const ScheduleHomeVisits({Key key, this.document, this.midwifeId})
      : super(key: key);
  @override
  _ScheduleHomeVisitsState createState() => _ScheduleHomeVisitsState();
}

class _ScheduleHomeVisitsState extends State<ScheduleHomeVisits> {
  TextEditingController description = TextEditingController();
  //TextEditingController date1 = TextEditingController();
  //TextEditingController time = TextEditingController();
  TextEditingController mothername = TextEditingController();
  DateTime _date;
  TimeOfDay _time;
  final _formKey = GlobalKey<FormState>();
  bool textFieldVisibility = false;
  bool pending = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HomeVisitService _homeVisitService = HomeVisitService();

  String firestoreCollectionName = 'ShedulehomeVisit';
  String selectedType;

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner:false;
    return pending
        ? Loading()
        : GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.document['name']),
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Create a New Home Visit',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: description,
                                  decoration: InputDecoration(
                                    labelText: "Description",
                                    hintText: "Enter the description",
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please Enter a description";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Row(
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
                                                  initialDate:
                                                      new DateTime.now(),
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
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Time:             ",
                                        style: TextStyle(fontSize: 18.0),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(_time == null
                                          ? "Select Time"
                                          : _time.hour.toString() +
                                              ":" +
                                              _time.minute.toString()),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      RaisedButton.icon(
                                        onPressed: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: new TimeOfDay.now(),
                                          ).then((time) {
                                            setState(() {
                                              _time = time;
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
                                          Icons.alarm,
                                          color: Colors.white,
                                        ),
                                        textColor: Colors.white,
                                        splashColor: Colors.red,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 50.0,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          textColor: Colors.white,
                          color: Colors.lightBlue,
                          child: Text(
                            'Create',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate() &&
                                validate()) {
                              setState(() {
                                pending = true;
                              });
                              //String dateSlug = getDateSlug();
                              //print(' Data : $des , $_date, $_time, $dateslug');
                              dynamic result = _homeVisitService.addHomeVisit(
                                  description.text,
                                  _date,
                                  _time,
                                  widget.document,
                                  widget.midwifeId);
                              if (result == null) {
                                setState(() {
                                  pending = false;
                                  print("dynamic failed");
                                });
                              } else {
                                setState(() {
                                  pending = false;
                                  Navigator.pop(context);
                                });
                              }
                            } else {
                              print("validate failed");
                            }
                            //addHomeVisit();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  bool validate() {
    if (_date == null && _time == null) {
      return false;
    }
    return true;
  }

  String getDateSlug() {
    return DateTimeFormat.format(
        new DateTime(
            _date.year, _date.month, _date.day, _time.hour, _time.minute),
        format: DateTimeFormats.american);
  }
}
