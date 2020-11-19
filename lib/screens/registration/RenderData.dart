import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/models/UserReg.dart';

import 'ComDisplayData.dart';
import 'PreDisplayData.dart';


class ComRenderData extends StatefulWidget {
  @override
  _ComRenderDataState createState() => _ComRenderDataState();
}

class _ComRenderDataState extends State<ComRenderData> {

  getStepOneData() {
    return Firestore.instance.collection('ComDatabase').snapshots();
  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder(
        stream: getStepOneData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          if (snapshot.hasData) {
            print("Document -> ${snapshot.data.documents.length}");
            return buildList(context, snapshot.data.documents);
          }
        });
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => listItemBuild(context, data)).toList(),
    );
  }


  Widget listItemBuild(BuildContext context, DocumentSnapshot data) {
    final comRegBD = ComRegDB.fromSnapshot(data);

    //final comStep2 = ComStepTwo.fromSnapshot(data);
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
                  title:  data['_wifeName']!="" ?Text("${data['_wifeName']} Details"):Text('No Details'),
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
    return Scaffold(
      appBar: AppBar(
        title: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Registration List',style: TextStyle(fontSize: 20),),
                    ),
      ),
      //height: 500,
      body: buildBody(context),
    );
  }
}
