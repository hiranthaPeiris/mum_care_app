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
                widget = Column(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Result: ${asyncSnapshot.data}'),
                    )
                  ],
                );
              } else {
                widget = Loading();
              }
              return widget;
            },
          ),
        ));
  }

  void _handleTapped(NotificationM nofication) {
    setState(() {
      _selectedNotific = nofication;
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
        backgroundColor: kBackground,
      ),
      body: ListView(
        children: [
          for (var notifc in notificationList)
            ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                title: Text(notifc.header),
                subtitle: Text(notifc.content,
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
          if (notification != null)
            Text(notification.header,
                style: Theme.of(context).textTheme.headline5),
          Text(
            notification.content,
            style: TextStyle(color: Colors.black26),
          )
        ],
      ),
    );
  }
}
