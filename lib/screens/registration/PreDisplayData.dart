import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PreGetIdDetails extends StatelessWidget {
  final String documentId;

  PreGetIdDetails(this.documentId);
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('PreDatabase');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Scaffold(body:ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Registration Details',style: TextStyle(fontSize: 20),),
                    ),
                    Divider(height: 5,),
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:10,
                            child: Container(),
                          ),
                          Expanded(
                            flex:40,
                            child: Text('MOH Area    :'),
                          ),
                          Expanded(
                            flex:40,
                            child: Text(" ${data['_coName']} ")
                            ),
                          Expanded(
                            flex:10,
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                        
                  ],
                ),
              )
            ],
          ) );
        }

        return Text("Wait Few Second");
      },
    );
  }
}