import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/screens/registration/ComDisplayData.dart';
import 'package:mun_care_app/screens/registration/PreDisplayData.dart';

class MotherListAndCount extends StatefulWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final DateTime getDate;
  //MotherListAndCount({Key key, this.getDate}) : super(key: key);

  @override
  _MotherListAndCountState createState() => new _MotherListAndCountState();
}

class _MotherListAndCountState extends State<MotherListAndCount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String searchPara = "";

  var getUser = new UserM.get();

  var useri = 'IhiVRXSUfZPKoKpaNZgFtlPosj22';

  @override
  Widget build(BuildContext context) {
    Future<void> competencyDelete(String id) async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await FirebaseFirestore.instance
          .collection('ComDatabase')
          .doc(id)
          .update({
            '_delete': true,
          })
          .then((value) => print("Competency Family Deleted"))
          .catchError((err) => print(err));
    }

    Future<void> pregnencyDelete(String id) async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await FirebaseFirestore.instance
          .collection('PreDatabase')
          .doc(id)
          .update({
            '_delete': true,
          })
          .then((value) => print("Pregnency Family Deleted"))
          .catchError((err) => print(err));
    }

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
                  width: 50,
                  height: 50,
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
                              child: Text("Competency List"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Pregnancy List"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Remove List"),
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
                            child: Expanded(
                              flex: 1,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: widget._firestore
                                    .collection('ComDatabase')
                                    .where('_delete', isEqualTo: false)
                                    .where('_phmDropDownValue',
                                        isEqualTo:
                                            getUser.userCustomData['area01'])
                                    .snapshots(),
                                builder: (context, snapshot) {
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
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 19, horizontal: 19),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: SingleChildScrollView(
                                                child: Column(
                                              children: <Widget>[
                                                Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons
                                                            .arrow_drop_down_circle),
                                                        title: snapshot.data.docs[
                                                                        index][
                                                                    '_wifeName'] !=
                                                                ""
                                                            ? Text(
                                                                "${snapshot.data.docs[index]['_wifeName']} Details")
                                                            : Text(
                                                                'No Details'),
                                                        subtitle: Text(
                                                          "${snapshot.data.docs[index]['_nic']}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                      ),
                                                      ButtonBar(
                                                        alignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          FlatButton(
                                                            textColor:
                                                                const Color(
                                                                    0xFF6200EE),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        ComGetIdDetails(
                                                                            documentId)),
                                                              );
                                                            },
                                                            child: const Text(
                                                                'Delete'),
                                                          ),
                                                          FlatButton(
                                                            textColor:
                                                                const Color(
                                                                    0xFF6200EE),
                                                            onPressed: () {
                                                              Expanded(
                                                                  child: Center(
                                                                child:
                                                                    AlertDialog(
                                                                  title: Text(
                                                                      "Competency Registration Succesfully"),
                                                                  content: Text(
                                                                      "Congratulation"),
                                                                  actions: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        FlatButton(
                                                                            child:
                                                                                Text("Yes"),
                                                                            onPressed: () {
                                                                              competencyDelete( documentId);
                                                                            }),
                                                                        FlatButton(
                                                                            child:
                                                                                Text("No"),
                                                                            onPressed: () {
                                                                              setState(() {
                                                                                
                                                                              });
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ));
                                                              
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .delete),
                                                                const Text(
                                                                    'Delete'),
                                                              ],
                                                            ),
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
                                      });
                                },
                              ),
                            ),
                          ),
                          Container(
                            child: Expanded(
                              flex: 1,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: widget._firestore
                                    .collection('PreDatabase')
                                    .where('_delete', isEqualTo: false)
                                    .where('_phmDropDownValue',
                                        isEqualTo:
                                            getUser.userCustomData['area01'])
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
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 19, horizontal: 19),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: SingleChildScrollView(
                                                child: Column(
                                              children: <Widget>[
                                                Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons
                                                            .arrow_drop_down_circle),
                                                        title: snapshot.data.docs[
                                                                        index][
                                                                    '_wifeName'] !=
                                                                ""
                                                            ? Text(
                                                                "${snapshot.data.docs[index]['_wifeName']} Details")
                                                            : Text(
                                                                'No Details'),
                                                        subtitle: Text(
                                                          "${snapshot.data.docs[index]['_nic']}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                      ),
                                                      ButtonBar(
                                                        alignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          FlatButton(
                                                            textColor:
                                                                const Color(
                                                                    0xFF6200EE),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        ComGetIdDetails(
                                                                            documentId)),
                                                              );
                                                            },
                                                            child: const Text(
                                                                'Delete'),
                                                          ),
                                                          FlatButton(
                                                            textColor:
                                                                const Color(
                                                                    0xFF6200EE),
                                                            onPressed: () {
                                                              Expanded(
                                                                  child: Center(
                                                                child:
                                                                    AlertDialog(
                                                                  title: Text(
                                                                      "Competency Registration Succesfully"),
                                                                  content: Text(
                                                                      "Congratulation"),
                                                                  actions: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        FlatButton(
                                                                            child:
                                                                                Text("Yes"),
                                                                            onPressed: () {
                                                                              pregnencyDelete(documentId);
                                                                            }),
                                                                        FlatButton(
                                                                            child:
                                                                                Text("No"),
                                                                            onPressed: () {
                                                                              setState(() {
                                                                                
                                                                              });
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .delete),
                                                                const Text(
                                                                    'Delete'),
                                                              ],
                                                            ),
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
                                      });
                                },
                              ),
                            ),
                          ),
                          Container(
                            child: Expanded(
                              flex: 1,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: widget._firestore
                                    .collection('PreDatabase')
                                    .where('_delete', isEqualTo: true)
                                    .where('_phmDropDownValue',
                                        isEqualTo:
                                            getUser.userCustomData['area01'])
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
                                        String documentId =
                                            snapshot.data.docs[index].id;
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 19, horizontal: 19),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: SingleChildScrollView(
                                                child: Column(
                                              children: <Widget>[
                                                Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons
                                                            .arrow_drop_down_circle),
                                                        title: snapshot.data.docs[
                                                                        index][
                                                                    '_wifeName'] !=
                                                                ""
                                                            ? Text(
                                                                "${snapshot.data.docs[index]['_wifeName']} Details")
                                                            : Text(
                                                                'No Details'),
                                                        subtitle: Text(
                                                          "${snapshot.data.docs[index]['_nic']}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                      ),
                                                      ButtonBar(
                                                        alignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          FlatButton(
                                                            textColor:
                                                                const Color(
                                                                    0xFF6200EE),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        ComGetIdDetails(
                                                                            documentId)),
                                                              );
                                                            },
                                                            child: const Text(
                                                                'Competency Details'),
                                                          ),
                                                          FlatButton(
                                                            textColor:
                                                                const Color(
                                                                    0xFF6200EE),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        PreGetIdDetails(
                                                                            documentId)),
                                                              );
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .delete),
                                                                const Text(
                                                                    'Pregnancy Details'),
                                                              ],
                                                            ),
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
                                      });
                                },
                              ),
                            ),
                          ),
                        ]))
                  ])),
        ]),
      ),
    );
  }
}
