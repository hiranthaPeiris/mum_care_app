import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/models/MediModel.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:provider/provider.dart';

///MUM Leaving area report
///
class LeavingReport extends StatefulWidget {
  @override
  _LeavingState createState() => new _LeavingState();
}

class _LeavingState extends State<LeavingReport> {
  TextEditingController myController1 = new TextEditingController();
  TextEditingController myController2 = new TextEditingController();
  TextEditingController myController3 = new TextEditingController();
  String mohDropdownValue = 'Select Area';
  String phmDropdownValue = 'Select Area';
  bool _validater = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserM _user;

  void dispose() {
    super.dispose();
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
  }

  DateTime _date;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserM>(context);

    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Builder(
            builder: (context) => Container(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    5,
                            width: MediaQuery.of(context).copyWith().size.width,
                            color: Colors.lightBlue,
                            child: Container(
                              child: Text(
                                'Leaving Residensial Area Report',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.2,
                                  MediaQuery.of(context).size.height * 0.06,
                                  MediaQuery.of(context).size.width * 0.2,
                                  MediaQuery.of(context).size.height * 0.04),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
                            height:
                                MediaQuery.of(context).copyWith().size.height *
                                    (4 / 5),
                            width: MediaQuery.of(context).copyWith().size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 10, child: Container()),
                                          Expanded(
                                            flex: 40,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 25,
                                                child: Text(
                                                  "New MOH Area  -",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 40,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                      boxShadow: [
                                                        new BoxShadow(
                                                            color: Colors.black,
                                                            blurRadius: 10.0),
                                                      ],
                                                      color: Colors.grey[300],
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 0.5)),
                                                  child: mohDropDownMenu()),
                                            ),
                                          ),
                                          Expanded(flex: 5, child: Container()),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 10, child: Container()),
                                          Expanded(
                                            flex: 40,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 25,
                                                child: Text(
                                                  "New PHM Area  -",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 40,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                      boxShadow: [
                                                        new BoxShadow(
                                                            color: Colors.black,
                                                            blurRadius: 10.0),
                                                      ],
                                                      color: Colors.grey[300],
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 0.5)),
                                                  child: phmDropDownMenu()),
                                            ),
                                          ),
                                          Expanded(flex: 5, child: Container()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.0005,
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.0005),
                                    child: showTextField("NIC Number",
                                        "_NICnumber", myController2),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.0005,
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.0005),
                                    child: showTextField("Any Remarks",
                                        "_MumRemarks", myController3),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.005),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 20,
                                          child: Text(
                                            "Leaving Date",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: new Padding(
                                                  padding: EdgeInsets.all(20.0),
                                                  child: new Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      new SizedBox(
                                                        height: 20.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(_date == null
                                                        ? "Select Date"
                                                        : _date.year
                                                                .toString() +
                                                            "/" +
                                                            _date.month
                                                                .toString() +
                                                            "/" +
                                                            _date.day
                                                                .toString()),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                      height: 30,
                                                      child: RaisedButton(
                                                          child: Icon(Icons
                                                              .calendar_today),
                                                          /* shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Color.fromARGB(500, 21, 166, 211),
                                    )),*/
                                                          onPressed: () {
                                                            showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            1980),
                                                                    lastDate:
                                                                        DateTime(
                                                                            2022))
                                                                .then((date) {
                                                              setState(() {
                                                                _date = date;
                                                              });
                                                            });
                                                          }),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.1,
                                      MediaQuery.of(context).size.height *
                                          0.005,
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.height *
                                          0.08),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            onPressed: () {
                                              dynamic rst = inserting();
                                              if (rst != null) {
                                                _displaySnackBar(context);
                                              } else {
                                                AlertDialog alert = AlertDialog(
                                                  title: Text('Error'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text(
                                                            'Please try again leter'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('Ok'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return alert;
                                                  },
                                                );
                                              }
                                              _clearText();
                                            },
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
                )));
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Successfully submited'),
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

  _clearText() {
    myController1.clear();
    myController2.clear();
    myController3.clear();
  }

  Widget showTextField(
      String hintText, String inputName, TextEditingController controller) {
    return TextFormField(
      maxLines: 1,
      controller: controller,
      decoration: InputDecoration(
        //hintText: hintText,
        labelText: hintText,
        errorText: _validater ? 'This can\'t be empty' : null,
      ),
      // ignore: missing_return
      validator: (controller) {
        if (controller.isEmpty) {
          setState(() {
            _validater = true;
          });
        }
      },

      onSaved: (input) => inputName = input,
    );
  }

  Widget mohDropDownMenu() {
    return DropdownButton<String>(
      value: mohDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Select Area',
        'Ambalangoda',
        'Hikkaduwa',
        'Rathgama',
        'Habaraduwa',
        'Mirissa',
        'Weligama',
        'Dodanduwa',
        'Balapitiya',
        'Ahangama',
        'Thalgaswala'
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
          mohDropdownValue = value;
        });
      },
    );
  }

  Widget phmDropDownMenu() {
    return DropdownButton<String>(
      value: phmDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Select Area',
        '01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10'
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
          phmDropdownValue = value;
        });
      },
    );
  }

  Future<dynamic> inserting() async {
    DateTime date = DateTime.now();
    String dateConvert = date.year.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.day.toString();
    DocumentReference userDocRef =
        _firestore.collection('users').doc(_user.uid);
    String name = _user.userCustomData['name'];
    LeaveData medi = LeaveData(
        name: name,
        nic: myController2.text,
        mumRemarks: myController3.text,
        mohDropDownValue: mohDropdownValue,
        phmDropDownValue: phmDropdownValue,
        date: _date.toString(),
        regDate: dateConvert,
        midwifeID: _user.userCustomData['midwifeID'],
        status: "pending");

    return await _firestore
        .collection("informLeaving")
        .add(medi.toJson())
        .then((value) => print("report added"))
        .catchError((err) => print(err));
  }
}

//void setState(Null Function() param0) {}
