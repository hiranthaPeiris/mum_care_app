import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:mun_care_app/models/UserReg.dart';
import 'package:mun_care_app/screens/registration/PreDisplayData.dart';
//import 'dart:html';

//import 'ComDisplayData.dart';

class DutyCheck extends StatefulWidget {
  @override
  _DutyCheckState createState() => _DutyCheckState();
}

class _DutyCheckState extends State<DutyCheck> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //new UserM.get().userCredential.user.uid;

  getData01() {
    return FirebaseFirestore.instance
        .collection("users")
        .where('_onDuty', isEqualTo: true)
        .snapshots();

    //.doc(_auth.currentUser.uid)
    // .collection("onDuty")
    //.doc(_auth.currentUser.uid)
    //.where('_onDuty', isEqualTo: true)
    //.snapshots();
  }

  Widget buildBody01(BuildContext context) {
    return StreamBuilder(
        stream: getData01(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          if (snapshot.hasData) {
            print("Document -> ${snapshot.data.documents.length}");
            return buildList01(context, snapshot.data.documents);
          }
        });
  }

  Widget buildList01(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => listItemBuild01(context, data)).toList(),
    );
  }

  Widget listItemBuild01(BuildContext context, DocumentSnapshot data) {
    // final ondutyState = OndutyState.fromSnapshot(data);
    return Padding(
      //key: ValueKey(comStep1.husbandName),
      padding: EdgeInsets.symmetric(vertical: 19, horizontal: 19),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.arrow_drop_down_circle),
                    title: data['name'] != ""
                        ? Text("${data['name']} ")
                        : Text('No Details'),
                    subtitle: Text(
                      "OnDuty",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  /*ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ComGetIdDetails(comRegBD.documentReference.id)),
                                      );
                        },
                        child: const Text('Competency'),
                      ),
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PreGetIdDetails(comRegBD.documentReference.id)),
                                      );
                        },
                        child: const Text('Pregnancy'),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget getState(BuildContext context) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          var value = snapshot.data;
          String role = value['role'].toString();
          print(role);
          if (snapshot.hasData) {
            return buildBody01(context);
          }
        },
      );
    }

    return Scaffold(
      body: getState(context),
    );
  }
}
