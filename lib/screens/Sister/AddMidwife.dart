import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:provider/provider.dart';

class AddMidwife extends StatefulWidget {
  AddMidwife({Key key}) : super(key: key);

  @override
  _AddMidwifeState createState() => _AddMidwifeState();
}

class _AddMidwifeState extends State<AddMidwife> {
  final AuthService _authService = AuthService();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  String mohDropdownValue = 'Hikkaduwa';
  String phmDropdownValue = 'Hikkaduwa North';
  String desigDropdownValue = 'Mrs.';

  bool _validater = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserM _user;

  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
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
                                'Add Midwife',
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
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.height *
                                          0.0005,
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.height *
                                          0.0005),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Designation"),
                                      DropdownButton<String>(
                                        value: desigDropdownValue,
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style:
                                            TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            desigDropdownValue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Mrs.',
                                          'Miss.',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
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
                                    child: showTextField(
                                        "Name", "_Name", nameController),
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
                                    child: showTextField(
                                        "Email", "_Email", emailController),
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
                                      child: showTextField(
                                        "Mobile Number",
                                        "_Mobile",
                                        mobileController,
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.height *
                                          0.0005,
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.height *
                                          0.0005),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("MOH Area"),
                                      DropdownButton<String>(
                                        value: mohDropdownValue,
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style:
                                            TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            mohDropdownValue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Hikkaduwa',
                                          'Panadura',
                                          'Kirula',
                                          'Central',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.height *
                                          0.0005,
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.height *
                                          0.0005),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("PHM Area"),
                                      DropdownButton<String>(
                                        value: phmDropdownValue,
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style:
                                            TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            phmDropdownValue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Hikkaduwa North',
                                          'Hikkaduwa South',
                                          'Hikkaduwa East',
                                          'Central',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
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
                                          child: RaisedButton(
                                            shape: StadiumBorder(),
                                            textColor: Colors.white,
                                            color: Colors.lightBlue,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Back',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: RaisedButton(
                                            shape: StadiumBorder(),
                                            textColor: Colors.white,
                                            color: Colors.lightBlue,
                                            child: Text(
                                              'Submit',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            onPressed: () async{
                                              User rst = await
                                                  _authService.registerAsMidwife(
                                                      emailController.text,
                                                      "password",
                                                      nameController.text,
                                                      "midwife",
                                                      mobileController.text);

                                              if (rst != null) {
                                                print(rst.toString());
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
    nameController.clear();
    emailController.clear();
    mobileController.clear();
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
}
