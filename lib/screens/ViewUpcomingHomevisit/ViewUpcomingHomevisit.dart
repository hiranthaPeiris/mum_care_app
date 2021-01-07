import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleHomeVisits.dart';
import 'package:mun_care_app/services/HomeVisitService.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
  UserM _user;
  HomeVisitService _homeVisitService = HomeVisitService();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    _user = Provider.of<UserM>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.pending),
                child: Text("Active"),
              ),
              Tab(
                icon: Icon(Icons.done),
                child: Text("Done"),
              ),
            ],
          ),
          title: Text('Upcoming Home Visits'),
        ),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: (_user.userCustomData['role'] == 'user')
                          ? widget._firestore
                              .collection('HomeVisits')
                              .where('userID', isEqualTo: _user.uid)
                              .where("status", isEqualTo: "active")
                              .snapshots()
                          : widget._firestore
                              .collection('HomeVisits')
                              .where('midwifeID', isEqualTo: _user.uid)
                              .where("status", isEqualTo: "active")
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Snapshot Error');
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                      size: 60,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text('Select a lot'),
                                    )
                                  ],
                                ),
                              );
                              break;
                            case ConnectionState.waiting:
                              return Center(
                                heightFactor: 5.0,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      child: const CircularProgressIndicator(),
                                      width: 50,
                                      height: 50,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text('Awaiting Data...'),
                                    )
                                  ],
                                ),
                              );
                            case ConnectionState.active:
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100.0,
                                            child: InkWell(
                                                onTap: () {
                                                  print(_user
                                                      .userCustomData['role']);
                                                  if (_user.userCustomData[
                                                          'role'] ==
                                                      "midwife") {
                                                    //forUser(itemTitle,itemStatus,itemDate);
                                                    forMidwife(snapshot
                                                        .data.docs[index]);
                                                    print("midwife");
                                                  } else if (_user
                                                              .userCustomData[
                                                          'role'] ==
                                                      "user") {
                                                    print("user");
                                                    forUser(
                                                        snapshot
                                                            .data.docs[index],
                                                        _scaffoldKey);
                                                  }
                                                },
                                                child: _buildListItem(
                                                    snapshot, index)),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            default:
                              print(snapshot.connectionState.toString());
                              return Text("No data");
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: (_user.userCustomData['role'] == 'user')
                          ? widget._firestore
                              .collection('HomeVisits')
                              .where('userID', isEqualTo: _user.uid)
                              .where("status", isEqualTo: "done")
                              .snapshots()
                          : widget._firestore
                              .collection('HomeVisits')
                              .where('midwifeID', isEqualTo: _user.uid)
                              .where("status", isEqualTo: "done")
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Snapshot Error');
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                      size: 60,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text('Select a lot'),
                                    )
                                  ],
                                ),
                              );
                              break;
                            case ConnectionState.waiting:
                              return Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      child: const CircularProgressIndicator(),
                                      width: 50,
                                      height: 50,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text('Awaiting Data...'),
                                    )
                                  ],
                                ),
                              );
                            case ConnectionState.active:
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100.0,
                                            child: InkWell(
                                                onTap: () {
                                                  print(_user
                                                      .userCustomData['role']);
                                                  if (_user.userCustomData[
                                                          'role'] ==
                                                      "midwife") {
                                                    //forUser(itemTitle,itemStatus,itemDate);
                                                    forMidwife(snapshot
                                                        .data.docs[index]);
                                                    print("midwife");
                                                  } else if (_user
                                                              .userCustomData[
                                                          'role'] ==
                                                      "user") {
                                                    print("user");
                                                    forUser(
                                                        snapshot
                                                            .data.docs[index],
                                                        _scaffoldKey);
                                                  }
                                                },
                                                child: _buildListItem(
                                                    snapshot, index)),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            default:
                              print(snapshot.connectionState.toString());
                              return Text("No data");
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void forUser(
      QueryDocumentSnapshot documentSnapshot, GlobalKey<ScaffoldState> scaf) {
    String id = documentSnapshot.id;
    //String uid = user.userCredential.user.uid;
    String midID = _user.userCustomData['midwifeID'];
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
                                          Text("Title: $itemTitle",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0)),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text("Visit Date: $itemDate",
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Mother's Details",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0.0, 0.0, 0.0, 5.0),
                                                child: Text(
                                                    "Name of Mother: $name",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0.0, 0.0, 0.0, 5.0),
                                                child: Text(
                                                    "Mother Status : ${(compFam == 'true' && pregMom == 'true') ? "Pregnent Mother" : "Competency Family"}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0)),
                                              ),
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
                                                      midwifeId: _user.uid,
                                                    )));
                                      },
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    RaisedButton(
                                      color: kBackground,
                                      child: Text(
                                        "Open in Maps",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                      onPressed: () {
                                        //Put your code here which you want to execute on Yes button click.
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

Widget _buildListItem(AsyncSnapshot<QuerySnapshot> asyncSnapshot, int index) {
  return Stack(
    alignment: Alignment.center,
    overflow: Overflow.visible,
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(14.0),
        height: 70.0,
        width: 300.0,
        decoration: BoxDecoration(
            color: Colors.blue[100], borderRadius: BorderRadius.circular(15.0)),
      ),
      Positioned(
        bottom: 20.0,
        child: Container(
          height: 50.0,
          width: 330.0,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15.0)),
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
                  height: 60,
                  width: 70,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                        asyncSnapshot.data.docs[index]['dateTime'].toString(),
                        textAlign: TextAlign.center),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Spacer(),
                            Text(
                              "8:16 AM",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12.0),
                            ),
                          ],
                        ),
                        Text(asyncSnapshot.data.docs[index]['description'],
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left),
                        Text(asyncSnapshot.data.docs[index]['status'],
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left),
                        Row(
                          children: <Widget>[
                            Text(
                                asyncSnapshot.data.docs[index]['dateTime']
                                    .toString(),
                                textAlign: TextAlign.left),
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
  );
}
