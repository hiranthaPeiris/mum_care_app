import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/models/UserReg.dart';
import 'package:mun_care_app/screens/registration/ComFamReg.dart';
import 'package:mun_care_app/screens/registration/PreFamReg.dart';
import 'package:mun_care_app/services/UserDataService.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final String userEmail;
  final String userName;
  final String userBio;
  final String status;
  final String nameOfMidwife;
  final String area;
  final DocumentSnapshot documentSnapshot;
  const Profile(
      {Key key,
      this.userEmail,
      this.userName,
      this.userBio,
      this.status,
      this.nameOfMidwife,
      this.area,
      this.documentSnapshot})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserDataSevice _userDataSevice = UserDataSevice();

  UserM _user = new UserM.get();
  String uid;
  bool pending = true;
  ComRegDB _compData;
  PreRegDB _pregData;
  Map<String, dynamic> userCustomData;
  //DocumentSnapshot compFamData;
  //DocumentSnapshot pregData;
  Future<void> _launched;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(userCustomData);

    if (widget.documentSnapshot != null) {
      userCustomData = widget.documentSnapshot.data();
      uid = widget.documentSnapshot.id;
      print(widget.documentSnapshot.data());
    } else {
      userCustomData = _user.getCustomdata();
      uid = _user.uid;
    }

    print(userCustomData['PregnanctFam']);
    print(userCustomData['competencyFam']);

    if (userCustomData['competencyFam'] && userCustomData['PregnanctFam']) {
      _userDataSevice.getCompData(uid).then((doc) {
        setState(() {
          _compData = ComRegDB.fromSnapshot(doc);
          //compFamData = doc;
          print(doc);
        });
      });

      _userDataSevice.getPregData(uid).then((doc) {
        setState(() {
          _pregData = PreRegDB.fromSnapshot(doc);
          //pregData = doc;
          //print(doc);
          pending = false;
        });
      });
    } else if (userCustomData['competencyFam']) {
      _userDataSevice.getCompData(uid).then((doc) {
        setState(() {
          //compFamData = doc;
          _compData = ComRegDB.fromSnapshot(doc);
          print(doc.data());
          pending = false;
        });
      });
    } else {
      setState(() {
        pending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = userCustomData['name'];
    String tel = userCustomData['tel'];
    String email = userCustomData['email'];
    bool comp = userCustomData['competencyFam'];
    bool preg = userCustomData['PregnanctFam'];
    //print( _compData.regDate);
    return pending
        ? Loading()
        : DefaultTabController(
            length: 3,
            child: SafeArea(
              child: Scaffold(
                bottomNavigationBar: Bottom_nav(),
                appBar: AppBar(
                  title: Text("Profile"),
                  backgroundColor: kBackground,
                  /*leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),*/
                  actions: <Widget>[
                    IconButton(icon: Icon(Icons.search), onPressed: () {}),
                    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                  ],
                  /*bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],*/
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      //height: 5.0,
                      /*DrawerHeader(
                  child: Text(
                    'Edit profile',
                    style: TextStyle(fontSize: 20.0, color: Colors.white70),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.blue,
                  ),
                ),*/
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
                              "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                            ),
                          ),
                          //child: ,
                        ),
                      ),
                      ListTile(
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
                      ),
                      ListTile(
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
                      ),
                    ],
                  ),
                ),
                body: Container(
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
                          child: Container(
                            width: double.infinity,
                            height: 264.0,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                                    ),
                                    radius: 50.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Card(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5.0),
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.white,
                                    elevation: 5.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 22.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Status",
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  (comp&&preg)?"Pregnant Mother":"Competency Family",
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
                                                    fontSize: 18.0,
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
                                                    fontSize: 18.0,
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
                          )),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(5.0),
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(
                                      'Name',
                                      style: TextStyle(
                                          color: kBackground,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    subtitle: Text(
                                      "$name",
                                      style: TextStyle(color: kMenuTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                      style: TextStyle(color: kMenuTextColor),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _launched = _makePhoneCall('tel:$tel');
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.email),
                                    title: Text(
                                      'Email',
                                      style: TextStyle(
                                          color: kBackground,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    subtitle: Text(
                                      email,
                                      style: TextStyle(color: kMenuTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            comp
                                ? Card(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "Competency Family Information",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                        _buildTile(
                                            "Full Name", _compData.wifeName),
                                        _buildTile("Name of Husband",
                                            _compData.husbandName),
                                        _buildTile(
                                            "Address", _compData.address),
                                        _buildTile("NIC", _compData.nic),
                                        _buildTile(
                                            "Date of Birth", _compData.dateDOB),
                                        _buildTile("Job", _compData.job),
                                        _buildTile("PHM Area",
                                            _compData.phmDropDownValue),
                                        _buildTile("AHM Area",
                                            _compData.mohDropDownValue),
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "Mother Pregnancy Information",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                        _buildTile("Full Name", "Name in full"),
                                        _buildTile(
                                            "Name of Husband", "Husbund name"),
                                        _buildTile(
                                            "Address", "address, sri lanka"),
                                        _buildTile("NIC", "986578123V"),
                                        _buildTile(
                                            "Date of Birth", "1996-02-30"),
                                        _buildTile("Job", "None"),
                                        _buildTile(
                                            "PHM Area", "address, sri lanka"),
                                        _buildTile(
                                            "AHM Area", "address, sri lanka"),
                                        _buildTile("Date of Registration",
                                            "address, sri lanka")
                                      ],
                                    ),
                                  )
                                : SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<DocumentSnapshot> getCompData(String uID) async {
    return await _firestore
        .collection('ComDatabase')
        .doc(uID)
        .get()
        .then(((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        //print('Document data: ${documentSnapshot.data()}');
        return documentSnapshot;
      } else {
        print('Document does not exist on the database');
        return null;
      }
    }));
  }

  Future<DocumentSnapshot> getPregData(String uID) async {
    return await _firestore
        .collection('PreDatabase')
        .doc(uID)
        .get()
        .then(((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //print('Document data: ${documentSnapshot.data()}');
        return documentSnapshot;
      } else {
        print('Document does not exist on the database');
        return null;
      }
    }));
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
}
