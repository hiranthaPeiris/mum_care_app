import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/screens/registration/MotherList.dart';

class MotherAssign extends StatefulWidget {
  @override
  _MotherAssignState createState() => _MotherAssignState();
}

class _MotherAssignState extends State<MotherAssign> {
  String val1, val2, val3, name, id;
  FirebaseAuth _auth = FirebaseAuth.instance;

  
getData02() {
    return FirebaseFirestore.instance
                .collection("users")
                .where('role', isEqualTo: "midwife")
        .snapshots();
  }

  Widget buildBody02(BuildContext context) {
    return StreamBuilder(
        stream: getData02(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          if (snapshot.hasData) {
            print("Document -> ${snapshot.data.documents.length}");
            return buildList02(context, snapshot.data.documents);
          }
        });
  }

  Widget buildList02(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => listItemBuild02(context, data)).toList(),
    );
  }

  Widget listItemBuild02(BuildContext context, DocumentSnapshot data) {
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
                        ? Text("${data['name']} Details")
                        : Text('No Details'),
                    subtitle: Text(
                      "${data['midwifeID']}",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          
                        },
                        child: const Text('Check Mother list'),
                      ),/*
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MotherList(data['area01'])),
                                      );
                        },
                        child: const Text('Pregnancy'),
                      ),*/
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
            .collection("ComDatabase")
            .doc(_auth.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var value = snapshot.data;
            FirebaseFirestore.instance
                .collection("users")
                .where('role', isEqualTo: "midwife")
                .get()
                .then((querySnapshot) {
              querySnapshot.docs.forEach((result) {
                val1 = result.data()["area01"];
                name = result.data()["name"];
                id = result.data()["midwifeID"];

                print(result.data()["area01"]);
                if (value["_phmDropDownValue"].toString() ==
                    result.data()["area01"]) {
                  //print(value["_phmDropDownValue"].toString());
                  //String val = result.data()["_phmDropDownValue"];
                  // print( result.data()["_wifeName"]+" Your area midwife is "+name);
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Text(value["_wifeName"].toString() +
                          " your midwife name is " +
                          name),
                      Text(id),
                    ],
                  );
                } else {
                  return Text("Not Match");
                }
              });
            });
          }
        },
      );
    }

    return Scaffold(
      body: buildBody02(context),
    );
  }
}
