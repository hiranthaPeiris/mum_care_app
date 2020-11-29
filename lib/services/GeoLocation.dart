import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
class GeoLocation extends StatefulWidget {
  @override
  _GeoLocationState createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {
  String latitudeData = "";
  String longitiduData = "";
  Address _address;

  void initState() {
    super.initState();
    getCurrentLocation();

    
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudeData = '${geoposition.latitude}';
      longitiduData = '${geoposition.longitude}';
      //final coordinates=new Coordinates(geoposition.latitude,geoposition.longitude);
      //convertCoordinatesToAddress(coordinates).then((value)=>_address=value);
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
          //Text("${_address?.addressLine?? '-'}"),
        ],
      ),
    );
  }
}
Future<Address>convertCoordinatesToAddress(Coordinates  coordinates) async{
  var addreses= await Geocoder.local.findAddressesFromCoordinates(coordinates);
  return addreses.first;
}