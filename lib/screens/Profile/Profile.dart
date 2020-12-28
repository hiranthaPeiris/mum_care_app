import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/helpers/interfaces/CustomPopMenu.dart';
import 'package:mun_care_app/models/Notification.model.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/models/UserReg.dart';
import 'package:mun_care_app/screens/registration/ComFamReg.dart';
import 'package:mun_care_app/screens/registration/PreFamReg.dart';
import 'package:mun_care_app/services/NotificationService.dart';
import 'package:mun_care_app/services/StorageService.dart';
import 'package:mun_care_app/services/UserDataService.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final bool review;
  final String reviewType;
  final DocumentSnapshot documentSnapshot;
  const Profile({Key key, this.documentSnapshot, this.review, this.reviewType})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserDataSevice _userDataSevice = UserDataSevice();
  final StorageService _storageService = StorageService();
  final NotificationService _notificationService = NotificationService();
  final picker = ImagePicker();

  TextEditingController remarks = TextEditingController();
  UserM _user = new UserM.get();
  String uid;
  bool pending = true;
  bool drawer = true; //used for side drawer
  ComRegDB _compData;
  PreRegDB _pregData;
  Map<String, dynamic> userCustomData;
  String _profileImage =
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg";
  File _image;

  /// App bar pop up menu items
  List<String> choices = [
    "Change Profile Picture",
    "Update Profile",
    "Settings"
  ];
  //DocumentSnapshot compFamData;
  //DocumentSnapshot pregData;

  //For url luncher
  Future<void> _launched;

  Future getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      pending = true;
      if (image != null) {
        _image = File(image.path);
        _storageService.uploadProfileImage(_image, _user.uid, "profile");
      }
      pending = false;
    });
  }

  void choiceAction(String choice) {
    if (choice == "Change Profile Picture") {
      getImage();
    } else if (choice == "Update Profile") {
      //getImage();
      print('Subscribe');
    } else if (choice == "Settings") {
      print('SignOut');
    }
  }

  @override
  void initState() {
    if (widget.documentSnapshot != null) {
      userCustomData = widget.documentSnapshot.data();
      uid = widget.documentSnapshot.id;
      drawer = false;
      //print(widget.documentSnapshot.data());
    } else {
      userCustomData = _user.getCustomdata();
      uid = _user.uid;
    }

    //print(userCustomData['PregnanctFam']);
    //print(userCustomData['competencyFam']);
    _storageService.downloadProfileImage("profile", uid).then((url) {
      if (url != null) {
        setState(() {
          _profileImage = url;
          //pending = false;
          print("image came");
        });
      }
    });

    if ((userCustomData['compApp'] && userCustomData['pregApp']) ||
        (userCustomData['PregnanctFam'] && userCustomData['competencyFam'])) {
      _userDataSevice.getCompData(uid).then((doc) {
        setState(() {
          _compData = ComRegDB.fromSnapshot(doc);
          //compFamData = doc;
          //print(doc.data());
        });
      });

      _userDataSevice.getPregData(uid).then((doc) {
        setState(() {
          _pregData = PreRegDB.fromSnapshot(doc);
          //pregData = doc;
          //print(_pregData.m);
          pending = false;
        });
      });
    } else if (userCustomData['compApp'] || userCustomData['competencyFam']) {
      _userDataSevice.getCompData(uid).then((doc) {
        setState(() {
          //compFamData = doc;
           pending = false;
          _compData = ComRegDB.fromSnapshot(doc);
          //print(doc.data());
        });
      });
    } else {
      setState(() {
        pending = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String name = userCustomData['name'];
    String tel = userCustomData['tel'];
    String email = userCustomData['email'];
    bool comp;
    bool preg;

    if (widget.review) {
      comp = userCustomData['compApp'];
      preg = userCustomData['pregApp'];
    } else {
      comp = userCustomData['competencyFam'];
      preg = userCustomData['PregnanctFam'];
    }

    //print( _compData.regDate);
    return pending
        ? Loading()
        : DefaultTabController(
            length: 3,
            child: SafeArea(
              child: Scaffold(
                  key: _scaffoldKey,
                  bottomNavigationBar: (drawer)
                      ? Bottom_nav(
                          scaffoldKey: _scaffoldKey,
                        )
                      : null,
                  appBar: AppBar(
                    title: Text("Profile"),
                    backgroundColor: kBackground,
                    actions: <Widget>[
                      PopupMenuButton(
                        onSelected: choiceAction,
                        itemBuilder: (BuildContext context) {
                          return choices.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      )
                    ],
                  ),
                  drawer: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountEmail: Text("Alice@gmail.com"),
                          accountName: Text(
                            name,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          currentAccountPicture: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                _profileImage,
                              ),
                            ),
                            //child: ,
                          ),
                        ),
                        (drawer)
                            ? ListTile(
                                title: Text(
                                  'Edit Competency Fam Data',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ComFamReg()));
                                },
                              )
                            : SizedBox(
                                height: 2.0,
                              ),
                        (drawer)
                            ? ListTile(
                                title: Text(
                                  'Edit Pregncy  Data',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PreFamReg()));
                                },
                              )
                            : SizedBox(
                                height: 2.0,
                              ),
                      ],
                    ),
                  ),
                  body: Builder(
                      builder: (context) => Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [kBackground, kBlueColor],
                                    //tileMode: TileMode.repeated,
                                  )),
                                  child: _buildTopRow(comp, preg, name),
                                ),
                                Expanded(
                                  child: ListView(
                                    padding: const EdgeInsets.all(5.0),
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      _buildCard(
                                          "Name", name, Icon(Icons.person)),
                                      Card(
                                        child: Column(
                                          children: <Widget>[
                                            ListTile(
                                              leading: Icon(Icons.phone),
                                              title: Text(
                                                'Contact',
                                                style: TextStyle(
                                                    color: kBackground,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16),
                                              ),
                                              subtitle: Text(
                                                tel,
                                                style: TextStyle(
                                                    color: kMenuTextColor),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _launched = _makePhoneCall(
                                                      'tel:$tel');
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      _buildCard(
                                          "Email", email, Icon(Icons.email)),
                                      comp
                                          ? Card(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Competency Family Information",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 18.0),
                                                    ),
                                                  ),
                                                  _buildTile("Full Name",
                                                      _compData.wifeName),
                                                  _buildTile("Name of Husband",
                                                      _compData.husbandName),
                                                  _buildTile("Address",
                                                      _compData.address),
                                                  _buildTile(
                                                      "NIC", _compData.nic),
                                                  _buildTile("Date of Birth",
                                                      _compData.womenDOB),
                                                  _buildTile(
                                                      "Job", _compData.job),
                                                  _buildTile(
                                                      "PHM Area",
                                                      _compData
                                                          .phmDropDownValue),
                                                  _buildTile(
                                                      "AHM Area",
                                                      _compData
                                                          .mohDropDownValue),
                                                  // _buildTile("Date of Registration",
                                                  //     _compData.regDate),
                                                  _buildTile("Date of Marrage",
                                                      _compData.marrageDate)
                                                ],
                                              ),
                                            )
                                          : SizedBox(height: 5.0),
                                      preg
                                          ? Card(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "Mother Pregnancy Information",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 18.0),
                                                    ),
                                                  ),
                                                  _buildTile(
                                                      "MOH Area",
                                                      _pregData
                                                          .mohDropDownValue),
                                                  _buildTile(
                                                      "PHM Area",
                                                      _pregData
                                                          .phmDropDownValue),
                                                  _buildTile(
                                                      "Grama Niladhari Division",
                                                      _pregData.gnDivision),
                                                  _buildTile("Field Clinic",
                                                      _pregData.fcName),
                                                  _buildTile("Date of Birth",
                                                      "1996-02-30"),
                                                  _buildTile(
                                                      "Hospital in Clinic",
                                                      _pregData.hcName),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                        "Consultant Obstetrician"),
                                                  ),
                                                  _buildTile("Pregnancy Count",
                                                      _pregData.womb),
                                                  _buildTile("Pregnancy Count",
                                                      "address, sri lanka"),
                                                  _buildTile(
                                                      "Date of Registration",
                                                      "address, sri lanka"),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                        "Present Obstetric History"),
                                                  ),
                                                  _buildTile(
                                                      "Present vaginal bleeding",
                                                      _pregData.pvb.toString()),
                                                  _buildTile("Blood Pressure",
                                                      _pregData.bloodPresure),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                        "Medical/Surgical History"),
                                                  ),
                                                  _buildTile(
                                                      "Maleria",
                                                      _pregData.maleria
                                                          .toString()),
                                                  _buildTile(
                                                      "Diabetic",
                                                      _pregData.diabetic
                                                          .toString()),
                                                  _buildTile(
                                                      "Heart Disorders",
                                                      _pregData.heartDisorder
                                                          .toString()),
                                                ],
                                              ),
                                            )
                                          : SizedBox(height: 5.0),
                                    ],
                                  ),
                                ),
                                (widget.review)
                                    ? Container(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.001),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Back'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      openBottomSheet(context);
                                                      // dynamic rst =
                                                      //     updateReviewState(widget
                                                      //         .documentSnapshot
                                                      //         .id);

                                                      // if (rst != null) {
                                                      //   _buildSnackBar(context);
                                                      // } else {
                                                      //   print(
                                                      //       "profile update error");
                                                      // }
                                                      //Navigator.pop(context);
                                                    },
                                                    child: Text('Accept'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        Text('Request Change'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 1.0,
                                      ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ))),
            ),
          );
  }

  void openBottomSheet(BuildContext cont) {
    List<bool> _selections = List.generate(3, (_) => false);
    print(_selections.indexWhere((element) => true));
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModelState) {
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
                                          "Review",
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
                          child: Column(
                            children: [
                              Text(
                                "Mother Condition",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  ToggleButtons(
                                    selectedColor: kBackground,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Text("Normal"),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Icon(Icons.adjust_outlined,
                                                color: Colors.green)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Text("Need Attention"),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Icon(Icons.adjust_outlined,
                                                color: Colors.orange),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Text("Danger"),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Icon(Icons.adjust_outlined,
                                                color: Colors.red),
                                          ],
                                        ),
                                      ),
                                    ],
                                    onPressed: (int index) {
                                      setModelState(() {
                                        for (int buttonIndex = 0;
                                            buttonIndex < _selections.length;
                                            buttonIndex++) {
                                          if (buttonIndex == index) {
                                            _selections[buttonIndex] = true;
                                          } else {
                                            _selections[buttonIndex] = false;
                                          }
                                        }
                                      });
                                    },
                                    isSelected: _selections,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text("Special Remarks",
                                  style: TextStyle(fontSize: 16)),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: TextFormField(
                                  controller: remarks,
                                  decoration: InputDecoration(
                                    labelText: "Remarks",
                                    hintText: "remark on mother",
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please Enter a remark";
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              Container(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    child: Text('Accept'),
                                    onPressed: () {
                                      String condition = getCondition(
                                          _selections.indexWhere(
                                              (element) => element == true));
                                      print(condition);

                                      dynamic rst = updateReviewState(
                                          widget.documentSnapshot.id,
                                          condition);

                                      if (rst != null) {
                                        _buildSnackBar(cont);
                                      } else {
                                        print("profile update error");
                                      }
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
            },
          );
        });
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getCondition(int index) {
    switch (index) {
      case 0:
        return "Normal";
        break;
      case 1:
        return "Need Attention";
        break;
      case 2:
        return "Danger";
        break;
      default:
        return "okay";
    }
  }

  Future<void> updateReviewState(String uID, String condition) async {
    //competencyFam
    String type, apply;
    if (widget.reviewType == "comp") {
      type = "competencyFam";
      apply = "compApp";
    } else {
      type = "PregnanctFam";
      apply = "pregApp";
    }
    await _firestore
        .collection('users')
        .doc(uID)
        .update({type: true, apply: false, 'condition': condition})
        .then((value) => print("User status Updated"))
        .catchError((error) => print("Failed to update user: $error"));

    NotificationM notification = NotificationM(
        "Application Status",
        "Your $type application has accepted",
        new DateTime.now().toString(),
        widget.documentSnapshot.id,
        new DateTime.now(),
        "reg",
        "Registration confirmation");
    await _notificationService.sendAndRetrieveMessage(
        notification.getMap(), userCustomData['token']);
  }

  _buildSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Successfully updated'),
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

  Widget _buildTopRow(bool comp, bool preg, String name) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                _profileImage,
              ),
              radius: 40.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              elevation: 5.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Status",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            (comp && preg)
                                ? "Pregnant Mother"
                                : "Competency Family",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.pinkAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Area",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            "Colombo South",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.pinkAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Mid Wife",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            "Mrs. A.D. Sliva",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.pinkAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTile(String header, String subtitle) {
    return ListTile(
      title: Text(
        header,
        style: TextStyle(
            color: kBackground, fontWeight: FontWeight.w700, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: kMenuTextColor),
      ),
    );
  }

  Widget _buildCard(String header, String subtitle, Icon icon) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: icon,
            title: Text(
              header,
              style: TextStyle(
                  color: kBackground,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: kMenuTextColor),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
