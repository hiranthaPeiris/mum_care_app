import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mun_care_app/helpers/Constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Container(
        child: Center(
          child: SpinKitCubeGrid(
            color: kActiveIconColor,
          ),
        ),
      ),          
    );
  }
}
