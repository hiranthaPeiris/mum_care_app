import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/ClinicService.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class ScheduleClinic extends StatefulWidget {
  final bool rescheduleFLAG;
  final String docID;
  final List<DocumentReference> userClinicRefList;
  const ScheduleClinic(
      {Key key, this.rescheduleFLAG, this.docID, this.userClinicRefList})
      : super(key: key);
  @override
  _ScheduleClinicState createState() => _ScheduleClinicState();
}

class _ScheduleClinicState extends State<ScheduleClinic> {
  final ClinicService _clinicService = ClinicService();
  final _formKey = GlobalKey<FormState>();
  bool pending = false;
  UserM _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime _date;
  TimeOfDay _time;

  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController venue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner:false;
    _user = Provider.of<UserM>(context);

    bool flag = widget.rescheduleFLAG;
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
              body: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
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
                    Form(
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
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Mothers you referes : ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: _firestore
                                .collection('users')
                                .where('midwifeID', isEqualTo: _user.user.uid)
                                .where("competencyFam", isEqualTo: true)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return new Text("has error");
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return new Text("Loading");
                              }
                              return new ListView(
                                children: snapshot.data.docs
                                    .map((DocumentSnapshot document) {
                                  return new ListTile(
                                    title: new Text(document['name']),
                                    trailing: Icon(Icons.more_vert_rounded),
                                    leading: Icon(Icons.person_rounded),
                                  );
                                }).toList(),
                              );
                            })),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            shape: StadiumBorder(),
                            textColor: Colors.white,
                            color: Colors.lightBlue,
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/dashboard');
                            },
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          RaisedButton(
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
                                String dateSlug = getDateSlug();
                                //print(' Data : $des , $_date, $_time, $dateslug');
                                dynamic result;
                                (flag)
                                    ? result = _clinicService.clinicReschedule(
                                        _user.user.uid,
                                        widget.docID,
                                        description.text,
                                        dateSlug,
                                        widget.userClinicRefList)
                                    : result = _clinicService.saveClinics(
                                        description.text, dateSlug, _user.uid);

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
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
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
