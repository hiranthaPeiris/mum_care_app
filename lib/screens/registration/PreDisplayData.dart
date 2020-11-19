import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/models/UserReg.dart';

class PreGetIdDetails extends StatelessWidget {
  final String documentId;

  PreGetIdDetails(this.documentId);
  @override
  Widget build(BuildContext context) {
    Widget getState(BuildContext context) {
      FirebaseAuth _auth = FirebaseAuth.instance;
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("PreDatabase")
            .doc(_auth.currentUser.uid)
            .collection("G1")
            .doc("G1")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var value = snapshot.data;
              return ListView(
              children: [
                Text(value["_womb"].toString()),
                Text(value["_details"].toString()),
                Text(value["_womb"].toString()),
                Text(value["_womb"].toString()),
                Text(value["_womb"].toString()),
              ],
            );
          }
        },
      );
    }

    CollectionReference users =
        FirebaseFirestore.instance.collection('PreDatabase');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (!snapshot.hasData) {
          return Scaffold(
            body: Text("No data"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data.data();
          return Scaffold(
              body: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Registration Details',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(500, 21, 166, 211),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 10,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 40,
                            child: Container(),
                          ),
                          Expanded(flex: 40, child: Text("")),
                          Expanded(
                            flex: 10,
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Text('Grama Niladari Division :'),
                          ),
                          Expanded(
                              flex: 50, child: Text(" ${data['_gnDivision']} "))
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Text('Field Clinic :'),
                          ),
                          Expanded(
                              flex: 50, child: Text(" ${data['_fcName']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Text('Hospital in Clinic :'),
                          ),
                          Expanded(
                              flex: 50, child: Text(" ${data['_hcName']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Text('Consultant Obstetrician :'),
                          ),
                          Expanded(
                              flex: 50, child: Text(" ${data['_coName']} "))
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(padding: const EdgeInsets.all(8.0),
                      child:ListView(
                        scrollDirection: Axis.horizontal,
                        children:<Widget> [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              child: getG1(context),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              child: getG2(context),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              //child: getG3(context),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              //child: getG4(context),
                            ),
                          ),
                        ],
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.001,
                          MediaQuery.of(context).size.height * 0.02,
                          MediaQuery.of(context).size.width * 0.03,
                          MediaQuery.of(context).size.height * 0.01),
                      child: Container(
                        child: Text(
                          "Present Obstetric History",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            // color: Color.fromARGB(500, 21, 166, 211),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Text('Present vaginal bleeding :'),
                          ),
                          Expanded(flex: 50, child: Text(" ${data['_pvb']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Text('Blood Plessure :'),
                          ),
                          Expanded(flex: 50, child: Text(" ${data['_pvb']} "))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
        }

        return Text("Wait Few Second");
      },
    );
  }
}
