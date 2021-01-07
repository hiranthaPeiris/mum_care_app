import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/Reviews/MotherList.dart';

class MotherAssign extends StatefulWidget {
  @override
  _MotherAssignState createState() => _MotherAssignState();
}

class _MotherAssignState extends State<MotherAssign> {
  String val1, val2, val3, name, id;
  var _auth = FirebaseAuth.instance.currentUser;
  bool correct = false;
  DocumentSnapshot snapshot;

  void getData() async {
    final data = await FirebaseFirestore.instance
        .collection("ComDatabase")
        .doc(_auth.uid)
        .get();
    snapshot = data;
    print(snapshot["_mohDropDownValue"]);
    FirebaseFirestore.instance
        .collection("users")
        .where('role', isEqualTo: "midwife")
        .where('mohArea', isEqualTo: snapshot["_mohDropDownValue"])
        .where('area01', isEqualTo: snapshot["_phmDropDownValue"])
        .get()
        .then((querySnapshot) {
      setState(() {
        print(querySnapshot.docs.first["area01"]);
        val1 = querySnapshot.docs.first["area01"];
        name = querySnapshot.docs.first["name"];
        id = querySnapshot.docs.first.id;
        correct = true;
      });
    });
    print(name);
    correct
        ? FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.uid)
            .update({
              'midwifeID': id,
            })
            .then((value) => print("midwife id update"))
            .catchError((err) => print(err))
        : print("Not update");
  }

  @override
  Widget build(BuildContext context) {
    Widget getState(BuildContext context) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("ComDatabase")
            .doc(_auth.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("No Data");
          }
          if (snapshot.hasData) {
            var value = snapshot.data;
            FirebaseFirestore.instance
                .collection("users")
                .where('role', isEqualTo: "midwife")
                .where('mohArea', isEqualTo: snapshot.data["_mohDropDownValue"])
                .where('area01', isEqualTo: snapshot.data["_phmDropDownValue"])
                .get()
                .then((querySnapshot) {
              querySnapshot.docs.forEach((result) {
                setState(() {
                  val1 = result.data()["area01"];
                  name = result.data()["name"];
                  id = result.id;
                });
              });
            });
          }
          FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.uid)
              .update({
                'midwifeID': id,
              })
              .then((value) => print("midwife id update"))
              .catchError((err) => print(err));
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(snapshot.data["_wifeName"].toString() +
                    " your midwife name is " +
                    name),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Midwife Details"),
        leading: FlatButton(
            onPressed: () {
              getData();
            },
            child: Text("press")),
      ),
      body: Text("press"),
    );
  }
}
