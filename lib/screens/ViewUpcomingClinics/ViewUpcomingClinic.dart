import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/ViewUpcomingClinics/ViewClinic.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleClinic.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:mun_care_app/services/ClinicService.dart';

class ViewUpcomingClinic extends StatefulWidget {
  ViewUpcomingClinic({Key key, this.title}) : super(key: key);

  final String title;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();
  @override
  _ViewUpcomingClinicState createState() => _ViewUpcomingClinicState();
}

class _ViewUpcomingClinicState extends State<ViewUpcomingClinic> {
  var user = new UserM.get();
  final ClinicService _clinicService = ClinicService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  Widget build(BuildContext context) {
    print(user.userCustomData);
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
          Expanded(
            flex: 1,
            child: StreamBuilder<QuerySnapshot>(
              stream: (user.userCustomData['role'] == 'midwife')
                  ? widget._firestore
                      .collection('Bookings')
                      .doc(user.uid)
                      .collection('Clinics')
                      .snapshots()
                  : widget._firestore
                      .collection('Bookings')
                      .doc(user.uid)
                      .collection('Clinics')
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
                      String itemTitle =
                          snapshot.data.docs[index]["description"];
                      return Column(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    //openBottomSheet(itemTitle);
                                    if (user.userCustomData['role'] ==
                                        "midwife") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ViewClinic(
                                                  documentSnapshot: snapshot
                                                      .data.docs[index])));

                                      // forMidwife(snapshot.data.docs[index],
                                      //     _scaffoldKey);
                                    } else if (user.userCustomData['role'] ==
                                        "user") {
                                      forUser(snapshot.data.docs[index],
                                          _scaffoldKey);
                                    }
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(11.0),
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
    DocumentReference userClinicRef = documentSnapshot.reference;
    String midID = user.userCustomData['midwifeID'];

    String itemTitle = documentSnapshot["description"];
    String itemStatus = documentSnapshot["status"];
    String itemDate = documentSnapshot['dateTime'].toString();
    String itemConfirmation =
        (documentSnapshot['confirmation'] == 'CLINICCONFM.accept')
            ? "Accepted"
            : "Denied";

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
                                      "Dear your clinic,",
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
                                Text("Description: $itemTitle",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0)),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("Clinic Status: $itemStatus",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0)),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("Clinic Date: $itemDate",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0)),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("Your Confirmation: $itemConfirmation",
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
                              "Accept",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            onPressed: () {
                              //Put your code here which you want to execute on Yes button click.
                              _clinicService.changeConfirmation(
                                  user.uid, CLINICCONFM.accept, userClinicRef);
                              //Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "Deny",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            onPressed: () {
                              //Put your code here which you want to execute on No button click.
                              _clinicService.changeConfirmation(
                                  user.uid, CLINICCONFM.deny, userClinicRef);
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
        });
  }

  void forMidwife(
      QueryDocumentSnapshot documentSnapshot, GlobalKey<ScaffoldState> scaf) {
    String midWifeClinicID = documentSnapshot.id; //Current document
    String midID = user.uid;
    String itemTitle = documentSnapshot["description"];
    String itemStatus = documentSnapshot["status"];
    String itemDate = documentSnapshot['dateTime'].toString();
    int itemCount = documentSnapshot['count'];
    List<dynamic> usersRefList = documentSnapshot['users'];
    List<DocumentReference> usersClinicRefList =
        documentSnapshot['userClinicRef'].cast<DocumentReference>();
    //print(usersRefList);
    //print(documentSnapshot['userClinicRef']);

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
                          color: Colors.lightBlue,
                        ),
                        child: Container(
                          child: Text("CLINIC",
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
                                            Text(
                                                "Accepted number of users : $itemCount",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0)),
                                          ]),
                                          SizedBox(
                                            height: 20.0,
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
                              /*Expanded(
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: widget._firestore
                                          .collection('users')
                                          .where('midwifeID', isEqualTo: midID)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return new Text("has error");
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return new Text("Loading");
                                        }
                                        return new ListView(
                                          children: snapshot.data.docs
                                              .map((DocumentSnapshot document) {
                                            return new ListTile(
                                              title: new Text(document['name']),
                                              trailing:
                                                  Icon(Icons.more_vert_rounded),
                                              leading:
                                                  Icon(Icons.person_rounded),
                                            );
                                          }).toList(),
                                        );
                                      })),*/
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
                                    SizedBox(
                                      width: 10.0,
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
                                                    ScheduleClinic(
                                                        rescheduleFLAG: true,
                                                        docID: midWifeClinicID,
                                                        userClinicRefList:
                                                            usersClinicRefList)));
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    RaisedButton(
                                      color: kBackground,
                                      child: Text(
                                        "Clinic Done",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        //Put your code here which you want to execute on Yes button click.
                                        // _clinicService.updateStatus(
                                        //     midID,
                                        //     midWifeClinicID,
                                        //     CLINICSTATE.done,
                                        //     usersClinicRefList,re);
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
