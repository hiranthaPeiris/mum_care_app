import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/NoticeModel.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/services/NoticeService.dart';
import 'package:provider/provider.dart';

enum NoticeAudiance { General, Midwife, Eligible, Pregnancy }

class SendNotice extends StatefulWidget {
  SendNotice({Key key}) : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _SendNoticeState createState() => _SendNoticeState();
}

class _SendNoticeState extends State<SendNotice> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  //TextEditingController title = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NoticeService _noticeService = NoticeService();
  UserM _user;
  bool pending = false;
  NoticeAudiance _audiance = NoticeAudiance.General;

  @override
  Widget build(BuildContext context) {
    String dropdownSubject = 'Home visits';
    String dropdownLevel = "Normal";
    _user = Provider.of<UserM>(context);

    return pending
        ? Loading()
        : Scaffold(
            body: Builder(
                builder: (context) => SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    6,
                            width: MediaQuery.of(context).copyWith().size.width,
                            color: Colors.lightBlue,
                            child: Container(
                              child: Text(
                                'Special Notice',
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
                          DefaultTabController(
                            length: 2,
                            initialIndex: 0,
                            child: Column(
                              children: [
                                Container(
                                  child: TabBar(tabs: [
                                    Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Create New",
                                          style: TextStyle(
                                              color: kActiveIconColor),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Sent",
                                            style: TextStyle(
                                                color: kActiveIconColor)),
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                  height: 600,
                                  child: TabBarView(children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                              flex: 9,
                                              child: Column(
                                                children: [
                                                  Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0),
                                                            child:
                                                                TextFormField(
                                                              controller: title,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    "Title",
                                                                hintText:
                                                                    "Title of the notice",
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                    .isEmpty) {
                                                                  return "Please Enter a title";
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0),
                                                            child:
                                                                TextFormField(
                                                              controller: desc,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    "Description",
                                                                hintText:
                                                                    "Description of the notice",
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                    .isEmpty) {
                                                                  return "Please Enter a description";
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Relevent Subject"),
                                                      DropdownButton<String>(
                                                        value: dropdownSubject,
                                                        icon: Icon(Icons
                                                            .arrow_downward),
                                                        iconSize: 24,
                                                        elevation: 16,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .deepPurple),
                                                        underline: Container(
                                                          height: 2,
                                                          color: Colors
                                                              .deepPurpleAccent,
                                                        ),
                                                        onChanged:
                                                            (String newValue) {
                                                          setState(() {
                                                            dropdownSubject =
                                                                newValue;
                                                          });
                                                        },
                                                        items: <String>[
                                                          'Home visits',
                                                          'Clinics',
                                                          'Registration',
                                                          'Medications',
                                                        ].map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Notice Level"),
                                                      DropdownButton<String>(
                                                        value: dropdownLevel,
                                                        icon: Icon(Icons
                                                            .arrow_downward),
                                                        iconSize: 24,
                                                        elevation: 16,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .deepPurple),
                                                        underline: Container(
                                                          height: 2,
                                                          color: Colors
                                                              .deepPurpleAccent,
                                                        ),
                                                        onChanged:
                                                            (String newValue) {
                                                          setState(() {
                                                            dropdownLevel =
                                                                newValue;
                                                          });
                                                        },
                                                        items: <String>[
                                                          'Normal',
                                                          'Medium Attention',
                                                          'Immediate'
                                                              'Critical',
                                                        ].map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text("Send to: "),
                                                      SizedBox(
                                                        width: 20.0,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            RadioListTile<
                                                                NoticeAudiance>(
                                                              title: const Text(
                                                                  'General Notice'),
                                                              value:
                                                                  NoticeAudiance
                                                                      .General,
                                                              groupValue:
                                                                  _audiance,
                                                              onChanged:
                                                                  (NoticeAudiance
                                                                      value) {
                                                                setState(() {
                                                                  _audiance =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                            RadioListTile<
                                                                NoticeAudiance>(
                                                              title: const Text(
                                                                  'Midwife Group'),
                                                              value:
                                                                  NoticeAudiance
                                                                      .Midwife,
                                                              groupValue:
                                                                  _audiance,
                                                              onChanged:
                                                                  (NoticeAudiance
                                                                      value) {
                                                                setState(() {
                                                                  _audiance =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                            RadioListTile<
                                                                NoticeAudiance>(
                                                              title: const Text(
                                                                  'Eligible Families'),
                                                              value:
                                                                  NoticeAudiance
                                                                      .Eligible,
                                                              groupValue:
                                                                  _audiance,
                                                              onChanged:
                                                                  (NoticeAudiance
                                                                      value) {
                                                                setState(() {
                                                                  _audiance =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                            RadioListTile<
                                                                NoticeAudiance>(
                                                              title: const Text(
                                                                  'Pregnancy Families'),
                                                              value:
                                                                  NoticeAudiance
                                                                      .Pregnancy,
                                                              groupValue:
                                                                  _audiance,
                                                              onChanged:
                                                                  (NoticeAudiance
                                                                      value) {
                                                                setState(() {
                                                                  _audiance =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 30, 10, 0),
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RaisedButton(
                                                    shape: StadiumBorder(),
                                                    textColor: Colors.white,
                                                    color: Colors.lightBlue,
                                                    child: Text(
                                                      'Back',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/dashboard');
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  RaisedButton(
                                                    shape: StadiumBorder(),
                                                    textColor: Colors.white,
                                                    color: Colors.lightBlue,
                                                    child: Text(
                                                      'Send',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        setState(() {
                                                          pending = true;
                                                        });
                                                        //String dateSlug = getDateSlug();
                                                        //print(' Data : $des , $_date, $_time, $dateslug');
                                                        NoticeModel notice =
                                                            NoticeModel(
                                                                title:
                                                                    title.text,
                                                                description:
                                                                    desc.text,
                                                                level:
                                                                    dropdownLevel,
                                                                subject:
                                                                    dropdownSubject,
                                                                midwifeID:
                                                                    _user.uid,audiance: _audiance.toString());
                                                        dynamic result =
                                                            _noticeService
                                                                .sendNotice(
                                                                    notice);
                                                        if (result == null) {
                                                          setState(() {
                                                            pending = false;
                                                            print(
                                                                "dynamic failed");
                                                          });
                                                        } else {
                                                          setState(() {
                                                            pending = false;
                                                          });
                                                          _displaySnackBar(
                                                              context);
                                                        }
                                                      } else {
                                                        print(
                                                            "validate failed");
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: StreamBuilder<QuerySnapshot>(
                                              stream: widget._firestore
                                                  .collection('Notice')
                                                  .where('midwifeID',
                                                      isEqualTo: _user.uid)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Text('Loding...');
                                                }
                                                return ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .data.docs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      String documentId =
                                                          snapshot.data
                                                              .docs[index].id;
                                                      return Column(
                                                        children: <Widget>[
                                                          SingleChildScrollView(
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: 100.0,
                                                                  child:
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            openBottomSheet(documentId);
                                                                          },
                                                                          child: _buildListItem(
                                                                              snapshot,
                                                                              index)),
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
                                        ],
                                      ),
                                    )
                                  ]),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )));
  }

  String getCondition(int index) {
    switch (index) {
      case 0:
        return "All Mothers";
        break;
      case 1:
        return "Midwife Group";
        break;
      case 2:
        return "Eligible Family";
        break;
      default:
        return "okay";
    }
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Successfully Submitted'),
      action: SnackBarAction(
        label: 'Go Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      duration: Duration(seconds: 3),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void openBottomSheet(String itemId) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 400.0,
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
                                      "Notice",
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Notice")
                              .doc(itemId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }
                            if (!snapshot.hasData) {
                              return Container(
                                child: Text("No data"),
                              );
                            }
                            if (snapshot.hasData) {
                              var value = snapshot.data;

                              return Column(children: [
                                Row(
                                  children: [
                                    Text("Notice Title: "),
                                    Text(value['title']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Description: "),
                                    Text(value['description']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Level of the Notice :"),
                                    Text(value['level']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Subject of the Noice: "),
                                    Text(value['subject']),
                                  ],
                                ),
                              ]);
                            }
                            return Container(
                              child: Text("Stream Error"),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
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
        });
  }

  Widget _buildListItem(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return Stack(
      alignment: Alignment.center,
      // overflow:
      //  Overflow.visible,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(11.0),
          height: 70.0,
          width: 300.0,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(15.0)),
        ),
        Positioned(
          bottom: 20.0,
          child: Container(
            height: 50.0,
            width: 330.0,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15.0)),
          ),
        ),
        Positioned(
          // bottom: 25.0,
          child: Container(
            // height: 80.0,
            width: 350.0,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
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
                                      Text(snapshot.data.docs[index]['title'],
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: <Widget>[
                                      Text(snapshot.data.docs[index]['subject'],
                                          textAlign: TextAlign.left),
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
    );
  }
}
