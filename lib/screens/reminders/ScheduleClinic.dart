import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ScheduleClinic extends StatefulWidget {
  @override
  _ScheduleClinicState createState() => _ScheduleClinicState();
}

class _ScheduleClinicState extends State<ScheduleClinic> {
  DateTime _date;
  TimeOfDay _time;

  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController venue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner:false;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'New Clinics',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              // child: Text('grg',
              // style: TextStyle(color: Colors.black, fontSize: 12)),
              height: 40.0,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              color: Colors.lightBlue,

              child: Text("Reminder-2",
                  style: TextStyle(color: Colors.black87, fontSize: 20)),
            ),
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
                              width: 20,
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
            Container(
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
