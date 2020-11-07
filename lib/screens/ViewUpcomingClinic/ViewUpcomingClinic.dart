import 'package:flutter/material.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';

var uuid = Uuid();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: ViewUpcomingClinic(),
    );
  }
}

class ViewUpcomingClinic extends StatefulWidget
{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  _ViewUpcomingState createState() => new _ViewUpcomingState();
}

class _ViewUpcomingState extends State<ViewUpcomingClinic> {
  var user = new UserM.get();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: SafeArea(
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .copyWith()
                          .size
                          .height / 5,
                      width: MediaQuery
                          .of(context)
                          .copyWith()
                          .size
                          .width,
                      color: Colors.lightBlue,
                      child: Container(
                        child: Text('Upcoming Clinics', style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white), textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.09,
                            MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),
                      ),
                    ),
                  ),

                ),
                Container(
                 padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: MediaQuery
                      .of(context)
                      .copyWith()
                      .size
                      .height*100,
                  width: MediaQuery
                      .of(context)
                      .copyWith()
                      .size
                      .width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),

                  child: Column(

                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: widget._firestore.collection('Bookings').doc(
                                          user.uid).collection('Clinics').snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text('Loding...');
                                        }
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: snapshot.data.documents.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: <Widget>[
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.23,
                                                          height: MediaQuery.of(context).size.height * 0.12,
                                                          margin: EdgeInsets.all(4.0),
                                                          padding: EdgeInsets.fromLTRB(
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width * 0.0005,
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.04,
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width * 0.0005,
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.005),
                                                          decoration:BoxDecoration(
                                                            borderRadius:BorderRadius.circular(200),
                                                            color:Colors.lightBlueAccent,

                                                          ),
                                                          child: Text(snapshot.data
                                                              .documents[index]['dateTime']
                                                              .toString(),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.68,
                                                          height: MediaQuery.of(context).size.height * 0.12,
                                                          padding: EdgeInsets.fromLTRB(
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width * 0.05,
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.005,
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width * 0.005,
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.005),

                                                          decoration:BoxDecoration(
                                                            borderRadius:BorderRadius.circular(10),
                                                            color:Colors.blue.shade50,
                                                          ),
                                                          child: Column(

                                                            children: <Widget>[
                                                          Text(snapshot.data
                                                              .documents[index]['description'], style: TextStyle(fontSize: 15),textAlign: TextAlign.left),
                                                              Text(snapshot.data
                                                                  .documents[index]['dateTime']
                                                                  .toString(),textAlign: TextAlign.left),
                                                            ],
                                                          ),
                                                          /*child: Text(snapshot.data
                                                              .documents[index]['description'], style: TextStyle(fontSize: 15)),*/

                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                  ),

                                ],

                              ),
                            ],

                          ),
                        ),

              ],
            ),
          ],
        ),

      ),

    );
  }
}
