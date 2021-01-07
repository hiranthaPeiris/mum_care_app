import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/Profile/Profile.dart';
import 'package:provider/provider.dart';

class PregReview extends StatefulWidget {
  PregReview({Key key}) : super(key: key);

  @override
  _PregReviewState createState() => _PregReviewState();
}

class _PregReviewState extends State<PregReview> {
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
              Tab(
                icon: Icon(Icons.cancel),
                child: Text("Rejected"),
              ),
            ],
          ),
          title: Text('Review Pregnancy Family'),
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
                            .where('pregApp', isEqualTo: true)
                            .snapshots()
                        : collection
                            .where('nameSearch', arrayContains: searchPara)
                            .where('midwifeID', isEqualTo: _user.uid)
                            .where('pregApp', isEqualTo: true)
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
                            .where('PregnanctFam', isEqualTo: true)
                            .snapshots()
                        : collection
                            .where('nameSearch', arrayContains: searchPara)
                            .where('midwifeID', isEqualTo: _user.uid)
                            .where('PregnanctFam', isEqualTo: true)
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
                            .where('PregnanctFam', isEqualTo: true)
                            .snapshots()
                        : collection
                            .where('nameSearch', arrayContains: searchPara)
                            .where('midwifeID', isEqualTo: _user.uid)
                            .where('PregnanctFam', isEqualTo: true)
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
                      documentSnapshot: document,
                      review: true,
                      reviewType: "preg",
                    )));
      },
    );
  }
}
