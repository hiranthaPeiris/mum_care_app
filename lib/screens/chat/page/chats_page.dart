import 'package:mun_care_app/screens/chat/api/firebase_api.dart';
import 'package:mun_care_app/screens/chat/model/user.dart';
import 'package:mun_care_app/screens/chat/widget/chat_body_widget.dart';
import 'package:mun_care_app/screens/chat//widget/chat_header_widget.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.blue,
    body: SafeArea(
      child: StreamBuilder<List<User>>(
        stream: FirebaseApi.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return buildText('Something Went Wrong ');
              } else {
                final users = snapshot.data;

                if (users.isEmpty) {
                  return buildText('No Users Found');
                } else
                  return Column(
                    children: [
                      ChatHeaderWidget(users: users),
                      ChatBodyWidget(users: users)
                    ],
                  );
              }
          }
        },
      ),
    ),
  );

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}
