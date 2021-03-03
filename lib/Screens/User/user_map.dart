import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gsc_project/constants.dart';
import 'package:location/location.dart';

void main() => runApp(UserReportMap());

class UserReportMap extends StatefulWidget {
  @override
  _UserReportMapState createState() => _UserReportMapState();
}

class _UserReportMapState extends State<UserReportMap> {
  GoogleMapController mapController;

  LocationData currentLocation;
  Location location;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    location = new Location();

    location.onLocationChanged().listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
    });

    setInitialLocation();
  }

  void setInitialLocation() async {
    try {
      currentLocation = await location.getLocation();
    } on Exception catch (_) {
      currentLocation = const LatLng(45.521563, -122.677433) as LocationData;
    }
  }

  // TODO update pin on the map
  void updatePinOnMap() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // title: Text('Your city's name'),
          backgroundColor: kPrimaryColor,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 25.0,
          ),
        ),
      ),
    );
  }
}
