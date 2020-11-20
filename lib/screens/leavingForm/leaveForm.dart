import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveForm extends StatefulWidget {
  @override
  _LeaveFormState createState() => new _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  DateTime selected;
  DateTime _date4;
  DateTime _date1;
  DateTime _date2;
  DateTime _date3;

  TextEditingController name = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController numOfdays = TextEditingController();
  TextEditingController reasons = TextEditingController();
  TextEditingController address = TextEditingController();
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
    /*var dateFormat_1 = new Column(
      children: <Widget>[
        new SizedBox(
          height: 20.0,
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
                        'Leave application',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                children: <Widget>[
                                  Expanded(flex: 10, child: Container()),
                                  Expanded(
                                    flex: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                      child: TextFormField(
                                        controller: name,
                                        decoration: InputDecoration(
                                          labelText: "Name",
                                          hintText: "Enter the name of midwife",
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please Enter a name";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 10, child: Container()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(flex: 10, child: Container()),
                                  Text(
                                    "Date :             ",
                                    style: TextStyle(fontSize: 15.0),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(_date4 == null
                                      ? "Select Date"
                                      : _date4.year.toString() +
                                          "/" +
                                          _date4.month.toString() +
                                          "/" +
                                          _date4.day.toString()),
                                  SizedBox(
                                    width: 5,
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
                                          _date4 = date;
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
                                  Expanded(flex: 5, child: Container()),
                                  Expanded(
                                    flex: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 2),
                                      child: TextFormField(
                                        controller: department,
                                        decoration: InputDecoration(
                                          labelText: "Department",
                                          hintText:
                                              "Enter the name of deparment",
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please Enter a department";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 5, child: Container()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(flex: 10, child: Container()),
                                  Text(
                                    "Date of the appoinment:             ",
                                    style: TextStyle(fontSize: 15.0),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(_date1 == null
                                      ? "Select Date"
                                      : _date1.year.toString() +
                                          "/" +
                                          _date1.month.toString() +
                                          "/" +
                                          _date1.day.toString()),
                                  SizedBox(
                                    width: 5,
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
                                          _date1 = date;
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
                                  Expanded(flex: 5, child: Container()),
                                  Expanded(
                                    flex: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      child: TextFormField(
                                        controller: numOfdays,
                                        decoration: InputDecoration(
                                          labelText:
                                              "Num of days for leave applied for",
                                          hintText: "Enter the Num of days",
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please Enter the Num of days";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 5, child: Container()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(flex: 10, child: Container()),
                                  Text(
                                    "Leave to commence on:             ",
                                    style: TextStyle(fontSize: 15.0),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(_date2 == null
                                      ? "Select Date"
                                      : _date2.year.toString() +
                                          "/" +
                                          _date2.month.toString() +
                                          "/" +
                                          _date2.day.toString()),
                                  SizedBox(
                                    width: 10,
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
                                          _date2 = date;
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(flex: 2, child: Container()),
                                  Text(
                                    "Leave to end on:                       ",
                                    style: TextStyle(fontSize: 15.0),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(_date3 == null
                                      ? "Select Date"
                                      : _date3.year.toString() +
                                          "/" +
                                          _date3.month.toString() +
                                          "/" +
                                          _date3.day.toString()),
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
                                          _date3 = date;
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
                                  Expanded(flex: 5, child: Container()),
                                  Expanded(
                                    flex: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: TextFormField(
                                        controller: reasons,
                                        decoration: InputDecoration(
                                          labelText: "Reasons for Application",
                                          hintText: "Enter the Reason",
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please Enter the Reason";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  //Expanded(flex: 5, child: Container()),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(flex: 5, child: Container()),
                                  Expanded(
                                    flex: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: TextFormField(
                                        controller: address,
                                        decoration: InputDecoration(
                                          labelText: "Address of the Applicant",
                                          hintText: "Enter the Address",
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please Enter the Address";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  // Expanded(flex: 5, child: Container()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                    onPressed: () {},
                                  ),
                                ),
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
        ));
  }
}
