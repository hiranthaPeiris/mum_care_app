import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/chat/chatscreen.dart';

class SetChatUser extends StatefulWidget {
  @override
  _SetChatUserState createState() => _SetChatUserState();
}

class _SetChatUserState extends State<SetChatUser> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserM user = new UserM.get();

  getData01(String area) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('role', isEqualTo: 'user')
        .where('area01', isEqualTo: area)
        .snapshots();
  }

  getData02(String area) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('role', isEqualTo: 'midwife')
        .where('area01', isEqualTo: area)
        .snapshots();
  }

  Widget buildBody01(BuildContext context, String abc) {
    return StreamBuilder(
        stream: user.userCustomData['role'] == 'midwife'
            ? getData01(abc)
            : getData02(abc),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          if (snapshot.hasData) {
            print("Document -> ${snapshot.data.documents.length}");
            return buildList01(context, snapshot.data.documents);
          }
          return Container(
              child: Column(
            children: [
              Icon(
                Icons.info,
                color: Colors.blue,
                size: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Select a lot'),
              )
            ],
          ));
        });
  }

  Widget buildList01(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => listItemBuild01(context, data)).toList(),
    );
  }

  Widget listItemBuild01(BuildContext context, DocumentSnapshot data) {
    //final comRegBD = ComRegDB.fromSnapshot(data);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChatScreen(
                  userID: data.id,
                )),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          //color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
          color: Color(0xFFFFEFEE),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 35.0,
                  //backgroundImage: AssetImage(chat.sender.imageUrl),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data['name'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        data.id,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "Sender Name",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                // chat.unread
                //     ? Container(
                //   width: 40.0,
                //   height: 20.0,
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).primaryColor,
                //     borderRadius: BorderRadius.circular(30.0),
                //   ),
                //   alignment: Alignment.center,
                //   child: Text(
                //     'NEW',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 12.0,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // )
                //     : Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /*leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),*/
          title: Text(
            'Chats',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: // getState(context),
            SafeArea(
                child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(_auth.currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                var value = snapshot.data;
                String area = value['area01'].toString();

                print(area);
                print(_auth.currentUser.uid);
                if (snapshot.hasError) {
                  return Text('Error...');
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.blue,
                              size: 60,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Select a lot'),
                            )
                          ],
                        ),
                      );
                      break;
                    case ConnectionState.waiting:
                      return Center(
                        heightFactor: 5.0,
                        child: Column(
                          children: [
                            SizedBox(
                              child: const CircularProgressIndicator(),
                              width: 50,
                              height: 50,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting Data...'),
                            )
                          ],
                        ),
                      );
                      break;
                    case ConnectionState.active:
                      return buildBody01(context, area);

                      break;
                    default:
                      print(snapshot.connectionState.toString());
                      return Text("No data");
                  }
                }
              },
            ))
          ],
        )));
  }
}
