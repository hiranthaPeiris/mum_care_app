import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MotherAssign extends StatefulWidget {
  @override
  _MotherAssignState createState() => _MotherAssignState();
}

class _MotherAssignState extends State<MotherAssign> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String val1,val2,val3,name;
  @override
  Widget build(BuildContext context) {
    Widget getState(BuildContext context) {
      FirebaseAuth _auth = FirebaseAuth.instance;
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("ComDatabase")
            .doc(_auth.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var value = snapshot.data;
            return ListView(
              children: [
                Text(value["_phmDropDownValue"].toString()),
              ],
            );
          }
        },
      );
    }

    void _onPressed02() {
      FirebaseFirestore.instance
          .collection("users")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          if (result.data()["role"] == "midwife") {
            setState(() {
              val1 = result.data()["area01"];
              val2=result.data()["area02"];
              val3=result.data()["area03"];
              name=result.data()["name"];
              
            });
            //print(val);
          }
          //return val;
        });
      });
    }

    void _onPressed01() {
      FirebaseFirestore.instance
          .collection("ComDatabase")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          //String val1=_onPressed02().toString();
          if (result.data()["_phmDropDownValue"] ==val1 ) {
            //String val = result.data()["_phmDropDownValue"];
            print( result.data()["_wifeName"]+" Your area midwife is "+name);
          } 
          else{
            print("Not Match");
          }
        });
      });
    }

    return Scaffold(
        body: Container(
      child: FlatButton(
          onPressed: () {
            _onPressed02();
            _onPressed01();
          },
          child: Container(
            child: Text("Hello"),
          )),
    ));
  }
}
