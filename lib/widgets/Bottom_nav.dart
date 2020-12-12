import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/models/Notification.model.dart';
import 'package:mun_care_app/services/NotificationService.dart';

class Bottom_nav extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final NotificationService _notification = NotificationService();
  Bottom_nav({Key key, this.scaffoldKey}) : super(key: key);

  void _openDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Today",
            svgScr: "assets/icons/calendar.svg",
            press: () async {
              // NotificationM notification = NotificationM("New Clinic assigned",
              //     "desc", "dateTime", "doc.id", new DateTime.now(), "home");

              // Response rst = await _notification.sendMessageTopic(
              //     notification.getMap(), "midwife1");
              // print(rst.body);
            },
          ),
          BottomNavItem(
            title: "Menu",
            svgScr: "assets/icons/menu-bottom.svg",
            isActive: true,
            press: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/dashboard', ModalRoute.withName('/'));
            },
          ),
          BottomNavItem(
            title: "Settings",
            svgScr: "assets/icons/Settings.svg",
            press: _openDrawer,
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            svgScr,
            width: 25,
            height: 25,
            color: isActive ? kActiveIconColor : kMenuTextColor,
          ),
          Text(
            title,
            style:
                TextStyle(color: isActive ? kActiveIconColor : kMenuTextColor),
          ),
        ],
      ),
    );
  }
}
