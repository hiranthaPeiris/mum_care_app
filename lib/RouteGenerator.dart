import 'package:flutter/material.dart';
import 'package:mun_care_app/screens/Dashboard/Dashboard.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/screens/Notification/NotificationScreen.dart';
import 'package:mun_care_app/screens/Signup/Signup.dart';
import 'package:mun_care_app/screens/login/Login_comp.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginComp());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/signup':
        return MaterialPageRoute(builder: (_) => Signup());
      case '/notification':
        return MaterialPageRoute(builder: (_)=> NotificationScreen());
      case '/error':
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: "Direct Route"));
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: 'Default Route'));
    }
  }
}
