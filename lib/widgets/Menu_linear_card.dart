import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mun_care_app/helpers/Constants.dart';

class Menu_liner_card extends StatelessWidget {
  final String svgSrc;
  final String content;
  final String heading;
  final Function press;

  const Menu_liner_card(
      {Key key, this.svgSrc, this.content, this.heading, this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        padding: EdgeInsets.all(14),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/important.svg",
              height: 40,
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    content,
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/icons/arrow.svg",
                    height: 20,
                    width: 40,
                    color: Colors.black26,
                  ),
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 17,
                spreadRadius: -23,
                color: kShadowColor,
              ),
            ]),
      ),onTap: press,
    );
  }
}
