import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/LeavingAreaReport/ViewItemLeave.dart';
import 'package:provider/provider.dart';

class ViewAreaLeave extends StatefulWidget {
  ViewAreaLeave({Key key}) : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _ViewAreaLeaveState createState() => _ViewAreaLeaveState();
}

class _ViewAreaLeaveState extends State<ViewAreaLeave> {
  UserM _user;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserM>(context);

    return Scaffold(
        body: Builder(
      builder: (context) => SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).copyWith().size.height / 5,
          width: MediaQuery.of(context).copyWith().size.width,
          color: Colors.lightBlue,
          child: Container(
            child: Text(
              'Leaving Residensial Area Reports',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.2,
                MediaQuery.of(context).size.height * 0.06,
                MediaQuery.of(context).size.width * 0.2,
                MediaQuery.of(context).size.height * 0.04),
          ),
        ),
        DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  child: TabBar(tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Pending",
                          style: TextStyle(color: kActiveIconColor),
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Accepted",
                            style: TextStyle(color: kActiveIconColor)),
                      ),
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
                  height:
                      MediaQuery.of(context).copyWith().size.height * (4 / 5),
                  width: MediaQuery.of(context).copyWith().size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: widget._firestore
                                  .collection('informLeaving')
                                  .where('_status', isEqualTo: "pending")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    return _buildListTile(document);
                                  }).toList(),
                                );
                              })),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
                  height:
                      MediaQuery.of(context).copyWith().size.height * (4 / 5),
                  width: MediaQuery.of(context).copyWith().size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: widget._firestore
                                  .collection('informLeaving')
                                  .where('_status', isEqualTo: "accepted")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    return _buildListTile(document);
                                  }).toList(),
                                );
                              })),
                    ],
                  ),
                )
              ],
            ))
      ])),
    ));
  }

  Widget _buildListTile(DocumentSnapshot document) {
    String userID = document.id;
    String name = document['_Name'];
    String desc = document['_NICnumber'];
    String vaccine = document['_date'];

    return new ListTile(
      title: new Text(name),
      subtitle: Text(
        desc,
        style: TextStyle(color: Colors.black54),
      ),
      trailing: Text(
        "date",
      ),
      leading: Icon(Icons.person_rounded),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewItemLeave(
                      documentSnapshot: document,
                    )));
      },
    );
  }
}
