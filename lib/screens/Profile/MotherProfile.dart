import 'package:flutter/material.dart';

class MotherProfile extends StatefulWidget {
  MotherProfile({Key key}) : super(key: key);

  @override
  _MotherProfileState createState() => _MotherProfileState();
}

class _MotherProfileState extends State<MotherProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )),
              width: MediaQuery.of(context).size.width,
              height: 110.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 50.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Mother Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
