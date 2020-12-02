import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:mun_care_app/models/UserReg.dart';
import 'package:mun_care_app/services/AuthServices.dart';
//import 'dart:html';

//import 'ComDisplayData.dart';

class DutyCheck extends StatefulWidget {
  AuthService n;
  @override
  _DutyCheckState createState() => _DutyCheckState();
}

class _DutyCheckState extends State<DutyCheck> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //new UserM.get().userCredential.user.uid;

  getData01() {
    return FirebaseFirestore.instance
        .collection("users")
        .where('onDuty', isEqualTo: true)
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
          if(!snapshot.hasData){
            return Center(child: Text("No data here"));
          }
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
              color: Colors.blueAccent,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    //isThreeLine: true,
                    leading: Icon(Icons.arrow_drop_down_circle),
                    title: data['name'] != ""
                        ? Text("${data['name']} ")
                        : Text('No Details'),
                    subtitle: Text(
                      "OnDuty",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          Navigator.pushNamed(context, '/geoLocate');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.location_pin,size: 20.0,),
                            const Text('Location'),
                          ],
                        ),
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
          String role = value['role'].toString();
          print(role);
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          if (snapshot.hasData) {
            return buildBody01(context);
          }
        },
      );
    }

    return Scaffold(
      //backgroundColor: Colors.pinkAccent,
      body: getState(context),
    );
  }
}
