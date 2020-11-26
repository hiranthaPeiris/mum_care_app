import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleHomeVisits.dart';
import 'package:mun_care_app/models/UserM.dart';

class SchHomeVisitSearch extends StatefulWidget {
  @override
  _SchHomeVisitSearchState createState() => _SchHomeVisitSearchState();
}

class _SchHomeVisitSearchState extends State<SchHomeVisitSearch> {
  String searchPara = "";
  CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  final UserM _userM = UserM.get();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).copyWith().size.height / 6,
                width: MediaQuery.of(context).copyWith().size.width,
                color: Colors.lightBlue,
                child: Container(
                  child: Text(
                    'Schedule Home Visit',
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
                      MediaQuery.of(context).size.height * 0.02),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                height: MediaQuery.of(context).copyWith().size.height * (5 / 6),
                width: MediaQuery.of(context).copyWith().size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29.5),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                icon:
                                    SvgPicture.asset("assets/icons/search.svg"),
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
                                      .where('midwifeID',
                                          isEqualTo:
                                              _userM.userCredential.user.uid)
                                      .snapshots()
                                  : collection
                                      .where('nameSearch',
                                          arrayContains: searchPara)
                                      .where('midwifeID',
                                          isEqualTo:
                                              _userM.userCredential.user.uid)
                                      .snapshots(includeMetadataChanges: true),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Loading");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Text("No data present");
                                }
                                return new ListView(
                                    children: snapshot.data.docs
                                        .map((DocumentSnapshot document) {
                                  //refe from below
                                  return listItem(document);
                                  /*new ListTile(
                                    leading: Icon(Icons.person_rounded),
                                    title: new Text(document['name']),
                                    subtitle: new Text(
                                      "Competency Family : ${document['competencyFam']}",
                                      style: TextStyle(color: Colors.black26),
                                    ),
                                    trailing: Icon(Icons.more_vert_rounded),
                                  );*/
                                }).toList());
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.1,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.width * 0.05,
                          MediaQuery.of(context).size.height * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Back'),
                              ),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                child: Text('Submit'),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(DocumentSnapshot document) {
    String state = "null";
    if (document['competencyFam'] == true) {
      if (document['PregnanctFam'] == true) {
        state = "Pregnant Mother";
      } else {
        state = "competency Family";
      }
    }else{
      state = "Not Applied";
    }

    return new ListTile(
      leading: Icon(Icons.person_rounded),
      title: new Text(document['name']),
      subtitle: new Text(
        state,
        style: TextStyle(color: Colors.black45),
      ),
      trailing: Icon(Icons.more_vert_rounded),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => ScheduleHomeVisits(
                      document: document,midwifeId: _userM.uid,
                    )));
      },
    );
  }
}
