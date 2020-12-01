import 'package:flutter/material.dart';
import 'package:mun_care_app/screens/reports/dairlyReportView.dart';

class ReportSearch extends StatefulWidget {
  @override
  _ReportSearchState createState() => _ReportSearchState();
}

class _ReportSearchState extends State<ReportSearch> {
  DateTime _dayReport;
  DateTime _monthReport;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).copyWith().size.height / 5,
                    width: MediaQuery.of(context).copyWith().size.width,
                    color: Colors.lightBlue,
                    child: Container(
                      child: Text(
                        'Monthly and Daily Report',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.1,
                          MediaQuery.of(context).size.height * 0.06,
                          MediaQuery.of(context).size.width * 0.2,
                          MediaQuery.of(context).size.height * 0.04),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
                    height:
                        MediaQuery.of(context).copyWith().size.height * (4 / 5),
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
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.005,
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.height * 0.005),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Daily Report Search',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                ////////////////////////////////
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height *
                                          (1 / 4),
                                      width: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .width *
                                          4 /
                                          5,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Select Your Date',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  child: RaisedButton(
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Icon(
                                                            Icons
                                                                .calendar_today,
                                                            size: 75,
                                                            color: Colors
                                                                .blueAccent,
                                                          )),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        500,
                                                                        21,
                                                                        166,
                                                                        211),
                                                              )),
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
                                                                        2021))
                                                            .then((date) {
                                                          setState(() {
                                                            _dayReport = date;
                                                          });
                                                        });
                                                      }),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          _dayReport == null
                                                              ? "-------"
                                                              : _dayReport.year
                                                                      .toString() +
                                                                  "/" +
                                                                  _dayReport
                                                                      .month
                                                                      .toString() +
                                                                  "/" +
                                                                  _dayReport.day
                                                                      .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child:
                                                                ElevatedButton(
                                                              child: Text(
                                                                  'Search'),
                                                              onPressed: () {
                                                                if (_dayReport !=
                                                                    null) {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                DairlyReportView(getDate: _dayReport)),
                                                                  );
                                                                } else {
                                                                  Widget
                                                                      okButton =
                                                                      FlatButton(
                                                                    child: Text(
                                                                        "OK"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  );

                                                                  // set up the AlertDialog
                                                                  AlertDialog
                                                                      alert =
                                                                      AlertDialog(
                                                                    title: Text(
                                                                        "Attention"),
                                                                    content: Text(
                                                                        "Please select a date to get daily reports"),
                                                                    actions: [
                                                                      okButton
                                                                    ],
                                                                  );

                                                                  // show the dialog
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return alert;
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
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
                                  ],
                                ),
                                ////////////////////////////////////////////////
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Month Report Search',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                ///////////////////////
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height *
                                          (1 / 4),
                                      width: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .width *
                                          4 /
                                          5,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Select Your Month',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  child: RaisedButton(
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Icon(
                                                            Icons
                                                                .calendar_today,
                                                            size: 75,
                                                            color: Colors
                                                                .blueAccent,
                                                          )),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        500,
                                                                        21,
                                                                        166,
                                                                        211),
                                                              )),
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
                                                                        2021))
                                                            .then((date) {
                                                          setState(() {
                                                            _monthReport = date;
                                                          });
                                                        });
                                                      }),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          _monthReport == null
                                                              ? "-------"
                                                              : _monthReport
                                                                      .year
                                                                      .toString() +
                                                                  "/" +
                                                                  _monthReport
                                                                      .month
                                                                      .toString() +
                                                                  "/" +
                                                                  _monthReport
                                                                      .day
                                                                      .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child:
                                                                ElevatedButton(
                                                              child: Text(
                                                                  'Search'),
                                                              onPressed: () {
                                                                if (_monthReport !=
                                                                    null) {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      '/leaveForm');
                                                                } else {
                                                                  Widget
                                                                      okButton =
                                                                      FlatButton(
                                                                    child: Text(
                                                                        "OK"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  );

                                                                  // set up the AlertDialog
                                                                  AlertDialog
                                                                      alert =
                                                                      AlertDialog(
                                                                    title: Text(
                                                                        "Attention"),
                                                                    content: Text(
                                                                        "Please select a date to get daily reports"),
                                                                    actions: [
                                                                      okButton
                                                                    ],
                                                                  );

                                                                  // show the dialog
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return alert;
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
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
                                  ],
                                ),
                                ///////////////////////////////////////////////
                              ],
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
        ));
  }
}
