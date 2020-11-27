import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class GeoLocation extends StatefulWidget {
  @override
  _GeoLocationState createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {
  String latitudeData = "";
  String longitiduData = "";

  void initState() {
    super.initState();
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudeData = '${geoposition.latitude}';
      longitiduData = '${geoposition.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Location"),
      ),
      body: Column(
        children: [
          Text(latitudeData),
          Text(longitiduData),
        ],
      ),
    );
  }
}
