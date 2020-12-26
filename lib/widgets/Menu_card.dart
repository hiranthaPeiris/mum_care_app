import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mun_care_app/helpers/Constants.dart';

class Menu_card extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  final String heading;
  const Menu_card({Key key, this.svgSrc, this.title, this.press, this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       //padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 7,
            spreadRadius: 4,
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Text(
                  heading,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                Spacer(),
                SvgPicture.asset(svgSrc),
                Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
