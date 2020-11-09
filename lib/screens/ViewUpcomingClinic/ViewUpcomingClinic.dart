import 'package:flutter/material.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:mun_care_app/widgets/FirebaseMessageWapper.dart';
import 'package:mun_care_app/widgets/Menu_card.dart';
import 'package:mun_care_app/widgets/Menu_linear_card.dart';
import 'package:mun_care_app/widgets/Search_bar.dart';

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

class ViewUpcomingClinic extends StatefulWidget {
  ViewUpcomingClinic({Key key, this.title}) : super(key: key);

  final String title;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _ViewUpcomingClinicState createState() => _ViewUpcomingClinicState();
}

class _ViewUpcomingClinicState extends State<ViewUpcomingClinic> {
  var user = new UserM.get();

  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )),
              width: MediaQuery.of(context).size.width,
              height: 110.0,

              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 50.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "UpComing Clinics",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),

                ],
              ),
            ),



            Container(
              //height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
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
                                  String itemTitle = snapshot.data.documents[index]["description"];
                                  return Column(
                                      children: <Widget>[
                                       SingleChildScrollView(
                                         child: Column(
                                            children: <Widget>[

                                          InkWell(
                                            onTap: ()
                                            {
                                              openBottomSheet(itemTitle);
                                            },

                                            child: Stack(
                                              alignment: Alignment.center,
                                              overflow: Overflow.visible,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.all(10.0),
                                                  height: 70.0,
                                                  width: 300.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue[100],
                                                      borderRadius: BorderRadius.circular(15.0)),
                                                ),
                                                Positioned(
                                                  bottom: 20.0,
                                                  child: Container(
                                                    height: 50.0,
                                                    width: 330.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius: BorderRadius.circular(15.0)),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 25.0,
                                                  child: Container(
                                                   // height: 80.0,
                                                    width: 350.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[50],
                                                      borderRadius: BorderRadius.circular(15.0),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            height:60,
                                                            width: 70,
                                                            margin:const EdgeInsets.all(2.0),
                                                            decoration: BoxDecoration(
                                                                color: Colors.blue,
                                                                border: Border.all(
                                                                        color: Colors.blueGrey,
                                                                           width: 2,
                                                                  ),
                                                                borderRadius: BorderRadius.circular(10.0)),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Text(snapshot.data
                                                                  .documents[index]['dateTime']
                                                                        .toString(),textAlign: TextAlign.center
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(2.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <Widget>[
                                                                      Spacer(),
                                                                      Text(
                                                                        "8:16 AM",
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(snapshot.data
                                                                      .documents[index]['description'], style: TextStyle(fontSize: 15),textAlign: TextAlign.left),

                                                                  Row(
                                                                    children: <Widget>[
                                                                      Text(snapshot.data
                                                                          .documents[index]['dateTime']
                                                                          .toString(),textAlign: TextAlign.left),
                                                                      Spacer(),
                                                                      Icon(
                                                                        Icons.star_border,
                                                                        color: Colors.orange,
                                                                        size: 20.0,
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),

                                          ),
                                         ],
                                         ),
                                       )
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
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  void openBottomSheet(String itemTitle) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 500.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Dear,",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.blue[700],
                                    ),
                                    Icon(
                                      Icons.more_vert,
                                      color: Colors.blue[700],
                                    ),
                                  ],
                                ),
                                Text(itemTitle),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20.0,),
                    SizedBox(height: 10.0,),
                    Text("If yoy can participate this clinic response this. ", style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0
                    ),),
                    SizedBox(height: 10.0,),
                    Text("Thank you,", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                    ),),
                    SizedBox(height: 5.0,),

                    SizedBox(height: 15.0,),

                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text("Reply..", style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 18.0
                            ),),
                            Spacer(),
                            CircleAvatar(
                              backgroundColor: Colors.blue[600],
                              child: Icon(Icons.arrow_forward, color: Colors.white,),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}