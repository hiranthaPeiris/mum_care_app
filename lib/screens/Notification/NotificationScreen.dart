import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/models/Notification.model.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/widgets/Bottom_nav.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  NotificationM _selectedNotific;
  bool show404 = false;

  List<NotificationM> notifications = [
    NotificationM("Test header1", "test Content 1", new DateTime(2000)),
    NotificationM("Test header2", "test Content 2", new DateTime(2001)),
    NotificationM("Test header3", "test Content 3", new DateTime(2001)),
    NotificationM("Test header4", "test Content 4", new DateTime(2002)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: Bottom_nav(),
      body: Navigator(
        pages: [
          MaterialPage(
              child: NotificationListScreen(
            onTapped: _handleTapped,
            notificationList: notifications,
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
      ),
    );
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
      appBar: AppBar(backgroundColor: kBackground,),
      body: ListView(
        children: [
          for (var notifc in notificationList)
            ListTile(
                title: Text(notifc.header),
                subtitle: Text(notifc.content),
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
          Text(notification.content,
              style: Theme.of(context).textTheme.bodyText2)
        ],
      ),
    );
  }
}
