import 'package:flutter/material.dart';
import 'package:mun_care_app/screens/login/Login_comp.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return LoginComp();
  }
}
