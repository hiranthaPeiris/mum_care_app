import 'package:flutter/material.dart';
import 'package:mun_care_app/screens/chat/setUsers.dart';
import 'package:mun_care_app/widgets/categoryslector.dart';


class HomeChat extends StatefulWidget {
  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      //bottomNavigationBar: Bottom_nav(),
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
         // SetChatUser(),
          CategorySelector(),
          SetChatUser(),
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).accentColor,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(20.0),
          //         topRight: Radius.circular(20.0),
          //       ),
          //     ),
          //     child: Column(
          //       children: <Widget>[
          //         SetChatUser(),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
