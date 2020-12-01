import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:url_launcher/url_launcher.dart';

class GeoLocation extends StatefulWidget {
  @override
  _GeoLocationState createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {
  double latitudeData;
  double longitiduData;
  //Address _address;

  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudeData = geoposition.latitude;
      longitiduData = geoposition.longitude;
      //final coordinates=new Coordinates(geoposition.latitude,geoposition.longitude);
      //convertCoordinatesToAddress(coordinates).then((value)=>_address=value);
    });
  }

  static Future<void> openMap(double lat, double lon) async {
    String googleUrl = 'http://google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Location"),
      ),
      body: Column(
        children: [
          Text(latitudeData.toString()),
          Text(longitiduData.toString()),
          FlatButton(
              onPressed: () {
                openMap(latitudeData, longitiduData);
              },
              child: Text("Press"))

          //Text("${_address?.addressLine?? '-'}"),
        ],
      ),
    );
  }
}

Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
  var addreses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  return addreses.first;
}