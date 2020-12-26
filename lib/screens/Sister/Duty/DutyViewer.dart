import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/DiaryServices.dart';
import 'package:provider/provider.dart';

class DutyViewer extends StatefulWidget {
  DutyViewer({Key key, this.uid}) : super(key: key);
  final String uid;
  @override
  _DutyViewerState createState() => _DutyViewerState();
}

class _DutyViewerState extends State<DutyViewer> {
  String searchPara = "";
  CollectionReference collection;
  UserM _user;

  @override
  void initState() {
    collection = FirebaseFirestore.instance
        .collection('workJobs')
        .doc(widget.uid)
        .collection("jobs");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserM>(context);

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
                    'View Duty',
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
                                  ? collection.snapshots()
                                  : collection
                                      // .where('nameSearch',
                                      //     arrayContains: searchPara)
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
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    elevation: 2,
                                    margin: EdgeInsets.all(5.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ExpansionTile(
                                          backgroundColor: Colors.white,
                                          title: _buildTitle(document),
                                          trailing: SizedBox(),
                                          children: _buildDataList(document)),
                                    ),
                                  );
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
    );
  }

  List<Widget> _buildDataList(DocumentSnapshot document) {
    Timestamp startTime = document['startTime'];
    Timestamp endTime = document['endTime'];
    // TimeOfDay start = TimeOfDay.fromDateTime(
    //     DateTime.fromMillisecondsSinceEpoch(startTime.millisecondsSinceEpoch));
    // TimeOfDay end = TimeOfDay.fromDateTime(
    //     DateTime.fromMillisecondsSinceEpoch(endTime.millisecondsSinceEpoch));
    String start = getTimeSlug(
        DateTime.fromMillisecondsSinceEpoch(startTime.millisecondsSinceEpoch));
    String end = getTimeSlug(
        DateTime.fromMillisecondsSinceEpoch(endTime.millisecondsSinceEpoch));
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Text("Duty Start: $start"),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Text("Duty End: $end"),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Text(
                "Duty Duration: ${document['durationHrs']} Hours & ${document['durationMins']} Minutes"),
            Spacer(),
          ],
        ),
      )
    ];
  }

  Widget _buildTitle(DocumentSnapshot document) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("DATE",
                style: TextStyle(color: kActiveIconColor, fontSize: 14.0)),
          ],
        ),
        Text(document.id),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Duty Status: "),
            Text("Active"),
            Spacer(),
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            Spacer(),
            Spacer(),
            Text("Tap to See More",
                style: TextStyle(color: kActiveIconColor, fontSize: 12.0)),
            // FlatButton.icon(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(15.0))),
            //   padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            //   color: Colors.blue,
            //   textColor: Colors.white,
            //   onPressed: () {},
            //   icon: Icon(Icons.arrow_circle_down),
            //   label: ,
            // ),
          ],
        ),
      ],
    );
  }

  Widget listItem(DocumentSnapshot document) {
    return new ListTile(
      leading: Icon(Icons.person_rounded),
      title: new Text(document.id),
      subtitle: new Text(
        "Active",
        style: TextStyle(color: Colors.black45),
      ),
      trailing: Icon(Icons.more_vert_rounded),
      onTap: () {
        // Navigator.push(
        //     context,
        //     new MaterialPageRoute(
        //         builder: (context) => ScheduleHomeVisits(
        //               document: document,
        //               midwifeId: _user.uid,
        //             )));
      },
    );
  }

  String getDateSlug(DateTime _date) {
    return DateTimeFormat.format(
        new DateTime(
            _date.year, _date.month, _date.day, _date.hour, _date.minute),
        format: DateTimeFormats.american);
  }

  String getTimeSlug(DateTime dateTime) {
    TimeOfDay time = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch));

    int hrs = time.hour % 12;
    int mins = time.minute;
    int period = time.hourOfPeriod;
    String pre = (period == 1) ? "AM" : "PM";
    return "$hrs:$mins $pre";
  }
}
