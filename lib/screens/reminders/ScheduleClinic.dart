import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ScheduleClinic extends StatefulWidget {
  @override
  _ScheduleClinicState createState() => _ScheduleClinicState();
}

class _ScheduleClinicState extends State<ScheduleClinic> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked1;
  Future<Null> selectTime(BuildContext context) async {
    picked1 = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    setState(() {
      _time = picked1;
      print(_time);
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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
                'New Home Visits',
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
                      TextFormField(
                        controller: date,
                        decoration: InputDecoration(
                          labelText: "Date",
                          hintText: "${selectedDate.toLocal()}".split(' ')[0],
                        ),
                        onTap: () => _selectDate(context),
                      ),
                      /*RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),*/
                      TextFormField(
                        controller: time,
                        decoration: InputDecoration(
                          labelText: "Time",
                          hintText: "${_time.hour}:${_time.hour}",
                        ),
                        onTap: () => selectTime(context),
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
