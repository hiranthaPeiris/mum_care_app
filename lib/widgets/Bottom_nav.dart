import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/helpers/Constants.dart';

class Bottom_nav extends StatelessWidget {
  const Bottom_nav({
    Key key,
  }) : super(key: key);
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
          ),
          BottomNavItem(
            title: "Menu",
            svgScr: "assets/icons/menu-bottom.svg",
            isActive: true,
            press: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          BottomNavItem(
            title: "Settings",
            svgScr: "assets/icons/Settings.svg",
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
    return GestureDetector(
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
