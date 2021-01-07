import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/MediModel.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/StorageService.dart';
import 'package:provider/provider.dart';

class MedicationReport extends StatefulWidget {
  @override
  _MedicationReportState createState() => new _MedicationReportState();
}

class _MedicationReportState extends State<MedicationReport> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();

  TextEditingController myController1 = new TextEditingController();
  TextEditingController myController2 = new TextEditingController();
  TextEditingController myController3 = new TextEditingController();
  TextEditingController myController4 = new TextEditingController();
  TextEditingController myController5 = new TextEditingController();
  bool _validater = false;
  bool pending = false;
  UserM _user;
  File _image;
  bool _uploaded = false;
  String _downloadUrl;
  String dropdownMediDesc = "Normal";
  String dropdownVaccine = "None";

  final picker = ImagePicker();

  void dispose() {
    super.dispose();
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
  }

  Widget medDescDropDown() {
    return DropdownButton<String>(
      value: dropdownMediDesc,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: <String>[
        "Normal",
        "UFRReport",
        "HIV Report",
        "PPBS Report",
        "OGTT Report",
        "Dental Report",
        "BloodReport",
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          dropdownMediDesc = newValue;
        });
      },
    );
  }

  Widget vaccDropDown() {
    return DropdownButton<String>(
      value: dropdownVaccine,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: <String>[
        'None',
        'Medication Type 1',
        'Medication Type 2',
        'Medication Type 3',
        'Other'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          dropdownVaccine = newValue;
        });
      },
    );
  }

  DateTime _date;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserM>(context);

    return pending
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.lightBlue,
            body: Builder(
              builder: (context) => Container(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height / 6,
                          width: MediaQuery.of(context).copyWith().size.width,
                          color: Colors.lightBlue,
                          child: Container(
                            child: Text(
                              'Submit Medi Info',
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
                                MediaQuery.of(context).size.height * 0.02),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  (5 / 6),
                          width: MediaQuery.of(context).copyWith().size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: ListView(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
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
                                      child: showTextField("Description",
                                          "_Description", myController1),
                                    ),
                                  ),
                                  Container(
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
                                      children: [
                                        Text("Medication Description"),
                                        Spacer(),
                                        medDescDropDown()
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        MediaQuery.of(context).size.height *
                                            0.05,
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.05),
                                    child: Text(
                                      'About Medication',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.005),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        //SizedBox(height: 10.0),
                                        Row(
                                          children: <Widget>[
                                            Text("Upload the Image",
                                                style:
                                                    TextStyle(fontSize: 17.0)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              height: 50.0,
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  getImage(false, context);
                                                },
                                                child: Icon(Icons.camera_alt),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all(
                                                  color: Colors.black,
                                                  style: BorderStyle.solid,
                                                  width: 1.5,
                                                ),
                                              ),
                                              child: _image == null
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(10.0,
                                                          30.0, 10.0, 10.0),
                                                      child: Text(
                                                        'Preview',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )
                                                  : Image.file(
                                                      _image,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.005),
                                    child: showTextField("Doctor's Name",
                                        "_Doctor's_name", myController4),
                                  ),
                                  Container(
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
                                      children: [
                                        Text("Vaccine Name (if any)"),
                                        Spacer(),
                                        vaccDropDown()
                                      ],
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
                                      child: showTextField(
                                          "Remarks", "_Remarks", myController3),
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
                                              "Date",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
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
                                                SizedBox(
                                                  width: 60,
                                                  height: 30,
                                                  child: RaisedButton(
                                                      child: Icon(
                                                          Icons.calendar_today),
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
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                        MediaQuery.of(context).size.height *
                                            0.15),
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
                                              onPressed: () async {
                                                setState(() {
                                                  pending = true;
                                                });
                                                DocumentReference rst =
                                                    await inserting();

                                                dynamic rstImg =
                                                    await _storageService
                                                        .uploadProfileImage(
                                                            _image,
                                                            rst.id,
                                                            "/MedicalReport");

                                                if (rst != null) {
                                                  setState(() {
                                                    pending = false;
                                                    //_displaySnackBar(context);
                                                  });
                                                } else {
                                                  AlertDialog alert =
                                                      AlertDialog(
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  Future getImage(bool isCamera, BuildContext context) async {
    PickedFile image;
    if (isCamera) {
      image = await picker.getImage(
          source: ImageSource.camera, maxHeight: 60.0, maxWidth: 60.0);
    } else {
      image = await picker.getImage(source: ImageSource.gallery);
    }
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        _displaySnackBar(context);
      }
    });
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

  Future<DocumentReference> inserting() async {
    DateTime date = DateTime.now();
    String dateConvert = date.year.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.day.toString();
    DocumentReference userDocRef =
        _firestore.collection('users').doc(_user.uid);
    String name = _user.userCustomData['name'];
    String midID = _user.userCustomData['midwifeID'];

    MediData medi = MediData(
        name: name,
        description: myController1.text,
        vaccine: myController5.text,
        doctorName: myController4.text,
        mumRemarks: myController3.text,
        date: _date.toString(),
        regDate: dateConvert,
        midwifeID: midID,
        userDocRef: userDocRef,status: "pending");

    return await FirebaseFirestore.instance
        .collection("informMedical")
        .add(medi.toJson())
        .then((value) {
      print("record added");
      return value;
    }).catchError((err) {
      return null;
    });
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
    myController4.clear();
  }
}
