import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/models/UserM.dart';

class DairlyDiary extends StatefulWidget {
  @override
  _DairlyDiaryState createState() => _DairlyDiaryState();
}

class _DairlyDiaryState extends State<DairlyDiary> {
  TextEditingController servicePlace = TextEditingController();
  TextEditingController noOfHouses = TextEditingController();

  String eligibleFam = "eligible family";
  String antenatal = "Antenatal";
  String postpartrum = "PostPatrum";
  String infants = "infants";
  String children = "children";
  String familyPlanning = "Family Planning";
  String uid = 'uID900';
  List uu = List();

  List<List<UserM>> lists;
  List<int> dropdownValues = [];

  DateTime _date;
  TimeOfDay _time1;
  TimeOfDay _time2;
  TimeOfDay _time3;
  TimeOfDay _time4;

  int _currentStep = 0;
  StepperType _stepperType = StepperType.vertical;
  swichStepType() {
    setState(() => _stepperType == StepperType.vertical
        ? _stepperType = StepperType.horizontal
        : _stepperType = StepperType.vertical);
  }

  Widget eligibleFameMenu() {
    return DropdownButton<String>(
      value: eligibleFam,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      hint: Text('New'),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>['eligible family', 'New', 'Old']
          .map<DropdownMenuItem<String>>((String value) {
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
          eligibleFam = value;
        });
      },
    );
  }

  Widget uIDDropDownMenu() {
    return DropdownButton<String>(
      value: uid,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      hint: Text('New'),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>['uID900', 'New', 'Old']
          .map<DropdownMenuItem<String>>((String value) {
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

      /* .map((UserM userid) {
        return DropdownMenuItem<UserM>(
          value: userid,
          child: Text(
            userid.uid,
            style: TextStyle(color: Colors.red),
          ),
        );
      }).toList(),*/

      onChanged: (String value) {
        setState(() {
          uid = value;
        });
      },
    );
  }

  Widget anelenatelDropDownMenu() {
    return DropdownButton<String>(
      value: antenatal,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Antenatal',
        'New',
        'Old',
      ].map<DropdownMenuItem<String>>((String value) {
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
          antenatal = value;
        });
      },
    );
  }

  Widget postPatrumDropDownMenu() {
    return DropdownButton<String>(
      value: postpartrum,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'PostPatrum',
        'New',
        'Old',
      ].map<DropdownMenuItem<String>>((String value) {
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
          postpartrum = value;
        });
      },
    );
  }

  Widget infantsDropDownMenu() {
    return DropdownButton<String>(
      value: infants,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'infants',
        'New',
        'Old',
      ].map<DropdownMenuItem<String>>((String value) {
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
          infants = value;
        });
      },
    );
  }

  Widget childrenDropDownMenu() {
    return DropdownButton<String>(
      value: children,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'children',
        'New',
        'Old',
      ].map<DropdownMenuItem<String>>((String value) {
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
          children = value;
        });
      },
    );
  }

  Widget famPlanningDropDownMenu() {
    return DropdownButton<String>(
      value: familyPlanning,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Family Planning',
        'New',
        'Old',
      ].map<DropdownMenuItem<String>>((String value) {
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
          familyPlanning = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner:false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Diary'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              steps: _stepper(),
              physics: ClampingScrollPhysics(),
              currentStep: this._currentStep,
              type: _stepperType,
              onStepTapped: (step) {
                setState(() {
                  this._currentStep = step;
                });
              },
              /*onStepContinue: () {
                setState(() {
                  if (this._currentStep < this._stepper().length - 1) {
                    this._currentStep = this._currentStep + 1;
                  } else {
                    //your code
                    Container(
                      child: Text('Complete'),
                    );
                  }
                });
              },
              onStepCancel: () {
                //alignment: Alignment.bottomLeft;
                setState(() {
                  if (this._currentStep > 0) {
                    this._currentStep = this._currentStep - 1;
                  } else {
                    this._currentStep = 0;
                  }
                });
              },*/
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swichStepType,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.arrow_forward,
          color: Colors.blue,
        ),
      ),
    );
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
          title: Text("Basic"),
          content: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
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
                        TextFormField(
                          controller: servicePlace,
                          decoration: InputDecoration(
                            labelText: "Service Place",
                            hintText: "Enter the service place",
                          ),
                        ),

                        /*RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),*/
                        /*TextFormField(
                          controller: timeLeftTheHome,
                          decoration: InputDecoration(
                            labelText: "Time Left the Home",
                            hintText: "${_time.hour}:${_time.hour}",
                          ),
                          onTap: () => selectTime(context),
                        ),*/
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Time Left the Home",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.left,
                              ),
                              Text(_time1 == null
                                  ? "           Time"
                                  : _time1.hour.toString() +
                                      ":" +
                                      _time1.minute.toString()),
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
                                      _time1 = time;
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Time Arrived WorkPlace ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.left,
                              ),
                              Text(_time2 == null
                                  ? "  Time"
                                  : _time2.hour.toString() +
                                      ":" +
                                      _time2.minute.toString()),
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
                                      _time2 = time;
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Time left the WorkPlace ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.left,
                              ),
                              Text(_time3 == null
                                  ? "   Time"
                                  : _time3.hour.toString() +
                                      ":" +
                                      _time3.minute.toString()),
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
                                      _time3 = time;
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Time Arrived Home",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.left,
                              ),
                              Text(_time4 == null
                                  ? "             Time"
                                  : _time4.hour.toString() +
                                      ":" +
                                      _time4.minute.toString()),
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
                                      _time4 = time;
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
                  ],
                ),
              ),

              //TextFormField(
              //decoration: InputDecoration(labelText: "First Name"),
              //),
              //TextFormField(
              //decoration: InputDecoration(labelText: "Last Name"),
              //),
            ],
          ),
          isActive: _currentStep >= 0,
          state: StepState.indexed),
      Step(
          title: Text("Home Visit And Update"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(1.0, 10, 10, 0)),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10.0, 5.0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 60)),
                        Container(
                          height: 25.0,
                          child: Expanded(
                            flex: 1,
                            child: Text(
                              " Eligible Family:",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Container(
                          child: eligibleFameMenu(),
                          height: 25.0,
                          width: 55.0,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),

                            //color: Colors.green,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          height: 25.0,
                          width: 60.0,
                          child: Text(
                            'UID:',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              child: uIDDropDownMenu(),
                              height: 25.0,
                              width: 30.0,
                              alignment: Alignment.bottomLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                //color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 60)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Antenatal:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.all(5.0),
                          child: anelenatelDropDownMenu(),
                          height: 25.0,
                          width: 55.0,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),

                            //color: Colors.green,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          height: 25.0,
                          width: 60.0,
                          child: Text(
                            'UID:',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: uIDDropDownMenu(),
                            height: 25.0,
                            width: 70.0,
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              //color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 60)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Postpatrum:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.all(5.0),
                          child: postPatrumDropDownMenu(),
                          height: 25.0,
                          width: 55.0,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),

                            //color: Colors.green,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          height: 25.0,
                          width: 60.0,
                          child: Text(
                            'UID:',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: uIDDropDownMenu(),
                            height: 25.0,
                            width: 70.0,
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              //color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 60)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Children:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.all(5.0),
                          child: childrenDropDownMenu(),
                          height: 25.0,
                          width: 55.0,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),

                            //color: Colors.green,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          height: 25.0,
                          width: 60.0,
                          child: Text(
                            'UID:',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: uIDDropDownMenu(),
                            height: 25.0,
                            width: 70.0,
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              //color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 60)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Family Planning:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.all(5.0),
                          child: famPlanningDropDownMenu(),
                          height: 25.0,
                          width: 55.0,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),

                            //color: Colors.green,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          height: 25.0,
                          width: 60.0,
                          child: Text(
                            'UID:',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: uIDDropDownMenu(),
                            height: 25.0,
                            width: 70.0,
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              //color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      color: Colors.blue,
                      splashColor: Colors.white,
                      onPressed: () {},
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          isActive: _currentStep >= 1,
          state: StepState.indexed),
    ];

    return _steps;

    /*Container(
      child: SizedBox(
        height: 300.0,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(30.0),
        topLeft: Radius.circular(30.0),
      )),
    );*/
  }
}
