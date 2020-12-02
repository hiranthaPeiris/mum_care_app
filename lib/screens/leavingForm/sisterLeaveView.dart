import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/models/MidwifeLeave.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaveReportView extends StatefulWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final DateTime getDate;
  //DairlyReportView({Key key, this.getDate}) : super(key: key);

  @override
  _LeaveReportViewState createState() => new _LeaveReportViewState();
}

class _LeaveReportViewState extends State<LeaveReportView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String searchPara = "";
  UserM user=new UserM.get();

  DateTime selected;
  //String itemTitle = "Description";
  DocumentReference documentReference;
  var getUser = new UserM.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 5,
        title: Text('Midwife Leave Forms'),
        //bottom:
      ),
      body: Container(
        child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 30,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Search",
                        alignLabelWithHint: true,
                        icon: SvgPicture.asset("assets/icons/search.svg"),
                        border: InputBorder.none,
                      ),
                      onChanged: (val) {
                        setState(() {
                          searchPara = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    color: Colors.white,
                    child: ClipOval(
                      child: Material(
                        color: Colors.blueAccent, // button color
                        child: InkWell(
                          splashColor: Colors.green, // splash color
                          onTap: () {}, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.filter_list), // icon
                              // Text("Call"), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          color: Colors.blue,
                          child: TabBar(
                            // labelColor: Colors.blue,
                            // unselectedLabelColor: Colors.white,
                            //indicatorSize: TabBarIndicatorSize.label,
                            // indicator: BoxDecoration(
                            //     borderRadius: BorderRadius.only(
                            //         topLeft: Radius.circular(10),
                            //         topRight: Radius.circular(10)),
                            //     color: Colors.white),
                            tabs: [
                              Tab(
                                icon: Icon(Icons.request_page),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Pending"),
                                ),
                              ),
                              Tab(
                                icon: Icon(Icons.check_circle),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Accepted"),
                                ),
                              ),
                              Tab(
                                icon: Icon(Icons.cancel),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Rejected"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 400, //height of TabBarView
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(children: <Widget>[
                              Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: widget._firestore
                                          .collection('MidwifeLeaveforms')
                                          .where('_mohDropDownValue',isEqualTo: user.userCustomData['mohArea'])
                                          .where('_accept', isEqualTo: false)
                                          .where('_reject', isEqualTo: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        print(getUser.userCustomData['role']);
                                        if (!snapshot.hasData) {
                                          return Text('Loding...');
                                        }
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              String documentId =
                                                  snapshot.data.docs[index].id;
                                              return Column(
                                                children: <Widget>[
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () {
                                                            openBottomSheet(
                                                                documentId);
                                                          },
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            // overflow:
                                                            //  Overflow.visible,
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .all(11.0),
                                                                height: 70.0,
                                                                width: 300.0,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .blue),
                                                                    color: Colors
                                                                            .blue[
                                                                        100],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0)),
                                                              ),
                                                              Positioned(
                                                                bottom: 20.0,
                                                                child:
                                                                    Container(
                                                                  height: 50.0,
                                                                  width: 330.0,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0)),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                // bottom: 25.0,
                                                                child:
                                                                    Container(
                                                                  // height: 80.0,
                                                                  width: 350.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .blue[50],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            2.0),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(color: Colors.black),
                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                ),
                                                                                child: SingleChildScrollView(
                                                                                  child: ListTile(
                                                                                    title: Column(
                                                                                      children: <Widget>[
                                                                                        Row(
                                                                                          children: <Widget>[
                                                                                            Icon(
                                                                                              Icons.message,
                                                                                              color: Colors.blue,
                                                                                            ),
                                                                                            Text(snapshot.data.docs[index]['_applicantName'], style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                                                                                          ],
                                                                                        ),
                                                                                        Divider(),
                                                                                        Row(
                                                                                          children: <Widget>[
                                                                                            /*Icon(
                                                                                              Icons.person,
                                                                                              color: Colors.purple,
                                                                                            ),*/
                                                                                            //Spacer(),
                                                                                            Text(snapshot.data.docs[index]['_department'].toString(), textAlign: TextAlign.left),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: widget._firestore
                                          .collection('MidwifeLeaveforms')
                                          .where('_mohDropDownValue',isEqualTo: user.userCustomData['mohArea'])
                                          .where('_accept', isEqualTo: true)
                                          .snapshots(),
                                      //.collection('HomeVisits')
                                      //.snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text('Loding...');
                                        }
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              String itemId =
                                                  snapshot.data.docs[index].id;
                                              return Column(
                                                children: <Widget>[
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () {
                                                            openBottomSheet(
                                                                itemId);
                                                          },
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            // overflow:
                                                            //  Overflow.visible,
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .all(11.0),
                                                                height: 70.0,
                                                                width: 300.0,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .blue),
                                                                    color: Colors
                                                                            .blue[
                                                                        100],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0)),
                                                              ),
                                                              Positioned(
                                                                bottom: 20.0,
                                                                child:
                                                                    Container(
                                                                  height: 50.0,
                                                                  width: 330.0,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0)),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                // bottom: 25.0,
                                                                child:
                                                                    Container(
                                                                  // height: 80.0,
                                                                  width: 350.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .blue[50],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            2.0),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(color: Colors.black),
                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                ),
                                                                                child: SingleChildScrollView(
                                                                                  child: ListTile(
                                                                                    title: Column(
                                                                                      children: <Widget>[
                                                                                        Row(
                                                                                          children: <Widget>[
                                                                                            Icon(
                                                                                              Icons.message,
                                                                                              color: Colors.blue,
                                                                                            ),
                                                                                            Text(snapshot.data.docs[index]['_applicantName'], style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                                                                                          ],
                                                                                        ),
                                                                                        Divider(),
                                                                                        Row(
                                                                                          children: <Widget>[
                                                                                            /*Icon(
                                                                                              Icons.person,
                                                                                              color: Colors.purple,
                                                                                            ),*/
                                                                                            //Spacer(),
                                                                                            Text(snapshot.data.docs[index]['_department'].toString(), textAlign: TextAlign.left),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: widget._firestore
                                          .collection('MidwifeLeaveforms')
                                          .where('_mohDropDownValue',isEqualTo: user.userCustomData['mohArea'])
                                          .where('_reject', isEqualTo: true)
                                          .snapshots(),
                                      //.collection('HomeVisits')
                                      //.snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text('Loding...');
                                        }
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              String itemId =
                                                  snapshot.data.docs[index].id;
                                              return Column(
                                                children: <Widget>[
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () {
                                                            openBottomSheet(
                                                                itemId);
                                                          },
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            // overflow:
                                                            //  Overflow.visible,
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .all(11.0),
                                                                height: 70.0,
                                                                width: 300.0,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .blue),
                                                                    color: Colors
                                                                            .blue[
                                                                        100],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0)),
                                                              ),
                                                              Positioned(
                                                                bottom: 20.0,
                                                                child:
                                                                    Container(
                                                                  height: 50.0,
                                                                  width: 330.0,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0)),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                // bottom: 25.0,
                                                                child:
                                                                    Container(
                                                                  // height: 80.0,
                                                                  width: 350.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .blue[50],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            2.0),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(color: Colors.black),
                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                ),
                                                                                child: SingleChildScrollView(
                                                                                  child: ListTile(
                                                                                    title: Column(
                                                                                      children: <Widget>[
                                                                                        Row(
                                                                                          children: <Widget>[
                                                                                            Icon(
                                                                                              Icons.message,
                                                                                              color: Colors.blue,
                                                                                            ),
                                                                                            Text(snapshot.data.docs[index]['_applicantName'], style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                                                                                          ],
                                                                                        ),
                                                                                        Divider(),
                                                                                        Row(
                                                                                          children: <Widget>[
                                                                                            /*Icon(
                                                                                              Icons.person,
                                                                                              color: Colors.purple,
                                                                                            ),*/
                                                                                            //Spacer(),
                                                                                            Text(snapshot.data.docs[index]['_department'].toString(), textAlign: TextAlign.left),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ]))
                      ])),
            ]),
      ),
    );
  }

  Future<void> setAcceptTrue(String id) async {
    await FirebaseFirestore.instance
        .collection('MidwifeLeaveforms')
        .doc(id)
        .update({
          '_accept': true,
        })
        .then((value) => print("Leave Accepted"))
        .catchError((err) => print(err));
  }

  Future<void> setRejectTrue(String id) async {
    await FirebaseFirestore.instance
        .collection('MidwifeLeaveforms')
        .doc(id)
        .update({
          '_reject': true,
        })
        .then((value) => print("Leave Rejected"))
        .catchError((err) => print(err));
  }

  void openBottomSheet(String itemId) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 400.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Leaving Form",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.blue[700],
                                    ),
                                    Icon(
                                      Icons.more_vert,
                                      color: Colors.blue[700],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("MidwifeLeaveforms")
                              .doc(itemId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }
                            if (!snapshot.hasData) {
                              return Scaffold(
                                body: Text("No data"),
                              );
                            }
                            if (snapshot.hasData) {
                              var value = snapshot.data;
                              Timestamp time1 = value['_applyDate'];
                              var applyDate =
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      time1.microsecondsSinceEpoch);
                              String formattedapplyDate =
                                  DateFormat.yMMMd().format(applyDate);

                              Timestamp time2 = value['_appoimentDate'];
                              var appoimentDate =
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      time2.microsecondsSinceEpoch);
                              String formattedappoimentDate =
                                  DateFormat.yMMMd().format(appoimentDate);

                              Timestamp time3 = value['_leaveOnDate'];
                              var leaveOnDate =
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      time3.microsecondsSinceEpoch);
                              String formattedleaveOnDate =
                                  DateFormat.yMMMd().format(leaveOnDate);

                              Timestamp time4 = value['_leaveOffDate'];
                              var leaveOffDate =
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      time4.microsecondsSinceEpoch);
                              String formattedleaveOffDate =
                                  DateFormat.yMMMd().format(leaveOffDate);
                              return Column(children: [
                                Row(
                                  children: [
                                    Text("Applicant Name:"),
                                    Text(value['_applicantName']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Apply Date:"),
                                    value['_applyDate'] == null
                                        ? Text("Not Selected")
                                        : Text(formattedapplyDate),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Department:"),
                                    Text(value['_department']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Date of the Appoiment:"),
                                    value['_appoimentDate'] == null
                                        ? Text("Not Selected")
                                        : Text(formattedappoimentDate),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Number of Leave Days :"),
                                    Text(value['_numOfDays']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Leave to Commence on:"),
                                    value['_leaveOnDate'] == null
                                        ? Text("Not Selected")
                                        : Text(formattedleaveOnDate),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Leave to End on:"),
                                    value['_leaveOffDate'] == null
                                        ? Text("Not Selected")
                                        : Text(formattedleaveOffDate),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Reason for Application   :"),
                                    Text(value['_reason']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Address of Applicant  :"),
                                    Text(value['_applicantAddress']),
                                  ],
                                ),
                              ]);
                            }
                          }),
                    ),
                    Text(
                      "Thank you,",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  setRejectTrue(itemId);
                                },
                                child: Text('Reject'),
                              ),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                child: Text('Accept'),
                                onPressed: () {
                                  setAcceptTrue(itemId);
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
            ),
          );
        });
  }
}
