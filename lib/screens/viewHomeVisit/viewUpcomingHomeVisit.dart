import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mun_care_app/models/UserM.dart';

var uuid = Uuid();

class UpcomingHomeVisitFirebaseDemo extends StatefulWidget {
  final String appTitle = "UpComing Home Visits";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var useri = new UserM.get().userCredential.user.uid;

  @override
  _UpcomingHomeVisitFirebaseDemoState createState() =>
      _UpcomingHomeVisitFirebaseDemoState();
}

class _UpcomingHomeVisitFirebaseDemoState
    extends State<UpcomingHomeVisitFirebaseDemo> {
  bool isEditing = false;
  bool textFieldVisibility = false;
  TimeOfDay now = TimeOfDay.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserM> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebase);
  }

  UserM _userFromFirebase(User user) {
    //String uid = user.uid;
    return user != null ? UserM.setUID(uid: user.uid) : null;
  }

  var useri = new UserM.get().userCredential.user.uid;

  Widget build(BuildContext context) {
    return Scaffold(
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
                            "UpComing HomeVisits",
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
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Text('A HomeVisit Successfully Created');
                              Navigator.pushNamed(context, '/sechHomeVisits');
                            },
                          )
                          // Icon(Icons.add),

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
              stream: widget._firestore
                  .collection('Bookings')
                  .doc(useri)
                  .collection('HomeVisits')
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
                                    openBottomSheet(itemTitle);
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
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "If you can participate this clinic response this. ",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Thank you,",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            // hintText: 'Reply'
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              //onPressed: (),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          alignment: Alignment.bottomLeft,
                          child: RaisedButton(
                            shape: StadiumBorder(),
                            textColor: Colors.white,
                            color: Colors.lightBlue,
                            child: Text(
                              'Deny',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          height: 50.0,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          alignment: Alignment.bottomRight,
                          child: RaisedButton(
                            shape: StadiumBorder(),
                            textColor: Colors.white,
                            color: Colors.lightBlue,
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            onPressed: () {
                              Text('A HomeVisit Successfully Created');
                              Navigator.pushNamed(context, '/notification');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
