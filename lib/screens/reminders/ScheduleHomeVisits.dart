import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ScheduleHomeVisits extends StatefulWidget {
  //String
  final DocumentSnapshot document;

  const ScheduleHomeVisits({Key key, this.document}) : super(key: key);
  @override
  _ScheduleHomeVisitsState createState() => _ScheduleHomeVisitsState();
}

class _ScheduleHomeVisitsState extends State<ScheduleHomeVisits> {
  //DateTime selectedDate = DateTime.now();
  //TimeOfDay selectedTime = TimeOfDay.now();
  // final TimeOfDay picked1;

  /*Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked1 = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    setState(() {
      selectedTime = picked1;
      print(selectedTime);
    });
  }*/

  /*Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
  }*/
  TextEditingController description = TextEditingController();
  //TextEditingController date1 = TextEditingController();
  //TextEditingController time = TextEditingController();
  TextEditingController mothername = TextEditingController();
  DateTime _date;
  TimeOfDay _time;

  bool textFieldVisibility = false;

  String firestoreCollectionName = 'ShedulehomeVisit';
  //HomeShedule currentShedule;
  String montherval = "Maala";
  String selectedType;

  /*addBook() async {
    HomeShedule she1 = HomeShedule(
        description: description.text,
        date: _date.year.toString() +
            "/" +
            _date.month.toString() +
            "/" +
            _date.day.toString(),
        time: _time.hour.toString() + ":" + _time.minute.toString(),
        mothername: montherval);
    try {
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        await FirebaseFirestore.instance
            .collection(firestoreCollectionName)
            .doc()
            .set(she1.toJson());
      });
    } catch (e) {
      print(e.toString());
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner:false;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.document['name']),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'Create New Home Visit',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Container(
            //   // child: Text('grg',
            //   // style: TextStyle(color: Colors.black, fontSize: 12)),
            //   height: 40.0,
            //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            //   color: Colors.lightBlue,
            //
            //   child: Text("Reminder-1",
            //       style: TextStyle(color: Colors.black87, fontSize: 20)),
            // ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextFormField(
                        controller: description,
                        decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "Enter the description",
                        ),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
                  )
                ],
              ),
            ),
            Container(margin: EdgeInsets.all(10),
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
                onPressed: () {
                  //addBook();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
