import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/UserM.dart';

class ChatScreen extends StatefulWidget {
  final String userID;

  ChatScreen({this.userID});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserM user = new UserM.get();
  String chatID;
  String mTime;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool pending = true;
  // ignore: must_call_super
  void initState() {
    super.initState();
    user.userCustomData['role'] == 'midwife'
        ? chatID = _auth.currentUser.uid + widget.userID
        : chatID = widget.userID + _auth.currentUser.uid;

    print(user.userCustomData['role']);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = new TextEditingController();
    //String chatID = _auth.currentUser.uid + widget.userID;
    void onSendMessage(String content) {
      // type: 0 = text, 1 = image, 2 = sticker
      if (content.trim() != '') {
        textEditingController.clear();

        var documentReference = FirebaseFirestore.instance
            .collection('messages')
            .doc(chatID)
            .collection(chatID)
            .doc(DateTime.now().millisecondsSinceEpoch.toString());

        FirebaseFirestore.instance.runTransaction((transaction) async {
          await transaction.set(
            documentReference,
            {
              'idFrom': _auth.currentUser.uid,
              'idTo': widget.userID,
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'content': content,
              'chatId': chatID,
            },
          );
        });
        // listScrollController.animateTo(0.0,
        //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      } else {
        //Fluttertoast.showToast(msg: 'Nothing to send');
      }
    }

    _buildMessageComposer() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 70.0,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo),
              iconSize: 25.0,
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: textEditingController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {},
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message...',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                onSendMessage(textEditingController.text.toString());
              },
            ),
          ],
        ),
      );
    }

    _buildMessage(String message, bool isMe, String time) {
      final Container msg = Container(
        margin: isMe
            ? EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 80.0,
              )
            : EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              time,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              message,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
      if (isMe) {
        return msg;
      }
      return Row(
        children: <Widget>[
          msg,
        ],
      );
    }

    Widget getDetails(BuildContext context) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userID)
            .snapshots(),
        builder: (context, snapshot) {
          var value = snapshot.data;
          if (!snapshot.hasData) {
            return Loading();
          }
          String name = value['name'].toString();
          print(name);
          //print(_auth.currentUser.uid);
          if (snapshot.hasData) {
            return Text(
              name,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        },
      );
    }

    String readTimestamp(int timestamp) {
      var now = new DateTime.now();
      var format = new DateFormat('HH:mm a');
      var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
      var diff = date.difference(now);
      var time = '';

      if (diff.inSeconds <= 0 ||
          diff.inSeconds > 0 && diff.inMinutes == 0 ||
          diff.inMinutes > 0 && diff.inHours == 0 ||
          diff.inHours > 0 && diff.inDays == 0) {
        time = format.format(date);
      } else {
        if (diff.inDays == 1) {
          time = diff.inDays.toString() + 'DAY AGO';
        } else {
          time = diff.inDays.toString() + 'DAYS AGO';
        }
      }

      return time;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: getDetails(context),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('messages')
                        .doc(chatID)
                        .collection(chatID)
                        .orderBy('timestamp', descending: true)
                        .limit(150)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Loading();
                      } else {
                        ///listMessage = snapshot.data.documents;
                        return ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) {
                            final String message =
                                snapshot.data.documents[index]['content'];
                            final int mTimeStamp =
                                snapshot.data.documents[index]['timestamp'];
                            final bool isMe = snapshot.data.documents[index]
                                    ['idFrom'] ==
                                _auth.currentUser.uid;

                            return _buildMessage(
                                message, isMe, readTimestamp(mTimeStamp));
                          },
                          itemCount: snapshot.data.documents.length,
                          reverse: true,
                          //controller: listScrollController,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
