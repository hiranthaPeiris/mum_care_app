import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:mun_care_app/screens/registration/ComDisplayData.dart';
import 'package:mun_care_app/screens/registration/PreDisplayData.dart';

class DairlyReportView extends StatefulWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateTime getDate;
  DairlyReportView({Key key, this.getDate}) : super(key: key);

  @override
  _DairlyReportViewState createState() => new _DairlyReportViewState();
}

class _DairlyReportViewState extends State<DairlyReportView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String searchPara = "";

  DateTime selected;
  String itemTitle = "Description";
  UserM _user;
  var getUser = new UserM.get();

  // var useri = 'IhiVRXSUfZPKoKpaNZgFtlPosj22';
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

  //var useri = new UserM.get().userCredential.user.uid;

  /* Future<List<String>> getMyAssigns(String u) async {
    List<String> mumIds = List();
    await widget._firestore
        .collection('HomeVisits')
        .where('midwifeID', isEqualTo: u)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.id);
        mumIds.add(element.id);
      });
    }).catchError((onError) => print(onError));
    return mumIds;
  }*/

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserM>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 5,
        title: Text('Dairly Report View'),
        //bottom:
      ),
      body: Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          //SizedBox(height: 8.0),
          Container(
            width: 20,
            height: 70,
            child: Row(
              children: <Widget>[
                Container(
                  width: 350,
                  height: 30,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(29.5),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      icon: SvgPicture.asset("assets/icons/search.svg"),
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchPara = val;
                      });
                    },
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  child: ClipOval(
                    child: Material(
                      color: Colors.blueAccent, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () {}, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.filter_list), // icon
                            // Text("Call"), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      color: Colors.blue,
                      child: TabBar(
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.white),
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Eligible Families"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Pregnancy Reviews"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Home Visits"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 400, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          Container(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: widget._firestore
                                        .collection('ComDatabase')
                                        // .where('_phmDropDownValue',
                                        //     isEqualTo: getUser
                                        //         .userCustomData['area01'])
                                        .where("_regDate",
                                            isEqualTo: widget.getDate.year
                                                    .toString() +
                                                "/" +
                                                widget.getDate.month
                                                    .toString() +
                                                "/" +
                                                widget.getDate.day.toString())
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      print(widget.getDate.year.toString() +
                                          "/" +
                                          widget.getDate.month.toString() +
                                          "/" +
                                          widget.getDate.day.toString());
                                      print(getUser.userCustomData['role']);
                                      if (!snapshot.hasData) {
                                        return Text('Loding...');
                                      }
                                      return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (context, index) {
                                            String documentId =
                                                snapshot.data.docs[index].id;
                                            return listItem(
                                                snapshot.data.docs[index]);
                                          });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: widget._firestore
                                        .collection('PreDatabase')
                                        .where('_phmDropDownValue',
                                            isEqualTo: getUser
                                                .userCustomData['area01'])
                                        .where("_regDate",
                                            isEqualTo: widget.getDate.year
                                                    .toString() +
                                                "/" +
                                                widget.getDate.month
                                                    .toString() +
                                                "/" +
                                                widget.getDate.day.toString())
                                        .snapshots(),
                                    //.collection('HomeVisits')
                                    //.snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('Loding...');
                                      }
                                      return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (context, index) {
                                            // String itemTitle = snapshot
                                            //  .data.docs[index]["_address"];
                                            String documentId =
                                                snapshot.data.docs[index].id;
                                            return listItem(snapshot.data.docs[index]);
                                          });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: widget._firestore
                                        .collection('HomeVisits')
                                        .where('midwifeID', isEqualTo: _user.uid)
                                        .where('year',
                                            isEqualTo: widget.getDate.year)
                                        .where('month',
                                            isEqualTo: widget.getDate.month)
                                        .where('day', isEqualTo: widget.getDate.day)
                                        .where('status', isEqualTo: "done")
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
                                            // String itemTitle = snapshot
                                            //  .data.docs[index]["_address"];
                                            return listItemHome(
                                                snapshot.data.docs[index]);
                                          });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]))
                  ])),
        ]),
      ),
    );
  }

  Widget listItem(DocumentSnapshot document) {
    String documentId = document.id;
    return new ListTile(
      leading: Icon(Icons.person_rounded),
      title: new Text(document['_wifeName']),
      subtitle: new Text(
        document['_email'],
        style: TextStyle(color: Colors.black45),
      ),
      trailing: Icon(Icons.more_vert_rounded),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ComGetIdDetails(documentId)),
        );
      },
    );
  }

  Widget listItemPreg(DocumentSnapshot document) {
    String documentId = document.id;
    return new ListTile(
      leading: Icon(Icons.person_rounded),
      title: new Text(document['_coName']),
      subtitle: new Text(
        document['_hcName'],
        style: TextStyle(color: Colors.black45),
      ),
      trailing: Icon(Icons.more_vert_rounded),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PreGetIdDetails(documentId)),
        );
      },
    );
  }

  Widget listItemHome(DocumentSnapshot document) {
    String documentId = document.id;
    return new ListTile(
      leading: Icon(Icons.person_rounded),
      title: new Text(document['description']),
      subtitle: new Text(
        document['dateTime'].toString(),
        style: TextStyle(color: Colors.black45),
      ),
      trailing: Icon(Icons.more_vert_rounded),
      onTap: () {
        openBottomSheet(document);
      },
    );
  }

 void openBottomSheet(DocumentSnapshot document) {
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
                                      "Home Visit Details,",
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
                      "Description: ${document['description']} ",
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                    Text(
                      "Home Visit Date: ${document['dateTime']} ",
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                    Text(
                      "remarks: ${document['remarks']} ",
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                     Text(
                      "status: ${document['status']} ",
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
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
                  ],
                ),
              ),
            ),
          );
        });
  }
}
