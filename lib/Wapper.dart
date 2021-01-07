import 'package:flutter/material.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/Authentication/Authentication.dart';
import 'package:mun_care_app/screens/Dashboard/Dashboard.dart';
import 'package:provider/provider.dart';

class Wapper extends StatefulWidget {
  @override
  _WapperState createState() => _WapperState();
}

class _WapperState extends State<Wapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Dashboard();
    }
  }
}
