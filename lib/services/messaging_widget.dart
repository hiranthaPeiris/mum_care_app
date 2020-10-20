import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/models/message.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Notifications';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MainPage(appTitle: appTitle),
    );
  }
}
class MainPage extends StatelessWidget{
  final String appTitle;
  const MainPage({this.appTitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: MessagingWidget(),
    );
  }
}



class MessagingWidget extends StatefulWidget{
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class  _MessagingWidgetState extends State<MessagingWidget>{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message>message = [];
  String title = "Title";
  String body = "body";

  void initState(){
  super.initState();
  _firebaseMessaging.configure(
    onMessage: (Map<String,dynamic>message) async{
    print("onMessage: $message");
    final notification = message['notification'];
    setState(() {
       title = message['notification']['title'];
       body = message['notification']['body'];

    });
  },
    onLaunch: (Map<String,dynamic>message) async{
      print("onLaunch: $message");

    },
    onResume: (Map<String,dynamic>message) async{
      print("onResume: $message");
      },
  );

  _firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true,badge: true,alert: true)
  );
}
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: message.map(buildMessage).toList(),
    );
  }
  Widget buildMessage(Message message){
    return ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
    );
  }
}