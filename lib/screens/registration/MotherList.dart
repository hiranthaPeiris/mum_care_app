import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/models/UserReg.dart';
import 'package:mun_care_app/screens/registration/PreDisplayData.dart';

import 'ComDisplayData.dart';

class MotherList extends StatefulWidget {
  @override
  _MotherListState createState() => _MotherListState();
}

class _MotherListState extends State<MotherList> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  getData01(String area) {
    return FirebaseFirestore.instance
        .collection("ComDatabase")
        .where('_phmDropDownValue', isEqualTo: area)
        .snapshots();
  }

  Widget buildBody01(BuildContext context, String abc) {
    return StreamBuilder(
        stream: getData01(abc),
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
    final comRegBD = ComRegDB.fromSnapshot(data);
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
                    title: data['_wifeName'] != ""
                        ? Text("${data['_wifeName']} Details")
                        : Text('No Details'),
                    subtitle: Text(
                      "${data['_nic']}",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  ButtonBar(
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
                  ),
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
          String area = value['area01'].toString();
          print(area);
          if (snapshot.hasData) {
            return buildBody01(context, area);
          }
        },
      );
    }

    return Scaffold(
      body: getState(context),
    );
  }
}
