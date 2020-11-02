import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/MessageStream.dart';

class FirebaseMessageWapper extends StatefulWidget {
  final Widget child;

  FirebaseMessageWapper(this.child);

  @override
  _FirebaseMessageWapperState createState() => _FirebaseMessageWapperState();
}

class _FirebaseMessageWapperState extends State<FirebaseMessageWapper> {
  MessageStream _messageStream = MessageStream.instance;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: null,
        stream: _messageStream.messageStream,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          Map<String, dynamic> msg = snapshot.data;
          if (msg != null) {
            // check if this instance is the current route or else message will be displayed on all instances
            if (ModalRoute.of(context).isCurrent) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _showMessage(msg));
            }
            // adding a null stops the previous message from being displayed again
            MessageStream.instance.addMessage(null);
          }
          return widget.child;
        });
  }

  void _showMessage(Map<String, dynamic> message) {
    SnackBar bar = SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 10),
      action: SnackBarAction(
        label: "Close",
        textColor: Colors.redAccent,
        onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
      ),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(message['notification']["title"]),
            Text(message['notification']["body"]),
          ],
        ),
      ),
    );

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(bar);
  }
}
