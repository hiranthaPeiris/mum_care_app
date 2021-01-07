import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/Notification.model.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/services/NotificationService.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  NotificationService _notificationService = NotificationService();
  NotificationM _selectedNotific;
  bool show404 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Bottom_nav(),
        body: Container(
          child: FutureBuilder<List<NotificationM>>(
            future: _notificationService.getNotifications(),
            builder: (BuildContext context,
                AsyncSnapshot<List<NotificationM>> asyncSnapshot) {
              Widget widget;
             
              if (asyncSnapshot.hasData) {
                widget = Navigator(
                  pages: [
                    MaterialPage(
                        child: NotificationListScreen(
                      onTapped: _handleTapped,
                      notificationList: asyncSnapshot.data,
                    )),
                    if (show404)
                      MaterialPage(
                          child: ErrorView(errorMsg: "page error 404"),
                          key: ValueKey("notificationList"))
                    else if (_selectedNotific != null)
                      NotificationDetailsPage(_selectedNotific)
                  ],
                  onPopPage: (route, result) {
                    if (!route.didPop(result)) {
                      return false;
                    }
                    setState(() {
                      _selectedNotific = null;
                    });
                    return true;
                  },
                );
              } else if (asyncSnapshot.hasError) {
                widget = Center(
                  heightFactor: 2.0,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                            'Result: ${asyncSnapshot.hasError.toString()}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error on getting notifications'),
                      )
                    ],
                  ),
                );
              } else {
                widget = Loading();
              }
              return widget;
            },
          ),
        ));
  }

  void _handleTapped(NotificationM notification) {
    // setState(() {
    //   _selectedNotific = nofication;
    // });
    String type = notification.type;
    switch (type) {
      case "home":
        Navigator.pushNamed(context, '/viewupcominghomevisit');
        break;
      case "clinic":
        Navigator.pushNamed(context, '/UpcomingClinics');
        break;
      case "reg":
        Navigator.pushNamed(context, '/profile');
        break;
      case "notice":
        openBottomSheet(context, notification);
        break;
      case "MidLeave":
        openBottomSheet(context, notification);
        break;
      default:
        Navigator.pushNamed(context, '/error');
    }
  }

  void openBottomSheet(BuildContext cont, NotificationM notification) {
    showModalBottomSheet(
        context: cont,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 500.0,
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
                                      "Special Notice",
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
                                SizedBox(
                                  height: 30.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Text("${notification.body}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                        Text("Description: ${notification.body}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Received on: ${notification.dateTime.toString()}",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                      ],
                    )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Thank you,",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    Container(
                      child: FlatButton(
                        child: Text(
                          "Okay",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class NotificationListScreen extends StatelessWidget {
  final List<NotificationM> notificationList;
  final ValueChanged<NotificationM> onTapped;

  NotificationListScreen(
      {@required this.notificationList, @required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: kBackground,
      ),
      body: ListView(
        children: [
          for (var notifc in notificationList)
            ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(Icons.medical_services),
                ),
                title: Text(notifc.title),
                subtitle: Text(notifc.topicDate,
                    style: TextStyle(color: Colors.black26)),
                onTap: () => onTapped(notifc))
        ],
      ),
    );
  }
}

class NotificationDetailsPage extends Page {
  final NotificationM notification;

  NotificationDetailsPage(this.notification);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) {
          final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
          final curveTween = CurveTween(curve: Curves.easeInOut);
          return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: NotificationDetailsScreen(
                  key: ValueKey(notification), notification: notification));
        });
  }
}

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationM notification;

  const NotificationDetailsScreen({Key key, this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          (notification != null)
              ? {
                  Text(notification.title,
                      style: Theme.of(context).textTheme.headline5),
                  Text(
                    notification.body,
                    style: TextStyle(color: Colors.black26),
                  ),
                  Text(
                    notification.topicDate,
                    style: TextStyle(color: Colors.black26),
                  ),
                  Text(
                    notification.topicRef,
                    style: TextStyle(color: Colors.black26),
                  )
                }
              : SizedBox(
                  height: 10.0,
                )
        ],
      ),
    );
  }
}
