//import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mun_care_app/models/homeVisitModel.dart';
import 'package:mun_care_app/models/UserM.dart';
//import 'package:mun_care_app/models/user.dart';
//import 'package:mun_care_app/services/AuthServices.dart';

class UpcomingHomeVisitFirebaseDemo extends StatefulWidget {
  final String appTitle = "UpComing Home Visits";

  @override
  _UpcomingHomeVisitFirebaseDemoState createState() =>
      _UpcomingHomeVisitFirebaseDemoState();
}

class _UpcomingHomeVisitFirebaseDemoState
    extends State<UpcomingHomeVisitFirebaseDemo> {
  bool isEditing = false;
  bool textFieldVisibility = false;

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

  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  getAllVisits() {
    var useri = new UserM.get().userCredential.user.uid;
    //String uid = user.uid;

    //String fcmToken = await _auth.authStateChanges();
    //user.uid = _auth.authStateChanges();
    return FirebaseFirestore.instance
        .collection('Bookings')
        .doc(useri)
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

  /*getAllBooks() {
    var alovelaceDocumentRef =
        _firestore.collection('Bookings').doc('HomeVisits');
    return alovelaceDocumentRef.snapshots();
  }*/

  /* Future<Map<String, dynamic>> getUpHomeVisits(String uid, String) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data : ${documentSnapshot.data()}');
        return documentSnapshot.data();
      } else {
        print("document not exists");
        return null;
      }
    });
  }*/

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
    return Padding(
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
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.alarm_add,
                      color: Colors.blue,
                    ),
                    Text(visit.dateTime.toString()),
                  ],
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
    );
  }
}

/*setUpdateUI(Book book) {
    //  bookNameController.text = book.bookName;
    //bookAuthorController.text = book.bookName;
    setState(() {
      textFieldVisibility = true;
      isEditing = true;
      currentBook = book;
    });
  }*/

/*button() {
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        child: Text(isEditing ? "UPDATE" : "ADD"),
        onPressed: () {
          if (isEditing == true) {
            updateIfEditing();
          } else {
            addBook();
          }
          setState(() {
            textFieldVisibility = false;
          });
        },
      ),
    );
  }*/
