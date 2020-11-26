import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleHomeVisits.dart';
import 'package:mun_care_app/services/HomeVisitService.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

var uuid = Uuid();

//enum HOMEVISITCONFM {accept,deny}
// ignore: must_be_immutable
class ViewUpcomingHomevisit extends StatefulWidget {
  ViewUpcomingHomevisit({Key key, this.title}) : super(key: key);

  final String title;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _ViewUpcomingHomevisitState createState() => _ViewUpcomingHomevisitState();
}

class _ViewUpcomingHomevisitState extends State<ViewUpcomingHomevisit> {
  final UserM user = new UserM.get();
  HomeVisitService _homeVisitService = HomeVisitService();
  //var role = new UserM();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
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
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "UpComing Homevisits",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
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
          Expanded(
            flex: 1,
            child: StreamBuilder<QuerySnapshot>(
              stream: (user.userCustomData['role'] == 'user')
                  ? widget._firestore
                      .collection('HomeVisits')
                      .where('userID', isEqualTo: user.userCredential.user.uid)
                      .snapshots()
                  : widget._firestore
                      .collection('HomeVisits')
                      .where('midwifeID',
                          isEqualTo: user.userCredential.user.uid)
                      .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loding...');
                }
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    if (user.userCustomData['role'] ==
                                        "midwife") {
                                      //forUser(itemTitle,itemStatus,itemDate);
                                      forMidwife(snapshot.data.docs[index]);
                                      print("midwife");
                                    } else if (user.userCustomData['role'] ==
                                        "user") {
                                      print("user");
                                      forUser(snapshot.data.docs[index],
                                          _scaffoldKey);
                                    }
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(14.0),
                                        height: 70.0,
                                        width: 300.0,
                                        decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                      Positioned(
                                        bottom: 20.0,
                                        child: Container(
                                          height: 50.0,
                                          width: 330.0,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 25.0,
                                        child: Container(
                                          // height: 80.0,
                                          width: 350.0,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 60,
                                                  width: 70,
                                                  margin:
                                                      const EdgeInsets.all(2.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      border: Border.all(
                                                        color: Colors.blueGrey,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                        snapshot
                                                            .data
                                                            .docs[index]
                                                                ['dateTime']
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Spacer(),
                                                            Text(
                                                              "8:16 AM",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      12.0),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['description'],
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                            textAlign:
                                                                TextAlign.left),
                                                        Text(
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['status'],
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                            textAlign:
                                                                TextAlign.left),
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                                snapshot
                                                                    .data
                                                                    .docs[index]
                                                                        [
                                                                        'dateTime']
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left),
                                                            Spacer(),
                                                            Icon(
                                                              Icons.star_border,
                                                              color:
                                                                  Colors.orange,
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
    );
  }

  void forUser(
      QueryDocumentSnapshot documentSnapshot, GlobalKey<ScaffoldState> scaf) {
    String id = documentSnapshot.id;
    //String uid = user.userCredential.user.uid;
    String midID = user.userCustomData['midwifeID'];
    //String midDocID = documentSnapshot['midDocID'];

    String itemTitle = documentSnapshot["description"];
    String itemStatus = documentSnapshot["status"];
    String itemDate = documentSnapshot['dateTime'].toString();
    String itemConfirmation = documentSnapshot['confirmation'];
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModelState) {
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
                            Container(),
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
                                          "Your Home Visit,",
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
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Text(itemTitle,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0)),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text("Visit Status: $itemStatus",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0)),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                        "Visit Confirmation: $itemConfirmation",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0)),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(itemDate,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Thank you,",
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              FlatButton(
                                child: Text(
                                  "Deny",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                onPressed: () {
                                  //Put your code here which you want to execute on Yes button click.
                                  setState(() {
                                    _homeVisitService.changeConfirmation(
                                        HOMEVISITCONFM.deny, id, midID);
                                  });
                                  final snackBar = SnackBar(
                                    content: Text('Successfully Updated'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                    duration: Duration(seconds: 2),
                                  );

                                  // Find the Scaffold in the widget tree and use
                                  // it to show a SnackBar.
                                  scaf.currentState.showSnackBar(snackBar);
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                onPressed: () {
                                  //Put your code here which you want to execute on No button click.
                                  setState(() {
                                    _homeVisitService.changeConfirmation(
                                        HOMEVISITCONFM.accept, id, midID);
                                  });
                                  final snackBar = SnackBar(
                                    content: Text('Successfully Updated'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                    duration: Duration(seconds: 2),
                                  );

                                  // Find the Scaffold in the widget tree and use
                                  // it to show a SnackBar.
                                  scaf.currentState.showSnackBar(snackBar);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              ;
            },
          );
        });
  }

  void forMidwife(QueryDocumentSnapshot documentSnapshot) async {
    DocumentReference userRef = documentSnapshot['userDocRef'];
    DocumentSnapshot userData =
        await userRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot;
      } else {
        return null;
      }
    });
    String itemTitle = documentSnapshot["description"];
    String itemStatus = documentSnapshot["status"];
    String itemDate = documentSnapshot['dateTime'].toString();
    String itemConfirmation = documentSnapshot['confirmation'];

    String name = userData['name'];
    String compFam = userData['competencyFam'].toString();
    String pregMom = userData['PregnanctFam'].toString();
    showModalBottomSheet(
        context: context,
        // backgroundColor: Colors.blue,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 8,
                        width: MediaQuery.of(context).copyWith().size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: kBackground,
                        ),
                        child: Container(
                          child: Text("HOME VISIT",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0)),
                          padding: const EdgeInsets.all(20.0),
                        ),
                      ),
                      Container(
                        //height: 800.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(itemTitle,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0)),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(itemStatus,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0)),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(itemDate,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0)),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Row(children: <Widget>[
                                            Text("User Confirmation : ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0)),
                                            Text(itemConfirmation,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0)),
                                          ]),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Mother Details",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text("Name: $name",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0)),
                                              Text(
                                                  "Competency Familty : $compFam",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0)),
                                              Text("Pregnant Mother: $pregMom",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "Close",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        //Put your code here which you want to execute on No button click.
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    RaisedButton(
                                      color: kBackground,
                                      child: Text(
                                        "Reschdule",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        //Put your code here which you want to execute on Yes button click.
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ScheduleHomeVisits(
                                                      document: userData,
                                                      midwifeId: user.uid,
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
