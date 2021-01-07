import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/Sister/Duty/DutyViewer.dart';
import 'package:provider/provider.dart';

class MidDutyView extends StatefulWidget {
  MidDutyView({Key key}) : super(key: key);

  @override
  _MidDutyViewState createState() => _MidDutyViewState();
}

class _MidDutyViewState extends State<MidDutyView> {
  String searchPara = "";
  CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  UserM _user;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserM>(context);
    String mohArea = _user.userCustomData['mohArea'];

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: SafeArea(
                  child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).copyWith().size.height / 6,
                  width: MediaQuery.of(context).copyWith().size.width,
                  color: Colors.lightBlue,
                  child: Container(
                    child: Text(
                      'Midwife Duty',
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
                        MediaQuery.of(context).size.height * 0.002),
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
                                        .where('role',
                                            isEqualTo: "midwife")
                                        .where("mohArea", isEqualTo:mohArea)
                                        .snapshots()
                                    : collection
                                        .where('nameSearch',
                                            arrayContains: searchPara)
                                        .where('role',
                                            isEqualTo: "midwife")
                                        .where("mohArea", isEqualTo:mohArea)
                                        .snapshots(),
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
                            MediaQuery.of(context).size.height * 0.09),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: RaisedButton(
                                              shape: StadiumBorder(),
                                              textColor: Colors.white,
                                              color: Colors.lightBlue,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Back',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                              ),
                            ),
                            // Container(
                            //   child: Align(
                            //     alignment: Alignment.bottomRight,
                            //     child: ElevatedButton(
                            //       child: Text('Submit'),
                            //       onPressed: () {},
                            //     ),
                            //   ),
                            // ),
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
      ),
    );
  }

 Widget listItem(DocumentSnapshot document) {
  
    return new ListTile(
      leading: Icon(Icons.person_rounded),
      title: new Text(document['name']),
      subtitle: new Text(
        "Active",
        style: TextStyle(color: Colors.black45),
      ),
      trailing: Icon(Icons.more_vert_rounded),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => DutyViewer(uid: document.id)));
      },
    );
  }
}