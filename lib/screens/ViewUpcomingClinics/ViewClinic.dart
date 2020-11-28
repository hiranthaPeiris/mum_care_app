import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/Profile/Profile.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleClinic.dart';
import 'package:mun_care_app/services/ClinicService.dart';

class ViewClinic extends StatefulWidget {
  ViewClinic({Key key, this.documentSnapshot}) : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final QueryDocumentSnapshot documentSnapshot;
  @override
  _ViewClinicState createState() => _ViewClinicState();
}

class _ViewClinicState extends State<ViewClinic> {
  final ClinicService _clinicService = ClinicService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = new UserM.get();
  Map<String, String> data;
  bool pending = true;

  @override
  void initState() {
    super.initState();
    List<DocumentReference> usersClinicRefList =
        widget.documentSnapshot['userClinicRef'].cast<DocumentReference>();

    getConf(usersClinicRefList).then((result) {
      setState(() {
        data = result;
        pending = false;
      });
      print(data.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    String midWifeClinicID = widget.documentSnapshot.id; //Current document
    String midID = user.uid;
    String itemTitle = widget.documentSnapshot["description"];
    String itemStatus = widget.documentSnapshot["status"];
    String itemDate = widget.documentSnapshot['dateTime'].toString();
    int itemCount = widget.documentSnapshot['count'];
    List<dynamic> usersRefList = widget.documentSnapshot['users'];
    List<DocumentReference> usersClinicRefList =
        widget.documentSnapshot['userClinicRef'].cast<DocumentReference>();
    //Map<DocumentReference,String> confMap = await getConf(usersClinicRefList);

    return pending
        ? Loading()
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: kBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      itemTitle,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "by Mr. Silva",
                      style: TextStyle(color: kTextColor, fontSize: 12.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      itemDate,
                      style: TextStyle(color: kTextColor, fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "Morning",
                      style: TextStyle(color: kTextColor, fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "Clinic Status: $itemStatus",
                      style: TextStyle(color: kTextColor, fontSize: 14.0),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        )),
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 0.0),
                          child: Row(
                            children: [
                              Text(
                                "Number of Confirmed Mothers:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                width: 30.0,
                                height: 30.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xFF8d3edd),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "$itemCount",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontSize: 18.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            "Mothers Invited",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: widget._firestore
                                    .collection('users')
                                    .where('midwifeID', isEqualTo: midID)
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
                                      return _buildListTile(
                                          document, usersClinicRefList);
                                      //new ListTile(
                                      //   title: new Text(document['name']),
                                      //   trailing: Icon(
                                      //     Icons.check_circle,
                                      //     color: Colors.green,
                                      //   ),
                                      //   leading: Icon(Icons.person_rounded),
                                      // );
                                    }).toList(),
                                  );
                                })),
                        Container(
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 20.0),
                          child: Row(
                            children: <Widget>[
                              FlatButton(
                                shape: StadiumBorder(),
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
                              SizedBox(
                                width: 10.0,
                              ),
                              RaisedButton(
                                shape: StadiumBorder(),
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
                                          builder: (context) => ScheduleClinic(
                                              rescheduleFLAG: true,
                                              docID: midWifeClinicID,
                                              userClinicRefList:
                                                  usersClinicRefList)));
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RaisedButton(
                                shape: StadiumBorder(),
                                color: kBackground,
                                child: Text(
                                  "Clinic Completed",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                onPressed: () {
                                  //Put your code here which you want to execute on Yes button click.
                                  _clinicService.updateStatus(
                                      midID,
                                      midWifeClinicID,
                                      CLINICSTATE.done,
                                      usersClinicRefList);
                                },
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
          );
  }

  Widget _buildListTile(DocumentSnapshot documentSnapshot,
      List<DocumentReference> usersClinicRefList) {
    //print(documentSnapshot.id);
    //use Regex to match
    DocumentReference userClincRef;

    RegExp reg3 =
        new RegExp(r'(Bookings)\/(' + documentSnapshot.id + ')\/Clinics');
    usersClinicRefList.forEach((document) {
      bool rst = reg3.hasMatch(document.path);
      if (rst) {
        //print(document.parent);
        userClincRef = document;
      }
      //(rst==true)?print(document):print("none");
    });
    print(data[userClincRef.path]);
    String conf = data[userClincRef.path];
    // getConf(userClincRef).then((value) => conf=value);
    // print(conf);

    return new ListTile(
      title: new Text(documentSnapshot['name']),
      trailing: (conf == 'CLINICCONFM.accept')
          ? Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          : Icon(Icons.cancel_rounded, color: Colors.red),
      leading: Icon(Icons.person_rounded),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Profile(
                      documentSnapshot: documentSnapshot,
                    )));
      },
    );
  }

  Future<Map<String, String>> getConf(
      List<DocumentReference> usersClinicRefList) async {
    Map<String, String> confMap = Map();

    await Future.forEach(usersClinicRefList,
        (DocumentReference documentRef) async {
      await documentRef.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          //print(documentSnapshot['confirmation']);
          confMap[documentRef.path] = documentSnapshot['confirmation'];
        }
      }).catchError((err) => print(err));
    });
    return confMap;
  }
}
