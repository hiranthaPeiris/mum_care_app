import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';

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
    //_currentStep = _currentStep + 1;
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
  }

  swichStepTypeBack() {
    setState(() => _stepperType == StepperType.vertical
        ? _stepperType = StepperType.horizontal
        : _stepperType = StepperType.vertical);
    // _currentStep = _currentStep - 1;
    setState(() {
      if (this._currentStep > 0) {
        this._currentStep = this._currentStep - 1;
      } else {
        this._currentStep = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner:false;

    return MaterialApp(
      home: Scaffold(
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
                type: StepperType.vertical,
                onStepTapped: (step) {
                  setState(() {
                    this._currentStep = step;
                  });
                },
                /* onStepCancel: () {
                  setState(() {
                    if (this._currentStep > 0) {
                      this._currentStep = this._currentStep - 1;
                    } else {
                      this._currentStep = 0;
                    }
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (this._currentStep < this._stepper().length - 1) {
                      this._currentStep = this._currentStep + 1;
                    } else {
                      //your code
                      Container(
                        child: Text('Complete'),
                      );
                    }
                  });*/
                // },
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 15),
                  child: RaisedButton(
                    child: Text('Back'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
                    onPressed: swichStepTypeBack,
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                Container(
                  width: 100,
                  height: 50,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    child: Text('Next'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
                    onPressed: swichStepType,
                  ),
                ),
              ],
            ),
          ],

          /*floatingActionButton: FloatingActionButton(
          onPressed: swichStepType,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.blue,
          ),
        ),*/
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
          title: Text("Home Visit Update"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(1.0, 10, 10, 0)),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Eligible Family:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              child: TextField(
                                decoration: new InputDecoration(
                                    labelText: "Enter the sum"),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Antenatal:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Postpatrum:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Children:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Family Planning:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Number of Home Visits:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              child: TextField(
                                decoration: new InputDecoration(
                                    labelText: "Enter the sum"),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          isActive: _currentStep >= 1,
          state: StepState.indexed),
      Step(
          title: Text("Clinics Attendence"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(1.0, 10, 10, 0)),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Newly Married Couples:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              child: TextField(
                                decoration: new InputDecoration(
                                    labelText: "Enter the sum"),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Antenatal:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Postpatrum:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Children:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Adolecents:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Well Women:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Number of all:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              child: TextField(
                                decoration: new InputDecoration(
                                    labelText: "Enter the sum"),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          isActive: _currentStep >= 2,
          state: StepState.indexed),
      Step(
          title: Text("Weighting"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(1.0, 10, 10, 0)),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "0-6 Months:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              child: TextField(
                                decoration: new InputDecoration(
                                    labelText: "Enter the sum"),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "6-12 Months:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "1-2 Years:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "2-4 Years",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextField(
                              decoration: new InputDecoration(
                                  labelText: "Enter the sum"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Number of all:",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              child: TextField(
                                decoration: new InputDecoration(
                                    labelText: "Enter the sum"),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                        ),
                        FlatButton(
                          color: Colors.blue,
                          splashColor: Colors.white,
                          onPressed: () {},
                          child: Text(
                            "Submit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          isActive: _currentStep >= 3,
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
