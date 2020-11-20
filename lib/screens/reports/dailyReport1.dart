import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DairlyReport extends StatefulWidget {
  @override
  _DairlyReportState createState() => new _DairlyReportState();
}

class _DairlyReportState extends State<DairlyReport> {
  DateTime selected;
  DateTime _date4;
  DateTime _date1;
  DateTime _date2;
  DateTime _date3;

  TextEditingController name = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController newMothers = TextEditingController();
  TextEditingController visiting = TextEditingController();
  TextEditingController registerdMothers = TextEditingController();

  String mohDropdownValue = 'Select Area';
  String phmDropdownValue = 'Select Area';
  String ageDropdownValue = '<16';
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
          'One',
          'Two',
          'Happy New Year mmmmmm',
          'Four'
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
        items: <String>['Select Area', 'Five', 'Six', 'Seven', 'Eight']
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
            phmDropdownValue = value;
          });
        },
      );
    }

    Widget ageDropDownMenu() {
      return DropdownButton<String>(
        value: ageDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 36,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        items: <String>['<16', '16-17', '18-19', '20-35', '>35']
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
            ageDropdownValue = value;
          });
        },
      );
    }

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
                      'Dairly Report',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                                Expanded(flex: 5, child: Container()),
                                Expanded(
                                    flex: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 25,
                                        child: Text(
                                          "MOH Area  -                    ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 16,
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
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            boxShadow: [
                                              new BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 10.0),
                                            ],
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: 0.5)),
                                        child: mohDropDownMenu()),
                                  ),
                                ),
                                Expanded(flex: 5, child: Container()),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(flex: 5, child: Container()),
                                Expanded(
                                    flex: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 25,
                                        child: Text(
                                          "PHM Area  -                    ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 16,
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
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            boxShadow: [
                                              new BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 10.0),
                                            ],
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: 0.5)),
                                        child: phmDropDownMenu()),
                                  ),
                                ),
                                Expanded(flex: 5, child: Container()),
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
                                      controller: newMothers,
                                      decoration: InputDecoration(
                                        labelText: "Newly Registered mothers",
                                        hintText:
                                            "Enter the Num of New mothers",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please Enter the Num of New mothers";
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
                              children: <Widget>[
                                Expanded(flex: 5, child: Container()),
                                Expanded(
                                  flex: 100,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    child: TextFormField(
                                      controller: visiting,
                                      decoration: InputDecoration(
                                        labelText: "Number of visiting",
                                        hintText: "Enter the Num of visiting",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please Enter the Num of visiting";
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
                              children: <Widget>[
                                Expanded(flex: 5, child: Container()),
                                Expanded(
                                  flex: 100,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    child: TextFormField(
                                      controller: newMothers,
                                      decoration: InputDecoration(
                                        labelText: "Newly marrage Couples",
                                        hintText:
                                            "Enter the Num of New marrage couples",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please Enter the Num of New marrage couples";
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
                              children: <Widget>[
                                Expanded(flex: 5, child: Container()),
                                Expanded(
                                  flex: 100,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: TextFormField(
                                      controller: registerdMothers,
                                      decoration: InputDecoration(
                                        labelText:
                                            "Num of Registered mothers by Midwife",
                                        hintText: "Enter the mother",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please Enter the Registered mothers by Midwife";
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
                                      controller: registerdMothers,
                                      decoration: InputDecoration(
                                        labelText:
                                            "Num of Registered mothers by Midwife(before 3 week)",
                                        hintText: "Enter the mother",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please Enter the Registered mothers by Midwife";
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
                                      controller: registerdMothers,
                                      decoration: InputDecoration(
                                        labelText:
                                            "Num of Registered mothers by Midwife(before 12 week)",
                                        hintText: "Enter the mother",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please Enter the Registered mothers by Midwife";
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
                                    flex: 50,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 4, 4, 0),
                                      child: Container(
                                        height: 25,
                                        child: Text(
                                          "Age of the Mothers         -",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 16,
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
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            boxShadow: [
                                              new BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 10.0),
                                            ],
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: 0.5)),
                                        child: ageDropDownMenu()),
                                  ),
                                ),
                                Expanded(flex: 5, child: Container()),
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
                                  child: Text('Continue'),
                                  onPressed: () {
                                    //Navigator.push(
                                    //  context,
                                    // MaterialPageRoute(
                                    //    builder: (context) => PreFamReg()));
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
      ),
    );
  }
}
