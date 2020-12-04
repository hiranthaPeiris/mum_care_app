import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:flutter_svg/flutter_svg.dart';
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


  var getUser=new UserM.get();

  var useri = 'IhiVRXSUfZPKoKpaNZgFtlPosj22';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 5,
        title: Text('Dairly Report View'),
        //bottom:
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                                  child: Text("Com Fam"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Pregnancy Fam"),
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
                                child: Expanded(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: widget._firestore
                                        .collection('ComDatabase')
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
                                            return Column(
                                              children: <Widget>[
                                                SingleChildScrollView(
                                                  child: Column(
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => ComGetIdDetails(documentId)),
                                                          );
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(11.0),
                                                              height: 70.0,
                                                              width: 300.0,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .blue),
                                                                  color: Colors
                                                                          .blue[
                                                                      100],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0)),
                                                            ),
                                                            Positioned(
                                                              bottom: 20.0,
                                                              child: Container(
                                                                height: 50.0,
                                                                width: 330.0,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blue,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0)),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              // bottom: 25.0,
                                                              child: Container(
                                                                // height: 80.0,
                                                                width: 350.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .blue[50],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                              vertical: 2,
                                                                              horizontal: 1),
                                                                          child: Container(
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(color: Colors.black),
                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                              ),
                                                                              child: SingleChildScrollView(
                                                                                child: ListTile(
                                                                                  title: Column(
                                                                                    children: <Widget>[
                                                                                      Row(
                                                                                        children: <Widget>[
                                                                                          Icon(
                                                                                            Icons.message,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                          Text(snapshot.data.docs[index]['_wifeName'], style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                                                                                        ],
                                                                                      ),
                                                                                      Divider(),
                                                                                      Row(
                                                                                        children: <Widget>[
                                                                                          /*Icon(
                                                                                            Icons.person,
                                                                                            color: Colors.purple,
                                                                                          ),*/
                                                                                          //Spacer(),
                                                                                          Text(snapshot.data.docs[index]['_email'].toString(), textAlign: TextAlign.left),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ),
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
                              ),
                              Container(
                                child: Expanded(
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
                                            return Column(
                                              children: <Widget>[
                                                SingleChildScrollView(
                                                  child: Column(
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => PreGetIdDetails(documentId)),
                                                          );
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          // overflow:
                                                          //  Overflow.visible,
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(11.0),
                                                              height: 70.0,
                                                              width: 300.0,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .blue),
                                                                  color: Colors
                                                                          .blue[
                                                                      100],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0)),
                                                            ),
                                                            Positioned(
                                                              bottom: 20.0,
                                                              child: Container(
                                                                height: 50.0,
                                                                width: 330.0,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blue,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0)),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              // bottom: 25.0,
                                                              child: Container(
                                                                // height: 80.0,
                                                                width: 350.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .blue[50],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                              vertical: 2,
                                                                              horizontal: 1),
                                                                          child: Container(
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(color: Colors.black),
                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                              ),
                                                                              child: SingleChildScrollView(
                                                                                child: ListTile(
                                                                                  title: Column(
                                                                                    children: <Widget>[
                                                                                      Row(
                                                                                        children: <Widget>[
                                                                                          Icon(
                                                                                            Icons.message,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                          Text(snapshot.data.docs[index]['_coName'], style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                                                                                        ],
                                                                                      ),
                                                                                      Divider(),
                                                                                      Row(
                                                                                        children: <Widget>[
                                                                                          /*Icon(
                                                                                            Icons.person,
                                                                                            color: Colors.purple,
                                                                                          ),*/
                                                                                          //Spacer(),
                                                                                          Text(snapshot.data.docs[index]['_hcName'].toString(), textAlign: TextAlign.left),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ),
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
                              ),
                              Container(
                                child: Expanded(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: widget._firestore
                                        .collection('Bookings')
                                        .doc(useri)
                                        .collection('HomeVisits')
                                        .snapshots(),

                                    /*stream: widget._firestore
                                        .collection('HomeVisits')
                                        .where("regDate",
                                            isEqualTo: widget.getDate.year
                                                    .toString() +
                                                "/" +
                                                widget.getDate.month
                                                    .toString() +
                                                "/" +
                                                widget.getDate.day.toString())
                                        .snapshots(),*/
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
                                            return Column(
                                              children: <Widget>[
                                                SingleChildScrollView(
                                                  child: Column(
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          openBottomSheet(
                                                              itemTitle);
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          // overflow:
                                                          //  Overflow.visible,
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(11.0),
                                                              height: 70.0,
                                                              width: 300.0,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .blue),
                                                                  color: Colors
                                                                          .blue[
                                                                      100],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0)),
                                                            ),
                                                            Positioned(
                                                              bottom: 20.0,
                                                              child: Container(
                                                                height: 50.0,
                                                                width: 330.0,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blue,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0)),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              // bottom: 25.0,
                                                              child: Container(
                                                                // height: 80.0,
                                                                width: 350.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .blue[50],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                              vertical: 2,
                                                                              horizontal: 1),
                                                                          child: Container(
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(color: Colors.black),
                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                              ),
                                                                              child: SingleChildScrollView(
                                                                                child: ListTile(
                                                                                  title: Column(
                                                                                    children: <Widget>[
                                                                                      Row(
                                                                                        children: <Widget>[
                                                                                          Icon(
                                                                                            Icons.message,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                          Text(snapshot.data.docs[index]['description'], style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                                                                                        ],
                                                                                      ),
                                                                                      Divider(),
                                                                                      Row(
                                                                                        children: <Widget>[
                                                                                          /*Icon(
                                                                                            Icons.person,
                                                                                            color: Colors.purple,
                                                                                          ),*/
                                                                                          //Spacer(),
                                                                                          Text(snapshot.data.docs[index]['dateTime'].toString(), textAlign: TextAlign.left),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ),
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
                              ),
                            ]))
                      ])),
            ]),
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
                      "Description of the  Mothers. ",
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
                  ],
                ),
              ),
            ),
          );
        });
  }
}
