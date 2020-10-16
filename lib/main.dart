import 'package:flutter/material.dart';
import 'package:mun_care_app/screens/registration/ComFamReg01.dart';
import 'package:mun_care_app/screens/registration/ComFamReg02.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ComFamReg(),
    );
  }
}
