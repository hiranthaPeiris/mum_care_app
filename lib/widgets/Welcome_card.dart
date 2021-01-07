import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';

class WelcomeCard extends StatelessWidget {
  final String title_1;
  final String title_2;
  WelcomeCard({this.title_1, this.title_2});

  @override
  Expanded build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(30.0),
                color: kBackgrount2),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(title_1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left),
                  Text(title_2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left),
                ],
              ),
            ),
          ),
        ));
  }
}
