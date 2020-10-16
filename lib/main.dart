import 'package:flutter/material.dart';
import 'package:mun_care_app/RouteGenerator.dart';
import 'package:mun_care_app/screens/Dashboard/Dashboard.dart';
import 'package:mun_care_app/screens/login/Login_comp.dart';

import 'helpers/Constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mun & Baby',
      theme: ThemeData(
        fontFamily: "Roboto",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
