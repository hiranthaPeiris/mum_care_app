import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MonthlyReport extends StatefulWidget {
  @override
  _MonthlyReportState createState() => _MonthlyReportState();
}

TextEditingController visitedHomes = TextEditingController();
TextEditingController eligibleFam = TextEditingController();
TextEditingController antenatalFam = TextEditingController();
TextEditingController postPartum = TextEditingController();
TextEditingController children = TextEditingController();
TextEditingController famPlanning = TextEditingController();
TextEditingController clinicPartici = TextEditingController();

String montherval = 'Maala';
String childval = 'Nikini';

class _MonthlyReportState extends State<MonthlyReport> {
  Widget motherNameDropDownMenu() {
    return DropdownButton<String>(
      value: montherval,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 20,
      isExpanded: true,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0),
      items: <String>['Maala', 'Seetha', 'Kamala', 'Nimali']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              value,
              //textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          montherval = value;
        });
      },
    );
  }

  Widget childrenNameDropDownMenu() {
    return DropdownButton<String>(
      value: childval,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 20,
      isExpanded: true,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0),
      items: <String>['Nikini', 'Thimir', 'Sharuk', 'Khan']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              value,
              //textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          childval = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner:false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Report'),
        //toolbarHeight:Icon(Icons.ac_unit_sharp),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      /* Container(
                        // child: Text('grg',
                        // style: TextStyle(color: Colors.black, fontSize: 12)),
                        height: 40.0,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        color: Colors.lightBlue,

                        child: Text("Monthly Report",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 20)),
                      ),*/
                      /*  Row(
                        children: <Widget>[
                          //Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                          Container(
                            height: 40.0,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Mother Name:",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: motherNameDropDownMenu(),
                            height: 40.0,
                            width: 100.0,
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.white,
                              //color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 40.0,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Child Name   :",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: childrenNameDropDownMenu(),
                            height: 40.0,
                            width: 100.0,
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.white,
                              //color: Colors.green,
                            ),
                          ),
                        ],
                      ),*/
                      TextFormField(
                        controller: visitedHomes,
                        decoration: InputDecoration(
                          labelText: "Number of visited homes",
                          hintText: "Enter the number of visited homes",
                        ),
                      ),
                      TextFormField(
                        controller: clinicPartici,
                        decoration: InputDecoration(
                          labelText: "Number of Clinic participants ",
                          hintText: "Enter the Number of Clinic participants",
                        ),
                      ),
                      TextFormField(
                        controller: eligibleFam,
                        decoration: InputDecoration(
                          labelText: "Number of eligible families",
                          hintText: "Enter the number of eligible families",
                        ),
                      ),
                      TextFormField(
                        controller: antenatalFam,
                        decoration: InputDecoration(
                          labelText: "Number of antenatal families",
                          hintText: "Enter the number of antenatal families",
                        ),
                      ),
                      TextFormField(
                        controller: postPartum,
                        decoration: InputDecoration(
                          labelText: "Number of postpartum families",
                          hintText: "Enter the Number of postpartum families",
                        ),
                      ),
                      TextFormField(
                        controller: children,
                        decoration: InputDecoration(
                          labelText: "Number of children",
                          hintText: "Enter the Number of children",
                        ),
                      ),
                      TextFormField(
                        controller: famPlanning,
                        decoration: InputDecoration(
                          labelText: "Number of family planning",
                          hintText: "Enter the Number of family planning",
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
                            'Submit',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
