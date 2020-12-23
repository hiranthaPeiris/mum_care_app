import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/DailyNoteModel.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/DiaryServices.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Diary extends StatefulWidget {
  Diary({Key key}) : super(key: key);

  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  final DiaryServices _diaryServices = DiaryServices();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  UserM _user = UserM.get();
  TextEditingController taskNameController;
  TextEditingController titleController;
  TextEditingController descController;
  TextEditingController remarksController;
  TimeOfDay time1;
  bool isEditing = false;
  bool textFieldVisibility = false;
  //Task currenttask;
  String taskDropdownValue = "Eligible Fam";
  List<String> arr = ['Eligible Fam', 'Clinic', 'HomeVisit', 'Waighting'];
  var _addCard = 0;
  DateTime now = new DateTime.now();
  DateTime logTime;
  int workHours = 0;
  int workMins = 0;
  List<DailyNoteModel> diaryNotes = new List<DailyNoteModel>();
  TimeOfDay _time;
  double _progress = 0;
  bool pending = true;
  bool _jobState = false;

  Future<dynamic> setJobTime() async {
    String nowDate = getDateSlug();
    var startTime = await _diaryServices.getStartTime(nowDate, _user.uid);
    if (startTime != null) {
      print(startTime);
      //Work job time difference
      Duration difference = now.difference(startTime);
      workHours = difference.inHours;
      workMins = difference.inMinutes % workHours;
      _progress = workHours * 0.125;
      print(_progress);
    }
  }

  Future setJobState() async {
    final SharedPreferences prefs = await _prefs;
    _jobState = (prefs.getBool('jobState') ?? false);
  }

  @override
  void initState() {
    super.initState();
    setJobState();
    setJobTime().then((value) {
      setState(() {
        pending = false;
      });
    });
  }

  @override
  Widget taskDropDownMenu() {
    return DropdownButton<String>(
      value: taskDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: arr.map<DropdownMenuItem<String>>((String value) {
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
          taskDropdownValue = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserM>(context);
    return pending
        ? Loading()
        : Scaffold(
            backgroundColor: kBackground,
            /*appBar: AppBar(
        title: Text('Daily Diary'),
      ),*/
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: Container(
                height: 50.0,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context, builder: (_) => getAlertBox(context));
              },
              tooltip: 'Add a Task',
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // drawer: Drawer(
            body: Builder(
              builder: (context) => SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 15,
                            backgroundColor: Colors.cyanAccent,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.red),
                            value: _progress,
                          ),
                          Positioned(
                              bottom: 35,
                              left: 25,
                              child: Text(
                                "$workHours Hrs\n$workMins Mins",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext sfcontext,
                                    StateSetter setModelState) {
                                  return getTimeBox(setModelState, context);
                                },
                              );
                            });
                      },
                      child: _jobState
                          ? Text('Start Work Log')
                          : Text('End Work Log'),
                    ),
                    Expanded(
                      flex: 2,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('diaryNotes')
                            .doc(_user.uid)
                            .collection('notes')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error...');
                          } else {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Container(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        color: Colors.blue,
                                        size: 60,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text('Select a lot'),
                                      )
                                    ],
                                  ),
                                );
                                break;
                              case ConnectionState.waiting:
                                return Center(
                                  heightFactor: 5.0,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        child:
                                            const CircularProgressIndicator(),
                                        width: 50,
                                        height: 50,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text('Awaiting Data...'),
                                      )
                                    ],
                                  ),
                                );
                                break;
                              case ConnectionState.active:
                                return new ListView(
                                    children: snapshot.data.docs
                                        .map((DocumentSnapshot document) {
                                  //refe from below
                                  return getNoteCard(context, document);
                                }).toList());

                              default:
                                print(snapshot.connectionState.toString());
                                return Text("No data");
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget getTimeBox(StateSetter setModelState,BuildContext blcontext) {
    return AlertDialog(
      scrollable: true,
      title: (_jobState) ? Text('End Work Log') : Text('Add Work Log'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_time == null
                  ? "Select Time"
                  : _time.hour.toString() + ":" + _time.minute.toString()),
              ElevatedButton(
                  onPressed: () {
                    setModelState(() {
                      _time = new TimeOfDay.now();
                      logTime = new DateTime(now.year, now.month, now.day,
                          _time.hour, _time.minute);
                    });
                  },
                  child: Text("Time Now")),
              SizedBox(
                width: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Prefered time"),
                  SizedBox(
                    width: 5,
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: new TimeOfDay.now(),
                      ).then((time) {
                        setModelState(() {
                          _time = time;
                          logTime = new DateTime(now.year, now.month, now.day,
                              _time.hour, _time.minute);
                        });
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
            ],
          ),
        ),
      ),
      actions: [
        RaisedButton(
            color: Colors.blue,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: ()async {
              String dateSlug = getDateSlug();
              print(logTime.toLocal());
              dynamic rst;
              if (_jobState) {
                rst =
                    _diaryServices.updateWorkJob(logTime, dateSlug, _user.uid);
              } else {
                rst = _diaryServices.saveWorkJob(logTime, dateSlug, _user.uid);
              }

              if (rst == null) {
                final SharedPreferences prefs = await _prefs;
                prefs.setBool('jobState', true);
                _displaySnackBar(blcontext);
              }
              Navigator.of(context).pop();
            })
      ],
    );
  }

  String getDateSlug() {
    return "${now.year}-${now.month}-${now.day}";
  }

  Widget getAlertBox(BuildContext context) {
    TextEditingController titleController2;
    String title;
    String subTitle;
    String task;
    String desc;
    String remarks;
    return AlertDialog(
      scrollable: true,
      title: Text('About the Tasks'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (val) {
                title = val;
              },
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                icon: Icon(Icons.account_box),
              ),
            ),
            TextField(
              onChanged: (val) {
                task = val;
              },
              controller: titleController2,
              decoration: InputDecoration(
                labelText: 'Task Name',
                icon: Icon(Icons.work_outline),
              ),
            ),
            TextField(
              controller: descController,
              onChanged: (val) {
                desc = val;
              },
              decoration: InputDecoration(
                labelText: 'Description',
                icon: Icon(Icons.description),
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
                                "Task Type",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
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
                              child: taskDropDownMenu()),
                        ),
                      ),
                      Expanded(flex: 5, child: Container()),
                    ],
                  ),
                ],
              ),
            ),
            TextField(
              onChanged: (val) {
                remarks = val;
              },
              controller: remarksController,
              decoration: InputDecoration(
                labelText: 'Remarks',
                icon: Icon(Icons.crop_rotate),
              ),
            ),
          ],
        ),
      ),
      actions: [
        RaisedButton(
            color: Colors.blue,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print("cli");
              DailyNoteModel note = new DailyNoteModel(
                  title: title,
                  subTitle: task,
                  description: desc,
                  subject: taskDropdownValue,
                  remarks: remarks,
                  createdAt: FieldValue.serverTimestamp());

              var rst = await _diaryServices.saveDailyNote(note, _user.uid);
              print(rst);
              Navigator.of(context).pop();
            })
      ],
    );
  }

  Widget getNoteCard(BuildContext context, DocumentSnapshot document) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      height: 100,
      decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 7,
              spreadRadius: 4,
              color: Colors.black.withOpacity(0.4),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          gradient: new LinearGradient(
            colors: [kBackgrount2, const Color(0xFF3366FF)],
          )),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                //return getAlertBox(index, context);
              });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                document['title'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 5),
              Text(document['subTitle'],
                  style: TextStyle(color: Colors.white, fontSize: 12))
            ],
          ),
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Successfully Submitted'),
      action: SnackBarAction(
        label: 'Go Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      duration: Duration(seconds: 3),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}

// GradientCard(
//               gradient: Gradients.aliHussien,
//               margin: EdgeInsets.all(5),
//               shape: RoundedRectangleBorder(
//                 // side: BorderSide(color: Colors.white70, width: 2),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               //color: Color(45556222),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   SizedBox(
//                     width: 10,
//                   ),
//                   const ListTile(
//                     leading: Icon(Icons.work),
//                     title: Text(
//                       'Dairly Task',
//                       style: TextStyle(color: Colors.blue, fontSize: 17),
//                     ),
//                     subtitle: Text('SUBTITLE'),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(6),
//                     child: TextFormField(
//                       scrollPadding: EdgeInsets.all(5),
//                       initialValue: "today home visit ",
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                       //  textAlign: TextAlign.center,
//                       //controller: titleController.toString(),
//                       decoration: InputDecoration(
//                         labelText: "title",
//                         labelStyle: TextStyle(
//                           color: Colors.blue,
//                           // fontStyle: FontStyle.italic,
//                           fontSize: 16,

//                           //color: Colors.white,
//                         ),
//                         hintText: "Enter title",
//                       ),
//                       //  onChanged: ,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(6),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         /* Text(
//                         "Time",
//                         style: TextStyle(fontSize: 15.0),
//                         textAlign: TextAlign.left,
//                       ),*/
//                         Text(
//                           "Date ${now.year}/${now.month}/${now.day}",
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text("Time ${now.hour}:${now.minute}",
//                             style: TextStyle(fontSize: 16, color: Colors.white),
//                             textAlign: TextAlign.center),
//                         /* RaisedButton.icon(
//                         onPressed: () {
//                           showTimePicker(
//                             context: context,
//                             initialTime: new TimeOfDay.now(),
//                           ).then((time) {
//                             setState(() {
//                               time = time;
//                             });
//                           });
//                         },
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         label: Text(
//                           '',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         icon: Icon(
//                           Icons.alarm,
//                           color: Colors.white,
//                         ),
//                         textColor: Colors.white,
//                         splashColor: Colors.red,
//                         color: Colors.blue,
//                       ),*/
//                       ],
//                     ),
//                   ),
//                   ButtonBar(
//                     children: <Widget>[
//                       FlatButton(
//                         child: const Text('About Task',
//                             style: TextStyle(fontSize: 18)),
//                         onPressed: () {
//                           showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return getAlertBox();
//                               });
//                         },
//                       ),
//                       /* FlatButton(
//                         child:
//                             const Text('BTN2', style: TextStyle(fontSize: 18)),
//                         onPressed: () {/* ... */},
//                       ),*/
//                     ],
//                   ),
//                 ],
//               ),
//             ),
