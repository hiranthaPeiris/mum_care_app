import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/models/UserReg.dart';
import 'package:mun_care_app/screens/Profile/Profile.dart';
import 'package:mun_care_app/screens/registration/PreDisplayData.dart';
import 'package:provider/provider.dart';

import '../registration/ComDisplayData.dart';

class MotherList extends StatefulWidget {
  @override
  _MotherListState createState() => _MotherListState();
}

class _MotherListState extends State<MotherList> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  UserM _user;
  String searchPara = "";
  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserM>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.pending),
                child: Text("Pending"),
              ),
              Tab(
                icon: Icon(Icons.done),
                child: Text("Accepted"),
              ),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          title: Text('Review Competency Family'),
        ),
        body: TabBarView(
          children: [
            Container(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (searchPara == null || searchPara == '')
                        ? collection
                            .where('midwifeID', isEqualTo: _user.user.uid)
                            .where('compApp', isEqualTo: true)
                            .snapshots()
                        : collection
                            .where('nameSearch', arrayContains: searchPara)
                            .where('midwifeID', isEqualTo: _user.uid)
                            .where('compApp', isEqualTo: true)
                            .snapshots(includeMetadataChanges: true),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      if (snapshot.connectionState == ConnectionState.none) {
                        return Text("No data present");
                      }
                      return new ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                        //refe from below
                        return listItem(document);
                      }).toList());
                    },
                  ),
                )
              ],
            )),
            Container(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (searchPara == null || searchPara == '')
                        ? collection
                            .where('midwifeID', isEqualTo: _user.user.uid)
                            .where('competencyFam', isEqualTo: true)
                            .snapshots()
                        : collection
                            .where('nameSearch', arrayContains: searchPara)
                            .where('midwifeID', isEqualTo: _user.uid)
                            .where('competencyFam', isEqualTo: true)
                            .snapshots(includeMetadataChanges: true),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      if (snapshot.connectionState == ConnectionState.none) {
                        return Text("No data present");
                      }
                      return new ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                        //refe from below
                        return listItem(document);
                      }).toList());
                    },
                  ),
                )
              ],
            )),
            Icon(Icons.directions_bike),
          ],
        ),
        // body: getState(context),
      ),
    );
  }

  Widget listItem(DocumentSnapshot document) {
    return new ListTile(
      leading: Icon(Icons.person_rounded),
      title: new Text(document['name']),
      subtitle: new Text(
        "state",
        style: TextStyle(color: Colors.black45),
      ),
      trailing: Icon(Icons.more_vert_rounded),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => Profile(
                      documentSnapshot: document,review: true,reviewType: "comp",
                    )));
      },
    );
  }

//   Widget getState(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection("users")
//           .doc(_auth.currentUser.uid)
//           .snapshots(),
//       builder: (context, snapshot) {
//         var value = snapshot.data;
//         String area = value['area01'].toString();
//         print(area);
//         if (snapshot.hasData) {
//           return buildBody01(context, area);
//         }
//       },
//     );
//   }

//   Widget buildBody01(BuildContext context, String abc) {
//     return StreamBuilder(
//         stream: getData01(abc),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text("Error ${snapshot.error}");
//           }
//           if (snapshot.hasData) {
//             print("Document -> ${snapshot.data.documents.length}");
//             return buildList01(context, snapshot.data.documents);
//           }
//         });
//   }

//   Widget buildList01(BuildContext context, List<DocumentSnapshot> snapshot) {
//     return ListView(
//       children: snapshot.map((data) => listItemBuild01(context, data)).toList(),
//     );
//   }

//   Widget listItemBuild01(BuildContext context, DocumentSnapshot data) {
//     final comRegBD = ComRegDB.fromSnapshot(data);
//     return Padding(
//       //key: ValueKey(comStep1.husbandName),
//       padding: EdgeInsets.symmetric(vertical: 19, horizontal: 19),
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.blue),
//             borderRadius: BorderRadius.circular(5)),
//         child: SingleChildScrollView(
//             child: Column(
//           children: <Widget>[
//             Card(
//               clipBehavior: Clip.antiAlias,
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.arrow_drop_down_circle),
//                     title: data['_wifeName'] != ""
//                         ? Text("${data['_wifeName']} Details")
//                         : Text('No Details'),
//                     subtitle: Text(
//                       "${data['_nic']}",
//                       style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                     ),
//                   ),
//                   ButtonBar(
//                     alignment: MainAxisAlignment.start,
//                     children: [
//                       FlatButton(
//                         textColor: const Color(0xFF6200EE),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ComGetIdDetails(
//                                     comRegBD.documentReference.id)),
//                           );
//                         },
//                         child: const Text('Competency'),
//                       ),
//                       FlatButton(
//                         textColor: const Color(0xFF6200EE),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => PreGetIdDetails(
//                                     comRegBD.documentReference.id)),
//                           );
//                         },
//                         child: const Text('Pregnancy'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         )),
//       ),
//     );
//   }

//   getData01(String area) {
//     return FirebaseFirestore.instance
//         .collection("ComDatabase")
//         .where('_phmDropDownValue', isEqualTo: area)
//         .snapshots();
//   }
}
