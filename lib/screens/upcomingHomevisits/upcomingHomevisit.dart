//import 'dart:html';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mun_care_app/models/homeVisitModel.dart';
import 'package:mun_care_app/models/UserM.dart';
//import 'package:mun_care_app/models/user.dart';
//import 'package:mun_care_app/services/AuthServices.dart';

var uuid = Uuid();

class UpcomingHomeVisitFirebaseDemo extends StatefulWidget {
  final String appTitle = "UpComing Home Visits";
//  final String title;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var useri = new UserM.get().userCredential.user.uid;

  @override
  _UpcomingHomeVisitFirebaseDemoState createState() =>
      _UpcomingHomeVisitFirebaseDemoState();
}

class _UpcomingHomeVisitFirebaseDemoState
    extends State<UpcomingHomeVisitFirebaseDemo> {
  bool isEditing = false;
  bool textFieldVisibility = false;
  TimeOfDay now = TimeOfDay.now();

  UpcomingHomeVisitFirebaseDemo currentHomeVisit;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserM> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebase);
  }

  UserM _userFromFirebase(User user) {
    //String uid = user.uid;
    return user != null ? UserM.setUID(uid: user.uid) : null;
  }

  var useri = new UserM.get().userCredential.user.uid;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                )),
            width: MediaQuery.of(context).size.width,
            height: 110.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "UpComing HomeVisits",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.0,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: StreamBuilder<QuerySnapshot>(
              stream: widget._firestore
                  .collection('Bookings')
                  .doc(useri)
                  .collection('HomeVisits')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loding...');
                }
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      String itemTitle =
                          snapshot.data.docs[index]["description"];
                      return Column(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    openBottomSheet(itemTitle);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(11.0),
                                        height: 70.0,
                                        width: 300.0,
                                        decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                      Positioned(
                                        bottom: 20.0,
                                        child: Container(
                                          height: 50.0,
                                          width: 330.0,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 25.0,
                                        child: Container(
                                          // height: 80.0,
                                          width: 350.0,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 60,
                                                  width: 70,
                                                  margin:
                                                      const EdgeInsets.all(2.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      border: Border.all(
                                                        color: Colors.blueGrey,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                        snapshot
                                                            .data
                                                            .docs[index]
                                                                ['dateTime']
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Spacer(),
                                                            Text(
                                                              "8:16 AM",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      12.0),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['description'],
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                            textAlign:
                                                                TextAlign.left),
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                                snapshot
                                                                    .data
                                                                    .docs[index]
                                                                        [
                                                                        'dateTime']
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left),
                                                            Spacer(),
                                                            Icon(
                                                              Icons.star_border,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20.0,
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
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
    );
    /*Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.lightBlue,
      //appBar: AppBar(
      //title: Text('Page 2' ),
      //title: Text('Upcoming Home Visits'),
      //),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Upcoming Home Visits',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent),
              Spacer(),
              Container(
                alignment: Alignment.topRight,
                // backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                ),
              ),
              Positioned(
                top: 70.0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height - 10.0,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                top: 100.0,
                left: 40.0,
                //child: Container(),
                child: Container(
                  width: 350.0,
                  height: 500.0,
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(19, 19, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      textFieldVisibility
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            )
                          : Container(),
                      Text("Hope your Visiting.Get Ready....",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: buildBody(context),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: FlatButton(
                            color: Colors.white,
                            textColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.blue)),
                            child: Container(
                              /*decoration: BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black, blurRadius: 30.0),
                              ],
                            ),*/
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/sechHomeVisits');
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );*/
  }

  getAllVisits() {
    var useri = new UserM.get().userCredential.user.uid;
    //String uid = user.uid;

    //String fcmToken = await _auth.authStateChanges();
    //user.uid = _auth.authStateChanges();
    return FirebaseFirestore.instance
        .collection('Bookings')
        .doc('IhiVRXSUfZPKoKpaNZgFtlPosj22')
        .collection('HomeVisits')
        .snapshots();
  }

  //delete
  deleteVisits(UpHomeVisit b1) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      // ignore: await_only_futures
      await transaction.delete(b1.documentReference);
    });
  }

  //delete
  /* deleteVisit(Book book) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      // ignore: await_only_futures
      await transaction.delete(book.documentReference);
    });
  }*/

  Widget buildBody(BuildContext context) {
    //  var user = new UserM.get();

    return StreamBuilder<QuerySnapshot>(
      stream: getAllVisits(),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        }
        if (snapshot.hasData) {
          print("Documents -> ${snapshot.data.docs.length}");
          print("uid:${new UserM.get().userCredential.user.uid}");
          return buildList(context, snapshot.data.docs);
        }
      },
    );
  }

//Widget buliList(@override
  Widget buildList(BuildContext context, List<QueryDocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => listItemBuild(context, data)).toList(),
    );
  }

  Widget listItemBuild(BuildContext context, DocumentSnapshot data) {
    final visit = UpHomeVisit.fromSnapshot(data);
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  openBottomSheet('sfsgs');
                },
                child: Stack(
                  alignment: Alignment.center,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(11.0),
                      height: 70.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    Positioned(
                      bottom: 20.0,
                      child: Container(
                        height: 50.0,
                        width: 330.0,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    Positioned(
                      bottom: 25.0,
                      child: Container(
                        // height: 80.0,
                        width: 350.0,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 70,
                                margin: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    border: Border.all(
                                      color: Colors.blueGrey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  key: ValueKey(visit.dateTime),
                                  child: Text(visit.dateTime.toString(),
                                      textAlign: TextAlign.left),
                                  // child: Text(snapshot.data
                                  //   .documents[index]['dateTime']
                                  // .toString(),textAlign: TextAlign.center
                                  //),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Spacer(),

                                          /*Text(
                                            "${now}",
                                            
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0),*/
                                          //new DateTime.now(),
                                        ],
                                      ),
                                      Text(visit.description.toString(),
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left),
                                      Row(
                                        children: <Widget>[
                                          Text(visit.dateTime.toString(),
                                              textAlign: TextAlign.left),
                                          Spacer(),
                                          Icon(
                                            Icons.star_border,
                                            color: Colors.orange,
                                            size: 20.0,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
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
    /*Padding(
      key: ValueKey(visit.dateTime),
      padding: EdgeInsets.symmetric(vertical: 19, horizontal: 1),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: SingleChildScrollView(
          child: ListTile(
            title: Column(
              children: <Widget>[
                Card(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.alarm_add,
                        color: Colors.blue,
                      ),
                      Text(visit.dateTime.toString()),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.messenger_rounded,
                      color: Colors.blue,
                    ),
                    Text(visit.description.toString()),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                // deletewBook(book);
                deleteVisits(visit);
              },
            ),
            onTap: () {
              //setUpdateUI(book);
            },
          ),
        ),
      ),
    );*/
  }

  void openBottomSheet(String itemTitle) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 500.0,
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
                                      "Dear,",
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
                                Text(itemTitle),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "If you can participate this clinic response this. ",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Thank you,",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            // hintText: 'Reply'
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              //onPressed: (),
                            ),
                          ),
                        ),
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
