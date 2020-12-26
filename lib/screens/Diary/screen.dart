import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import 'package:mun_care_app/models/diaryTaskModel.dart';

class ScreenDiary extends StatefulWidget {
  @override
  _ScreenDiaryState createState() => _ScreenDiaryState();
}

class _ScreenDiaryState extends State<ScreenDiary> {
  TextEditingController taskNameController;
  TextEditingController titleController;
  TimeOfDay time1;
  bool isEditing = false;
  bool textFieldVisibility = false;
  Task currenttask;
  String taskDropdownValue = "Eligible Fam";
  List<String> arr = ['Eligible Fam', 'Clinic', 'HomeVisit', 'Waighting'];
  var _addCard = 0;

  void _incrementCard() {
    setState(() {
      _addCard++;
    });
  }

  DateTime now = new DateTime.now();

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
    return Scaffold(
      backgroundColor: Colors.greenAccent,
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
        onPressed: _incrementCard,
        tooltip: 'Add a Task',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // drawer: Drawer(
      body: ListView.builder(
        padding: EdgeInsets.all(14),
        itemCount: _addCard,
        //  itemBuilder: (context, index) {
        itemBuilder: (context, index) {
          return Container(
            // decoration: BoxDecoration(
            //gradient: LinearGradient(colors: [Colors.pink, Colors.blue])),
            child: GradientCard(
              gradient: Gradients.aliHussien,
              margin: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                // side: BorderSide(color: Colors.white70, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              //color: Color(45556222),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  const ListTile(
                    leading: Icon(Icons.work),
                    title: Text(
                      'Dairly Task',
                      style: TextStyle(color: Colors.blue, fontSize: 17),
                    ),
                    subtitle: Text('SUBTITLE'),
                  ),
                  /* TextFormField(
                        style: TextStyle(),
                        controller: taskNameController,
                        decoration: InputDecoration(
                          labelText: "Task name",
                          hintText: "Enter task Name",
                        ),
                      ),*/
                  Container(
                    padding: EdgeInsets.all(6),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.all(5),
                      initialValue: "today home visit ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      //  textAlign: TextAlign.center,
                      //controller: titleController.toString(),
                      decoration: InputDecoration(
                        labelText: "title",
                        labelStyle: TextStyle(
                          color: Colors.blue,
                          // fontStyle: FontStyle.italic,
                          fontSize: 16,

                          //color: Colors.white,
                        ),
                        hintText: "Enter title",
                      ),
                      //  onChanged: ,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        /* Text(
                        "Time",
                        style: TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.left,
                      ),*/
                        Text(
                          "Date ${now.year}/${now.month}/${now.day}",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Time ${now.hour}:${now.minute}",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center),
                        /* RaisedButton.icon(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: new TimeOfDay.now(),
                          ).then((time) {
                            setState(() {
                              time = time;
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
                      ),*/
                      ],
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('About Task',
                            style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text('About the Tasks'),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: titleController,
                                            decoration: InputDecoration(
                                              labelText: 'Title',
                                              icon: Icon(Icons.account_box),
                                            ),
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Task Name',
                                              icon: Icon(Icons.work_outline),
                                            ),
                                          ),
                                          TextFormField(
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
                                                    Expanded(
                                                        flex: 10,
                                                        child: Container()),
                                                    Expanded(
                                                        flex: 40,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 25,
                                                            child: Text(
                                                              "Task Type",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                    Expanded(
                                                      flex: 40,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                            height: 25,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0),
                                                                color: Colors
                                                                    .grey[300],
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    style: BorderStyle
                                                                        .solid,
                                                                    width:
                                                                        0.5)),
                                                            child:
                                                                taskDropDownMenu()),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 5,
                                                        child: Container()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Remarks',
                                              icon: Icon(Icons.crop_rotate),
                                            ),
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
                                        onPressed: () {
                                          // your code
                                          Navigator.of(context)
                                              .pop(ScreenDiary());
                                          Navigator.of(context).pop(
                                              titleController.text.toString());
                                        })
                                  ],
                                );
                              });
                        },
                      ),
                      /* FlatButton(
                        child:
                            const Text('BTN2', style: TextStyle(fontSize: 18)),
                        onPressed: () {/* ... */},
                      ),*/
                    ],
                  ),
                ],
              ),
            ),
          );
          //],
          //),
          //],
          //),
          // };
        },
      ),
    );
  }
}
