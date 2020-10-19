import 'package:flutter/material.dart';
import 'package:mun_care_app/Wapper.dart';
import 'package:mun_care_app/screens/Authentication/Authentication.dart';
import 'package:mun_care_app/screens/Dashboard/Dashboard.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/screens/Notification/NotificationScreen.dart';
import 'package:mun_care_app/screens/Profile/Profile.dart';
import 'package:mun_care_app/screens/Signup/Signup.dart';
import 'package:mun_care_app/screens/login/Login_comp.dart';
import 'package:mun_care_app/screens/registration/ComFamReg.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Wapper());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/comReg':
        return MaterialPageRoute(builder: (_) => ComFamReg());
      case '/signup':
        return MaterialPageRoute(builder: (_) => Signup());
      case '/notification':
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/error':
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: "Direct Route"));
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: 'Default Route'));
    }
  }
}
